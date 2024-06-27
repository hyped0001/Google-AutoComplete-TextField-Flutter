import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Custom Autocomplete sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title ?? ""),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
textEditingController: controller,                            googleAPIKey:
                                "AIzaSyADWe13-uOSOvHmu7Cza7VPychlYv6fB-A",
                            countries: const ['us'],
                            isLatLngRequired: true,
                            inputDecoration: const InputDecoration(
                              hintText: "Where would you like to run?",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            boxDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(.15),
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            itemClick: (Prediction prediction) {
                              print('item clicked ${prediction.placeId}');
                              _locationController.text =
                                  prediction.description ?? "";
                              _locationController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                offset: prediction.description?.length ?? 0,
                              ));
                              // load new clubs based on Prediction
                              // mapController.animateCamera(
                              //   CameraUpdate.newCameraPosition(
                              //     CameraPosition(
                              //       target: LatLng(
                              //         double.parse(prediction.lat.toString()),
                              //         double.parse(prediction.lng.toString()),
                              //       ),
                              //     ),
                              //   ),
                              // );
                            },
                            seperatedBuilder: const Divider(),
                            containerHorizontalPadding: 10,
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(.15),
                                  ),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        prediction.description ?? "",
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            isCrossBtnShown: true,
                          ),
    );
  }
}
