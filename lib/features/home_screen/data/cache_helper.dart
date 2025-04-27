import 'dart:convert';
import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<void> saveBookList(String key, List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        books.map((book) => json.encode(book.toJson())).toList();
    await prefs.setStringList(key, jsonList);
  }

  static Future<List<Book>> getBookList(String key, void Function() fun) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(key);
    if (jsonList == null) {
      fun();
      return [];
    }

    return jsonList.map((item) => Book.fromJson(json.decode(item))).toList();
  }

//favorites book list
  static const String favoritesKey = 'favorite_books';

  static Future<void> addBookToFavorites(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesKey) ?? [];

    final bookJson = json.encode(book.toJson());

    if (!favorites.contains(bookJson)) {
      favorites.add(bookJson);
      await prefs.setStringList(favoritesKey, favorites);
    }
  }

  static Future<void> removeBookFromFavorites(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesKey) ?? [];

    final bookJson = json.encode(book.toJson());

    favorites.remove(bookJson);
    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<List<Book>> getFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesKey) ?? [];
   
    return favorites.map((item) => Book.fromJson(json.decode(item))).toList();
  }

  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(favoritesKey);
  }

  static Future<bool> isBookFavorite(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesKey) ?? [];

    final bookJson = json.encode(book.toJson());

    return favorites.contains(bookJson);
  }
}
