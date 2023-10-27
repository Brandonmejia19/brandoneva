import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camara Evaluado/Brandon',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        colorScheme: ColorScheme.dark(),
      ),
      home: const MyHomePage(title: 'CamaraEvaluado/Brandon'),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> paths = [];
  TextEditingController textController = TextEditingController();

  Future<void> _saveToGallery(String imagePath) async {
   
      print('Imagen guardada en la galería.');
    } else {
      print('Error al guardar la imagen en la galería.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: paths.map((path) {
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5,
                    child: ListTile(
                      title: Image(image: FileImage(File(path))),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            paths.remove(path);
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        paths.add(image.path);
                      });

                      _saveToGallery(image.path); // Guardar la imagen en la galería
                    }
                  },
                  child: const Text('Elegir Foto de galería'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        paths.add(image.path);
                      });

                      _saveToGallery(image.path); // Guardar la imagen en la galería
                    }
                  },
                  child: const Text('Tomar foto y guardar en la galería'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
