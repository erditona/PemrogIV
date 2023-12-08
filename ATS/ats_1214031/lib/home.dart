import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => MyHomes();
}

class MyHomes extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero
          Card(
            elevation: 5.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVvKDQM_6JqYmDf0jQMupEPMAy1u9kt2ngjjwLIvHA2YCoNWDVRBEFq7F9YI27Cv4aaXiQdN_pQGSUfow_92sujVOi-gsAVVSeTw8fGokdo1IxnFjJj3vC5cRNyGbKYq03n_y5JTxspng6_a22bL6D4pq1m8LyUUi29Yi7FtsIoV-t74QXPIdhQJ9h/s0/LOGO%20ULBI%20-%20WIDE%20DARK.png',
                  height: 100,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          // Paragraf welcoming speech
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Selamat Datang di Contactku ULBI',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Jelajahi fitur-fitur menarik yang kami sediakan dan jangan ragu untuk memberi masukan kepada kami.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          // Profile
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://instagram.fbdo9-1.fna.fbcdn.net/v/t51.2885-19/323831956_1362896911138449_8223935407395191299_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fbdo9-1.fna.fbcdn.net&_nc_cat=109&_nc_ohc=Ylm3MwUA9mIAX83TZ2C&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAdAcf0K7hRqtno0veiMcwszQkBjlgGiLqY5aedyPKiiw&oe=655BCD12&_nc_sid=ee9879',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ERDITO NAUSHA ADAM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'NPM: 1214031',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Kelas: D4TI 3B',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyHome(),
  ));
}
