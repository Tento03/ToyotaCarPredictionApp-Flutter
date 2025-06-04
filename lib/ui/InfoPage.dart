import 'package:flutter/material.dart';

class Infopage extends StatelessWidget {
  const Infopage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About This App',
          style: TextStyle(fontWeight: FontWeight.w500 ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Toyota Car Price Prediction',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Aplikasi ini digunakan untuk memprediksi harga mobil Toyota berdasarkan input seperti model, tahun, jenis transmisi, tipe bahan bakar, mileage, tax, MPG, dan ukuran mesin.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cara Kerja:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Masukkan informasi mobil pada form input.\n'
              '2. Klik tombol "Predict".\n'
              '3. Aplikasi akan mengirim data ke server Flask dengan model machine learning.\n'
              '4. Model akan memproses dan mengirimkan hasil prediksi harga mobil.\n'
              '5. Hasil akan disimpan ke dalam history.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Teknologi yang Digunakan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              '- Flutter (Frontend Mobile App)\n'
              '- Hive (Local Storage)\n'
              '- Python Flask (Backend API)\n'
              '- Scikit-learn / XGBoost (Machine Learning Model)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Catatan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Prediksi bersifat estimasi dan hanya digunakan untuk kebutuhan edukasi dan simulasi.',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
