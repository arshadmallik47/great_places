import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  // get items
  List<PlaceModel> get items {
    return [..._items];
  }
}
