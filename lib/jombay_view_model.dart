import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:jombay/service_locator.dart";
import "jombay_model.dart";

class JombayViewModel with ChangeNotifier{
  RickAndMortyResponse? jombayData;
  List<Character>? jombayCharacters = [];
  CharacterDetails? jombayDetails;
  VoidCallback? navigateToDetail;

  bool loading = false;

  final dio = Dio();

  Future<void> getJombayList() async {
    loading = true;
    notifyListeners();
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character');
      jombayData = RickAndMortyResponse.fromJson(response.data);
      jombayCharacters = jombayData?.results;
      notifyListeners();
    } catch (error) {
      // Handle errors here if needed
      print("Error fetching data: $error");
    } finally {
      loading = false; // Set loading to false after the data has been fetched or in case of error
      notifyListeners();
    }
  }

  Future<void> getJombayDetails(id) async {
    loading = true;
    notifyListeners();
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character/$id');
      jombayDetails = CharacterDetails.fromJson(response.data);
      navigateToDetail?.call();
      notifyListeners();
    } catch (error) {
      // Handle errors here if needed
      print("Error fetching data: $error");
    } finally {
      loading = false; // Set loading to false after the data has been fetched or in case of error
      notifyListeners();
    }
  }

}

final jombayProvider = ChangeNotifierProvider((ref) {
  return serviceLocator.get<JombayViewModel>();
});