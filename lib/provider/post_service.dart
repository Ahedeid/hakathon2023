

import 'package:flutter/widgets.dart';

import '../model/post_model.dart';


class PostService extends ChangeNotifier{

   final List<PostDescription> _note =  <PostDescription>[];
   final List<PostDescription> _favorites = [];

   List<PostDescription> get getNote {
     return _note ;
   }
   List<PostDescription> get getFavorites => _favorites;

   void addNote (String noteDescription){
     PostDescription note = PostDescription(noteDescription);
     _note.add(note);
     notifyListeners();
   }

   void removeItem(int index) {
     _note.removeAt(index);
     notifyListeners();
   }


   void toggleFavorite(PostDescription item) {
     item.isFavorite = !item.isFavorite;

     if (item.isFavorite) {
       _favorites.add(item);
     } else {
       _favorites.remove(item);
     }
      debugPrint(_favorites.toString());
     notifyListeners();
   }

   void removeItemFav(int index) {
     _favorites.removeAt(index);
     notifyListeners();
   }
}