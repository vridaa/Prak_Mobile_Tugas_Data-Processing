import 'package:flutter/material.dart';
import 'package:tugas_2/model/cat.dart';

class DetailPage extends StatefulWidget {
  final int index;
  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    final cat = catList[widget.index];
    final age = cat.age; // Ambil umur dalam tahun dan bulan

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail of cat"),
        backgroundColor: Colors.pink[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              cat.pictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cat.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              ],
          ),
          SizedBox(height: 16),

          // Informasi kucing
          Text(
            "Breed  : ${cat.breed}",
            style: TextStyle(fontSize: 16, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Text(
            "Color  : ${cat.color}",
            style: TextStyle(fontSize: 16, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Text(
            "Sex     : ${cat.sex == 'M' ? 'Male' : 'Female'}",
            style: TextStyle(fontSize: 16, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Text(
            "Age    : ${age['years']} years ${age['months']} months",
            style: TextStyle(fontSize: 16, color: Colors.pink[800]),
          ),
          SizedBox(height: 16),

          // Daftar vaksin
          Text(
            "Vaccines:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: cat.vaccines.map((vaccine) {
              return Chip(
                label: Text(vaccine),
                backgroundColor: Colors.pink[100],
              );
            }).toList(),
          ),
          SizedBox(height: 16),

          // Karakteristik kucing
          Text(
            "Characteristics:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: cat.characteristics.map((characteristic) {
              return Chip(
                label: Text(characteristic),
                backgroundColor: Colors.pink[100],
              );
            }).toList(),
          ),
          SizedBox(height: 16),

          // Latar belakang kucing
          Text(
            "Background:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[800]),
          ),
          SizedBox(height: 8),
          Text(
            cat.background,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 20),

          // Tombol Adopt Me
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Adopt Me! 💖",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}