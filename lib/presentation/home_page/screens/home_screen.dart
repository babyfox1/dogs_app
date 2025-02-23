import 'package:flutter/material.dart';

import 'package:dogs_app/data/models/dogs_data_model.dart';
import 'package:dogs_app/data/repositories/get_dogs_image_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DogsApp'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: GetDogsImageRepository().getDogsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data is DogsDataModel) {
                      return SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: Image.network(
                          snapshot.data?.message ?? '',
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            size: 100,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      return Text(snapshot.data);
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                    Colors.amber,
                  )),
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.refresh,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
