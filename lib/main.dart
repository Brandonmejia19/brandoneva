import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                paths.remove(path);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: () {
                              _saveImageToGallery(path);
                            },
                          ),
                        ],
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
                    }
                  },
                  child: const Text('Tomar foto'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveImageToGallery(String imagePath) async {
    final bool isSaved = await ImageGallerySaver.saveFile(imagePath);
    if (isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Imagen guardada en la galería'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No se pudo guardar la imagen en la galería'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
