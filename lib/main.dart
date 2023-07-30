import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_apipost/ssl/ssl_certificate.dart';
import 'dart:io';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostDataScreen(),
    );
  }
}

class PostDataScreen extends StatefulWidget {
  @override
  _PostDataScreenState createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final String apiUrl = 'http://10.0.2.2:5250/api/Room2'; // API URL buraya girilmelidir.
  final TextEditingController roomNumber = TextEditingController();
  final TextEditingController roomCoverImage = TextEditingController();
    final TextEditingController price = TextEditingController();
  final TextEditingController title = TextEditingController();
    final TextEditingController badCount = TextEditingController();
  final TextEditingController bathCount = TextEditingController();
    final TextEditingController wifi = TextEditingController();
  final TextEditingController description = TextEditingController();

  Future<void> postData() async {
     String _roomNumber = roomNumber.text;
     String _roomCoverImage = roomCoverImage.text;
     String _price = price.text;
     String _title = title.text;
     String _badCount = badCount.text;
     String _bathCount = bathCount.text;
     String _wifi = wifi.text;
     String _description = description.text;

    Map<String, dynamic> data = {
      "roomNumber": _roomNumber,
      "roomCoverImage": _roomCoverImage,
      "price": _price,
      "title": _title,
      "badCount": _badCount,
      "bathCount": _bathCount,
      "wifi": _wifi,
      "description": _description
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          // Eğer API'niz yetkilendirme gerektiriyorsa, burada gerekli başlıkları ekleyin.
          // Örneğin: 'Authorization': 'Bearer your_access_token',
        },
        body: jsonEncode(data),
      );

       if (response.statusCode == 200) {
      // İstek başarılı oldu
      print('Post işlemi başarılı!');
      print('Response: ${response.body}');
      // Bildirim gösterme
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veriler başarıyla gönderildi.'),
          duration: Duration(seconds: 2), // Bildirimin ekranda kalma süresi (isteğe bağlı)
        ),
      );
    } else {
        // İstek başarısız oldu
        print('Post işlemi başarısız. Hata kodu: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veriler gönderilemedi: ${response.statusCode}'),
          duration: const Duration(seconds: 2), // Bildirimin ekranda kalma süresi (isteğe bağlı)
        ),
      );
      }
    } catch (e) {
       print('Post işlemi sırasında bir hata oluştu: $e');
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bir hata oluştu: $e'),
        duration: const Duration(seconds: 2), // Bildirimin ekranda kalma süresi (isteğe bağlı)
      ),
    );
    }
  }

 @override
  Widget build(BuildContext context) {
     final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Data Örneği'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          children: [
            TextFormField(
              controller: roomNumber,
              decoration: const InputDecoration(labelText: 'Oda Numarası'),
            ),
            TextFormField(
              controller: roomCoverImage,
              decoration: const InputDecoration(labelText: 'Oda Resimi'),
            ),
             TextFormField(
              controller: price,
              decoration: const InputDecoration(labelText: 'Oda Fiyatı'),
            ),
            TextFormField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Başık'),
            ),
            TextFormField(
              controller: badCount,
              decoration: const InputDecoration(labelText: 'Kaç Banyo var'),
            ),
             TextFormField(
              controller: bathCount,
              decoration: const InputDecoration(labelText: 'Kaç Yatak var'),
            ),
            TextFormField(
              controller: wifi,
              decoration: const InputDecoration(labelText: 'Wifi Var mı Yok mu'),
            ),
            TextFormField(
              controller: description,
              decoration: const InputDecoration(labelText: 'Oda Açıklaması'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
  onPressed: () {
    postData();
    clearTextFields(); // TextField alanlarını temizle
  },
  child: const Text('Verileri Gönder'),
),

            SizedBox(height: keyboardHeight),
          ],
          ),
        ),
      ),
    );
  }
 
 //Temizleme İşlemi
  void clearTextFields() {
  roomNumber.clear();
  roomCoverImage.clear();
  price.clear();
  title.clear();
  badCount.clear();
  bathCount.clear();
  wifi.clear();
  description.clear();
}
}