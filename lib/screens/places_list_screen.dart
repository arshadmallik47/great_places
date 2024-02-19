import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaceProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaceProvider>(
                builder: (ctx, greatPlaces, _) {
                  if (greatPlaces.items.isEmpty) {
                    return const Center(
                      child: Text('Got no places yet, start adding some!'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: greatPlaces.items.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            greatPlaces.items[index].image,
                          ),
                        ),
                        title: Text(
                          greatPlaces.items[index].title,
                        ),
                        subtitle: Text(
                            greatPlaces.items[index].location!.address ?? ''),
                        onTap: () {
                          // ....go to detail page
                        },
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
