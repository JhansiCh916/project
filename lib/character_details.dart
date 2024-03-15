import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jombay/jombay_view_model.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({super.key});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ref, child) {
      final detailProvider = ref.watch(jombayProvider);
      return Scaffold(
        appBar: AppBar(
          title: Text(detailProvider.jombayDetails!.id.toString()),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ClipRRect(
                child: Image.network(
              width: 100,
              height: 170,
              detailProvider.jombayDetails!.image,
              fit: BoxFit.fill,
            )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Name:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Status:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.status,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Species:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.species,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Gender:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.gender,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Origin:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.origin.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Location:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.location.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "No. Of Episodes:  ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  detailProvider.jombayDetails!.episode.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Episodes",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > 560 ? 3 : 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: detailProvider.jombayDetails?.episode.length,
                itemBuilder: (context, index) {
                  final episodeUrl = detailProvider.jombayDetails?.episode[index];
                  final episodeNumber = int.parse(episodeUrl!.split('/').last);
                  return Card(
                    child: Center(
                      child: Text('Episode $episodeNumber'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
