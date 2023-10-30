import 'package:flutter/material.dart';
import 'package:praktikum_p4/model/tourism_place.dart';

var iniFontCustom = const TextStyle(fontFamily: 'Oswald');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment
                  .topLeft, // Menambahkan alignment untuk tombol kembali
              children: <Widget>[
                // Menambahkan efek transparansi pada gambar latar belakang
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    place.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Menambahkan ikon dan teks dengan animasi
                  _buildDetailItem(Icons.calendar_today, place.openDays),
                  _buildDetailItem(Icons.access_time, place.openTime),
                  _buildDetailItem(
                      Icons.monetization_on_outlined, place.ticketPrice),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(30.0),
              child: Text(
                place.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Oswald',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 32.0),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: iniFontCustom,
        ),
      ],
    );
  }
}
