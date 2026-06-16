import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? profileImage;

  String tentang =
      'Mahasiswa Teknik Informatika yang sedang belajar Flutter dan pengembangan aplikasi mobile.';

  String pendidikan =
      'Universitas Pasundan\nSemester 6';

  String lokasi =
      'Bandung\nJawa Barat';

  String kontak =
      '08123456789';

  List<String> skills = [
    'Flutter',
    'Dart',
    'PHP',
    'MySQL',
  ];

  XFile? pengalamanImage;

  String pengalamanJudul =
      'Membuat Aplikasi Flutter';

  String pengalamanDeskripsi =
      'Membuat aplikasi profil menggunakan Flutter dan Android Studio.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration:
              BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            ListTile(
              leading:
              const Icon(Icons.edit),
              title:
              const Text('Edit Profile'),
              onTap: () async {
                Navigator.pop(context);

                final result =
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditProfilePage(
                          image: profileImage,
                          tentang: tentang,
                          pendidikan:
                          pendidikan,
                          lokasi: lokasi,
                          kontak: kontak,
                        ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    profileImage =
                    result["image"];

                    tentang =
                    result["tentang"];

                    pendidikan =
                    result["pendidikan"];

                    lokasi =
                    result["lokasi"];

                    kontak =
                    result["kontak"];
                  });
                }
              },
            ),

            ListTile(
              leading:
              const Icon(Icons.work),
              title: const Text(
                'Edit Pengalaman',
              ),
              onTap: () async {
                Navigator.pop(context);

                final result =
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditPengalamanPage(
                          image:
                          pengalamanImage,
                          judul:
                          pengalamanJudul,
                          deskripsi:
                          pengalamanDeskripsi,
                        ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    pengalamanImage =
                    result["image"];

                    pengalamanJudul =
                    result["judul"];

                    pengalamanDeskripsi =
                    result["deskripsi"];
                  });
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        child:
        const Icon(Icons.edit),
        onPressed: () async {
          final result =
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  EditProfilePage(
                    image: profileImage,
                    tentang: tentang,
                    pendidikan:
                    pendidikan,
                    lokasi: lokasi,
                    kontak: kontak,
                  ),
            ),
          );

          if (result != null) {
            setState(() {
              profileImage =
              result["image"];

              tentang =
              result["tentang"];

              pendidikan =
              result["pendidikan"];

              lokasi =
              result["lokasi"];

              kontak =
              result["kontak"];
            });
          }
        },
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [

            CircleAvatar(
              radius: 60,
              backgroundImage:
              profileImage != null
                  ? NetworkImage(profileImage!.path)
                  : null,
              child:
              profileImage == null
                  ? const Icon(
                Icons.person,
                size: 60,
              )
                  : null,
            ),

            const SizedBox(
                height: 15),

            const Text(
              'Fauzi Ahmad Ramdani',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 20),

            SectionCard(
              icon: Icons.info,
              title: 'Tentang Saya',
              content: tentang,
            ),

            SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: pendidikan,
            ),

            SectionCard(
              icon:
              Icons.location_on,
              title: 'Lokasi',
              content: lokasi,
            ),

            SectionCard(
              icon: Icons.phone,
              title: 'Kontak',
              content: kontak,
            ),

            Card(
              child: Padding(
                padding:
                const EdgeInsets
                    .all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [

                    const Text(
                      'Skills',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Wrap(
                      spacing: 8,
                      children: skills
                          .map(
                            (e) => Chip(
                          label:
                          Text(e),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
                height: 12),

            Card(
              child: Padding(
                padding:
                const EdgeInsets
                    .all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [

                    const Text(
                      'Pengalaman',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    if (pengalamanImage !=
                        null)
                      ClipRRect(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        child:
                        Image.network(
                          pengalamanImage!.path,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      ),

                    const SizedBox(
                        height: 10),

                    Text(
                      pengalamanJudul,
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                        height: 5),

                    Text(
                      pengalamanDeskripsi,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(
      BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }
}
class EditProfilePage extends StatefulWidget {
  final XFile? image;
  final String tentang;
  final String pendidikan;
  final String lokasi;
  final String kontak;

  const EditProfilePage({
    super.key,
    required this.image,
    required this.tentang,
    required this.pendidikan,
    required this.lokasi,
    required this.kontak,
  });

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {

  final ImagePicker picker = ImagePicker();

  XFile? image;

  late TextEditingController tentangController;
  late TextEditingController pendidikanController;
  late TextEditingController lokasiController;
  late TextEditingController kontakController;

  @override
  void initState() {
    super.initState();

    image = widget.image;

    tentangController =
        TextEditingController(text: widget.tentang);

    pendidikanController =
        TextEditingController(text: widget.pendidikan);

    lokasiController =
        TextEditingController(text: widget.lokasi);

    kontakController =
        TextEditingController(text: widget.kontak);
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        image = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            CircleAvatar(
              radius: 60,
              backgroundImage:
              image != null
                  ? NetworkImage(image!.path)
                  : null,
              child: image == null
                  ? const Icon(
                Icons.person,
                size: 60,
              )
                  : null,
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: pickImage,
              child: const Text(
                'Pilih Foto',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: tentangController,
              decoration: const InputDecoration(
                labelText: 'Tentang Saya',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: pendidikanController,
              decoration: const InputDecoration(
                labelText: 'Pendidikan',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: lokasiController,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: kontakController,
              decoration: const InputDecoration(
                labelText: 'Kontak',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    "image": image,
                    "tentang":
                    tentangController.text,
                    "pendidikan":
                    pendidikanController.text,
                    "lokasi":
                    lokasiController.text,
                    "kontak":
                    kontakController.text,
                  },
                );
              },
              child: const Text(
                'Simpan Perubahan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPengalamanPage
    extends StatefulWidget {

  final XFile? image;
  final String judul;
  final String deskripsi;

  const EditPengalamanPage({
    super.key,
    required this.image,
    required this.judul,
    required this.deskripsi,
  });

  @override
  State<EditPengalamanPage>
  createState() =>
      _EditPengalamanPageState();
}

class _EditPengalamanPageState
    extends State<EditPengalamanPage> {

  final ImagePicker picker =
  ImagePicker();

  XFile? image;

  late TextEditingController
  judulController;

  late TextEditingController
  deskripsiController;

  @override
  void initState() {
    super.initState();

    image = widget.image;

    judulController =
        TextEditingController(
          text: widget.judul,
        );

    deskripsiController =
        TextEditingController(
          text: widget.deskripsi,
        );
  }

  Future<void> pickImage() async {
    final picked =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        image = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Edit Pengalaman'),
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [

            if (image != null)
              ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    10),
                child: Image.network(
                  image!.path,
                  height: 200,
                  width:
                  double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: pickImage,
              child: const Text(
                'Pilih Gambar',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              judulController,
              decoration:
              const InputDecoration(
                labelText:
                'Judul Pengalaman',
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
              deskripsiController,
              maxLines: 4,
              decoration:
              const InputDecoration(
                labelText:
                'Deskripsi Pengalaman',
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    "image": image,
                    "judul":
                    judulController
                        .text,
                    "deskripsi":
                    deskripsiController
                        .text,
                  },
                );
              },
              child: const Text(
                'Simpan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}