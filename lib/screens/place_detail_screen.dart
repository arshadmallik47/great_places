import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/place-detail';
  const PlaceDetailScreen({super.key});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectPlace = Provider.of<GreatPlaceProvider>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectPlace.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectPlace.location!.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            child: const Text(
              'View on Map',
              style: TextStyle(color: Colors.indigo),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectPlace.location!,
                    isSelecting: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
