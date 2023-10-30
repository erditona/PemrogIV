import 'package:flutter/material.dart';
import 'package:praktikum_p4/detail_screen.dart';
import 'package:praktikum_p4/model/tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempat Wisata Bandung'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(place: place);
              }));
            },
            child: Card(
              elevation: 5, // Menambahkan bayangan
              margin: const EdgeInsets.all(10), // Memberikan jarak antara Card
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15.0), // Mengatur sudut Card
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        place.imageAsset,
                        fit: BoxFit.cover,
                        height: 150, // Sesuaikan tinggi gambar
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            place.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight:
                                  FontWeight.bold, // Menambahkan ketebalan teks
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            place.location,
                            style: TextStyle(
                              color: Colors.grey, // Mengubah warna teks
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: tourismPlaceList.length,
      ),
    );
  }
}
