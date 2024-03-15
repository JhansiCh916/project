import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jombay/character_details.dart';
import 'package:jombay/service_locator.dart';
import 'jombay_view_model.dart';

class JombayList extends StatefulWidget {
  const JombayList({Key? key}) : super(key: key);

  @override
  State<JombayList> createState() => _JombayListState();
}

class _JombayListState extends State<JombayList> {
  final viewModel = serviceLocator.get<JombayViewModel>();

  @override
  void initState() {
    viewModel.getJombayList();
    registerEvents();
    super.initState();
  }

  void registerEvents() {
    viewModel.navigateToDetail = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CharacterDetails()));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer(builder: (context, ref, child) {
        final dataProvider = ref.watch(jombayProvider);
        final data = dataProvider.jombayCharacters;
        return dataProvider.loading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        dataProvider.getJombayDetails(data[index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                                child: Image.network(
                                  width: 100,
                                  height: 170,
                                  data![index].image,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "● ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Text(data[index].status,
                                        style:
                                            const TextStyle(color: Colors.white)),
                                    const Text(" - ",
                                        style: TextStyle(color: Colors.white)),
                                    Text(data[index].species,
                                        style:
                                            const TextStyle(color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("Last known location:"),
                                Text(data[index].location.name,  style:
                                const TextStyle(color: Colors.white)),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("First seen in:"),
                                Text(data[index].origin.name,  style:
                                const TextStyle(color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
  }
}
