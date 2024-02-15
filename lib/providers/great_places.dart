import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  // get items
  List<PlaceModel> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
