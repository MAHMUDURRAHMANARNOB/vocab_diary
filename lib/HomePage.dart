import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vocabulary_app/ApiController.dart';

import 'dataModel/wordMeaningDataModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  WordMeaningDataModel? wordMeaningDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchWidget(),
              const SizedBox(
                height: 10.0,
              ),
              if (inProgress)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: const CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                )
              else if (wordMeaningDataModel != null)
                Expanded(child: _buildResponseWidget())
              else
                _noDataWidget("Welcome\nStart Learning New Words")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: const Icon(Icons.search),
      ),
      hintText: "Search Your Word",
      onSubmitted: (value) {
        //get meaning from API
        _getMeaningFromApi(value);
      },
    );
  }

  _getMeaningFromApi(String word) async {
    setState(() {
      inProgress = true;
    });
    try {
      wordMeaningDataModel = await ApiController.fetchWordMeaning(word);
    } catch (e) {
      wordMeaningDataModel = null;
      print(e.toString());
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  Widget _buildResponseWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wordMeaningDataModel!.word ?? "",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            wordMeaningDataModel?.phonetic ?? "",
            style: TextStyle(
              color: Colors.lightGreen,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildMeaningWidget(
                  wordMeaningDataModel!.meanings![index],
                );
              },
              itemCount: wordMeaningDataModel!.meanings?.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeaningWidget(Meaning meaning) {
    String definationList = '';
    meaning.definitions?.forEach(
      (_element) {
        int? index = meaning.definitions?.indexOf(_element);
        definationList += "\n${index! + 1}. ${_element.definition}\n";
      },
    );
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.partOfSpeech!,
              style: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.0),
            Text("Definations:"),
            Text(definationList),
            _buildSet("Synonyms", meaning.synonyms),
            SizedBox(height: 6.0),
            _buildSet("Antonyms", meaning.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          // Text("$title"),
          SizedBox(height: 10.0),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
          ),
          SizedBox(height: 10.0),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _noDataWidget(String text) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
