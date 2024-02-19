import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  // get items
  List<PlaceModel> get items {
    return [..._items];
  }

  PlaceModel findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocaionHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updateLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
