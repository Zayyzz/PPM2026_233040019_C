import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final String email;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Catatan Mahasiswa',

      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),

      home: const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Catatan> _catatan = [

    Catatan(
      judul: 'Belajar Flutter',
      isi: 'Belajar StatefulWidget dan Navigation.',
      kategori: 'Kuliah',
      email: 'fauzi@gmail.com',
      dibuatPada: DateTime.now(),
    ),

  ];

  String _filterKategori = 'Semua';

  final List<String> _kategoriFilter = [
    'Semua',
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  List<Catatan> get _filteredCatatan {

    if (_filterKategori == 'Semua') {
      return _catatan;
    }

    return _catatan
        .where((c) => c.kategori == _filterKategori)
        .toList();
  }

  Future<void> _tambahCatatan() async {

    final hasil = await Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) => const TambahCatatanPage(),
      ),
    );

    if (hasil is Catatan) {

      setState(() {
        _catatan.add(hasil);
      });
    }
  }

  Future<void> _editCatatan(
      Catatan catatan,
      int index,
      ) async {

    final hasil = await Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) => TambahCatatanPage(
          catatan: catatan,
          isEdit: true,
        ),
      ),
    );

    if (hasil is Catatan) {

      setState(() {
        _catatan[index] = hasil;
      });
    }
  }

  void _hapusCatatan(int index) {

    setState(() {
      _catatan.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    final data = _filteredCatatan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: DropdownButton<String>(
              value: _filterKategori,

              underline: const SizedBox(),

              items: _kategoriFilter
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),

              onChanged: (v) {

                setState(() {
                  _filterKategori = v!;
                });
              },
            ),
          ),
        ],
      ),

      body: data.isEmpty
          ? const Center(
        child: Text(
          'Belum ada catatan',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: data.length,

        itemBuilder: (context, i) {

          final c = data[i];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),

            child: ListTile(
              leading: const Icon(Icons.note),

              title: Text(c.judul),

              subtitle: Text(
                '${c.kategori} • ${c.email}',
              ),

              onTap: () async {

                await Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => DetailCatatanPage(
                      catatan: c,
                      onEdit: () {
                        Navigator.pop(context);

                        _editCatatan(
                          c,
                          _catatan.indexOf(c),
                        );
                      },
                    ),
                  ),
                );
              },

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),

                onPressed: () {
                  _hapusCatatan(
                    _catatan.indexOf(c),
                  );
                },
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _tambahCatatan,

        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahCatatanPage extends StatefulWidget {

  final Catatan? catatan;
  final bool isEdit;

  const TambahCatatanPage({
    super.key,
    this.catatan,
    this.isEdit = false,
  });

  @override
  State<TambahCatatanPage> createState() =>
      _TambahCatatanPageState();
}

class _TambahCatatanPageState
    extends State<TambahCatatanPage> {

  final _formKey = GlobalKey<FormState>();

  final _judulCtrl = TextEditingController();
  final _isiCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  String _kategori = 'Kuliah';

  final _kategoriOpsi = const [
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.catatan != null) {

      _judulCtrl.text =
          widget.catatan!.judul;

      _isiCtrl.text =
          widget.catatan!.isi;

      _emailCtrl.text =
          widget.catatan!.email;

      _kategori =
          widget.catatan!.kategori;
    }
  }

  @override
  void dispose() {

    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();

    super.dispose();
  }

  void _simpan() {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatanBaru = Catatan(
      judul: _judulCtrl.text.trim(),

      isi: _isiCtrl.text.trim(),

      kategori: _kategori,

      email: _emailCtrl.text.trim(),

      dibuatPada: DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? 'Edit Catatan'
              : 'Tambah Catatan',
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            // JUDUL
            TextFormField(
              controller: _judulCtrl,

              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),

              validator: (v) {

                if (v == null || v.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }

                if (v.trim().length < 3) {
                  return 'Minimal 3 karakter';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // EMAIL
            TextFormField(
              controller: _emailCtrl,

              keyboardType:
              TextInputType.emailAddress,

              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),

              validator: (v) {

                if (v == null || v.isEmpty) {
                  return 'Email wajib diisi';
                }

                final regex = RegExp(
                  r'^[^@]+@[^@]+\.[^@]+',
                );

                if (!regex.hasMatch(v)) {
                  return 'Format email tidak valid';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _kategori,

              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),

              items: _kategoriOpsi
                  .map(
                    (k) => DropdownMenuItem(
                  value: k,
                  child: Text(k),
                ),
              )
                  .toList(),

              onChanged: (v) {

                setState(() {
                  _kategori = v!;
                });
              },
            ),

            const SizedBox(height: 16),

            // ISI
            TextFormField(
              controller: _isiCtrl,

              maxLines: 5,

              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),

              validator: (v) {

                if (v == null || v.trim().isEmpty) {
                  return 'Isi wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: _simpan,

              icon: const Icon(Icons.save),

              label: Text(
                widget.isEdit
                    ? 'Update Catatan'
                    : 'Simpan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DetailCatatanPage extends StatelessWidget {

  final Catatan catatan;
  final VoidCallback onEdit;

  const DetailCatatanPage({
    super.key,
    required this.catatan,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              catatan.judul,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(catatan.kategori),
            ),

            const SizedBox(height: 16),

            Text(
              'Email: ${catatan.email}',
            ),

            const SizedBox(height: 8),

            Text(
              'Tanggal: '
                  '${catatan.dibuatPada.day}/'
                  '${catatan.dibuatPada.month}/'
                  '${catatan.dibuatPada.year}',
            ),

            const Divider(height: 32),

            Text(
              catatan.isi,

              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            Row(
              children: [

                Expanded(
                  child: FilledButton.icon(
                    onPressed: onEdit,

                    icon: const Icon(Icons.edit),

                    label: const Text('Edit'),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back),

                    label: const Text('Kembali'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}