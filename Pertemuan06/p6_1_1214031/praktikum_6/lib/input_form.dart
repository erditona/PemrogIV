import 'package:flutter/material.dart';

class MyInputForm extends StatefulWidget {
  const MyInputForm({Key? key}) : super(key: key);

  @override
  State<MyInputForm> createState() => _MyInputFormState();
}

class _MyInputFormState extends State<MyInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  void _addData() {
    final data = {
      'name': _controllerNama.text,
      'email': _controllerEmail.text,
    };
    setState(() {
      if (editedData != null) {
// Jika editedData ada, maka kita sedang dalam mode edit
// Sehingga kita perlu memperbarui data yang sedang diedit
        editedData!['name'] = data['name'];
        editedData!['email'] = data['email'];
// Kosongkan kembali editedData setelah proses edit selesai
        editedData = null;
      } else {
// Jika editedData kosong, maka kita sedang dalam mode insert
        _myDataList.add(data);
      }
      _controllerNama.clear();
      _controllerEmail.clear();
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerEmail.text = data['email'];
      _controllerNama.text = data['name'];
      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Email tidak boleh kosong';
  //   }
  //   return null;
  // }

  // String? _validateNama(String? value) {
  //   const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
  //       "\\@"
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
  //       "("
  //       "\\."
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
  //       ")+";
  //   final RegExp regExp = RegExp(expression);

  //   if (!regExp.hasMatch(value!)) {
  //     return 'Email tidak valid';
  //   }

  //   if (value.isEmpty || value.isEmpty) {
  //     return 'Email tidak boleh kosong';
  //   }

  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
                      "\\@"
                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                      "("
                      "\\."
                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                      ")+";
                  final RegExp regExp = RegExp(expression);
                  if (!regExp.hasMatch(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 54, 220, 220),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerNama,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Nama minimal 6 karakter';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 54, 220, 220),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Nama',
                ),
              ),
            ),
            ElevatedButton(
              child: Text(editedData != null ? 'Edit' : 'Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addData();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text('Berhasil Cuy...')],
                        ),
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal Cuy...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'List Data',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myDataList.length,
              itemBuilder: (context, index) {
                final data = _myDataList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          'ULBI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['name'] ?? ''),
                            Text(data['email'] ?? ''),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _editData(data);
                          });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _deleteData(data);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
