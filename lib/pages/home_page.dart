import 'package:flutter/material.dart';
import 'package:tugas_2/model/cat.dart';
import 'package:tugas_2/pages/detail_page.dart';
import 'package:tugas_2/pages/login_page.dart';
class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<int> favoriteCats = {}; // Menyimpan indeks kucing yang difavoritkan

  void toggleFavorite(int index) {
    setState(() {
      if (favoriteCats.contains(index)) {
        favoriteCats.remove(index);
      } else {
        favoriteCats.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wellcome, ${widget.username}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink[300],
        elevation: 10,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            tooltip: "Logout",
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50] ?? Colors.pink, Colors.pink[100] ?? Colors.pink],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) => _catCard(context, index),
            itemCount: catList.length,
          ),
        ),
      ),
    );
  }

  Widget _catCard(BuildContext context, int index) {
    final cat = catList[index];
    final Map<String, int> age = cat.age;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(index: index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.pink[200] ?? Colors.pink,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(
                      cat.pictureUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error, color: Colors.red, size: 50)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 40, // Ubah sesuai kebutuhan
                    height: 40, // Ubah sesuai kebutuhan
                    decoration: BoxDecoration(
                      color: Colors.white, // Background putih
                      shape: BoxShape.circle, // Bentuk lingkaran
                      border: Border.all(color: Colors.pink[200] ?? Colors.pink, width: 2), // Border pink
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero, // Mengurangi padding default
                      constraints: BoxConstraints(), // Mencegah ukuran default yang lebih besar
                      onPressed: () => toggleFavorite(index),
                      icon: Icon(
                        favoriteCats.contains(index) ? Icons.favorite : Icons.favorite_border,
                        color: favoriteCats.contains(index) ? Colors.red : Colors.pink[200], // Ikon pink sebelum dipencet
                        size: 24, // Ukuran ikon lebih kecil agar sesuai
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                cat.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Age   : ${age['years'] ?? 0} years ${age['months'] ?? 0} months",
              style: TextStyle(fontSize: 12, color: Colors.pink[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "Sex   : ${cat.sex == 'M' ? 'Male' : 'Female'}",
              style: TextStyle(fontSize: 12, color: Colors.pink[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "Breed: ${cat.breed}",
              style: TextStyle(fontSize: 12, color: Colors.pink[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
    );
  }
}
