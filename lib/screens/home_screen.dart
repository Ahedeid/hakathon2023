import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakathon2023/screens/widget/my_textFeild.dart';
import 'package:hakathon2023/screens/widget/sheared_appbar.dart';
import 'package:provider/provider.dart';

import '../model/post_model.dart';
import '../provider/post_service.dart';
import '../utils/colors_manger.dart';
import '../utils/images_constant.dart';
import '../utils/sizes_in_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    String descriptionText = '';
    // var midea = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const ShearedAppBar(),
      body: isLoading == true
          ? Consumer<PostService>(
              builder: (context, note, child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'List of post',
                            style: TextStyle(
                              color: Color(AppColor.primaryTextColor),
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  title: const Text(
                                    'Add Post',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: SizedBox(
                                    height: 240,
                                    child: Column(
                                      children: [
                                        MyTextField(
                                          onChange: (val) {
                                            descriptionText = val;
                                          },
                                          hintText: '',
                                          obscureText: false,
                                          keyboardType: TextInputType.text,
                                          icon: '',
                                          height: 100,
                                          vertical: 100,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all()),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text('Upload your image'),
                                                const SizedBox(height: 5),
                                                SvgPicture.asset(
                                                    ImageConstant.cloud),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  'Drage and drop or browse to choose a file',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Color(AppColor.buttonColor),
                                        ),
                                      ),
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(
                                          color:
                                              Color(AppColor.primaryTextColor),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Provider.of<PostService>(context,
                                                listen: false)
                                            .addNote(descriptionText);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(AppColor.buttonColor),
                                      ),
                                      child: const Text('OPEN'),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(AppColor.buttonColor)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                            itemCount: note.getNote.length,
                            itemBuilder: (context, index) {
                              final itemsKey = note.getNote[index].toString();
                              final items = note.getNote[index];
                              return PostCard(
                                item: itemsKey,
                                noteShow: items,
                                onDismissed: (direction) {
                                  note.removeItem(index);
                                  note.removeItemFav(index);
                                },
                                onTapFav: () {
                                  note.toggleFavorite(items);
                                  debugPrint('ok');
                                },
                                isFav: items.isFavorite,
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageConstant.logo),
                  const SizedBox(height: 5),
                  const Text(
                    'Empty Post',
                    style: TextStyle(
                      fontSize: AppSizes.sizeTextEmptyNote,
                      color: Color(AppColor.primaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class PostCard extends StatelessWidget {
  PostCard({
    super.key,
    required this.item,
    required this.noteShow,
    this.onDismissed,
    this.onTapFav,
    this.isFav,
  });

  final PostDescription noteShow;

  void Function(DismissDirection)? onDismissed;
  final String item;
  void Function()? onTapFav;
  bool? isFav;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(ImageConstant.logo),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mohammed Ahmed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  noteShow.note,
                  softWrap: false,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(AppColor.primaryTextColor),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Color(AppColor.buttonColor),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: Color(AppColor.buttonColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// return Dismissible(
//   onDismissed: onDismissed,
//   direction: DismissDirection.endToStart,
//   confirmDismiss: (DismissDirection direction) async {
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           backgroundColor: const Color(AppColor.backGroundBottomSheet),
//           title: const Text(
//             'Confirm',
//             style: TextStyle(
//               color: Color(AppColor.tealColor),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you wish to delete this note?',
//             style: TextStyle(
//               color: Color(AppColor.primaryTextColor),
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('CANCEL'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(AppColor.tealColor),
//               ),
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('DELETE'),
//             ),
//           ],
//         );
//       },
//     );
//   },
//   key: Key(item),
//   background: Container(
//     height: 50,
//     width: 50,
//     decoration: const BoxDecoration(color: Colors.red),
//     child: const Icon(Icons.delete),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10),
//     child: Container(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       border: Border.all(
//         color: Colors.grey
//       )
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           radius: 20,
//           backgroundColor: Colors.white,
//           child: SvgPicture.asset(ImageConstant.logo),
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,color: Color(AppColor.buttonColor),)),
//             // IconButton(onPressed: (){}, icon: const Icon(Icons.share,color: Color(AppColor.buttonColor),)),
//           ],
//         ),
//         title: const Text(
//           'Mohammed Ahmed',
//           style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//         ),
//         subtitle:Text(
//           noteShow.note,
//           style: const TextStyle(fontSize: 18,color: Color(AppColor.primaryTextColor)),
//         ),
//
//       ),
//     ),
//   ),
// );
