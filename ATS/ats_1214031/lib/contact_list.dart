import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class MyContactList extends StatefulWidget {
  const MyContactList({Key? key}) : super(key: key);

  @override
  State<MyContactList> createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  DateTime? _selectedDate;
  Color _selectedColor = Colors.blue;
  File? _selectedImage;
  String? _selectedImageFileName;
  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;

  @override
  void dispose() {
    _controllerPhone.dispose();
    _controllerName.dispose();
    super.dispose();
  }

  void _addData() {
    // 1. Membuat objek data dengan nilai dari inputan user
    final data = {
      'name': _controllerName.text,
      'phone': _controllerPhone.text,
      'date': _selectedDate,
      'color': _selectedColor,
      'image': _selectedImage,
    };

    // 2. Mengupdate state menggunakan setState
    setState(() {
      // 3. Jika sedang dalam mode pengeditan, update data yang sudah ada
      if (editedData != null) {
        editedData!['name'] = data['name'];
        editedData!['phone'] = data['phone'];
        editedData!['date'] = data['date'];
        editedData!['color'] = data['color'];
        editedData!['image'] = data['image'];
        editedData = null;
      } else {
        // 4. Jika tidak dalam mode pengeditan, tambahkan data baru ke dalam list
        _myDataList.add(data);
      }
      // 5. Bersihkan input setelah data ditambahkan
      _controllerName.clear();
      _controllerPhone.clear();
      _selectedDate = null;
      _selectedColor = Colors.blue;
      _selectedImage = null;
      _selectedImageFileName = null;
    });
  }

  void _editData(Map<String, dynamic> data) {
    // 1. Menggunakan setState untuk memberi tahu Flutter tentang perubahan state
    setState(() {
      // 2. Mengisi kembali formulir dengan data yang akan diedit
      _controllerName.text = data['name'];
      _controllerPhone.text = data['phone'];
      _selectedDate = data['date'];
      _selectedColor = data['color'];
      _selectedImage = data['image'];
      _selectedImageFileName = _selectedImage?.path.split('/').last;
      editedData = data; // 3. Menyimpan data yang sedang diedit
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    // 1. Menampilkan dialog konfirmasi penghapusan
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete this data?'),
          actions: [
            // 2. Tombol Batal
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            // 3. Tombol Hapus
            TextButton(
              onPressed: () {
                // 4. Menghapus data dari list
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();

                // 5. Menampilkan snackbar sebagai notifikasi penghapusan data
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data deleted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    // 1. Membuat objek ImagePicker
    final picker = ImagePicker();
    // 2. Menggunakan ImagePicker untuk memilih gambar dari galeri
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // 3. Memproses gambar yang dipilih
    if (pickedImage != null) {
      setState(() {
        // 4. Menyimpan path gambar yang dipilih dalam variabel _selectedImage
        _selectedImage = File(pickedImage.path);
        // 5. Mendapatkan nama file gambar
        _selectedImageFileName =
            '${_selectedImage?.path.split('/').last.substring(0, 10)}...';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2, // Added elevation for the input card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // 1. Input Phone Number
                        TextFormField(
                          controller: _controllerPhone,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number cannot be empty';
                            }
                            // Validate that the phone number contains only digits
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Phone number must contain only digits';
                            }
                            // Validate the length of the phone number
                            if (value.length < 8 || value.length > 13) {
                              return 'Phone number must be between 8 and 13 digits';
                            }
                            // Validate that the phone number starts with a '0'
                            if (!value.startsWith('0')) {
                              return 'Phone number must start with a 0';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 54, 220, 220),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Phone Number',
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 2. Input Name
                        TextFormField(
                          controller: _controllerName,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            // Validate that the name consists of at least two words
                            if (value.trim().split(' ').length < 2) {
                              return 'Name must consist of at least two words';
                            }
                            // Validate that each word starts with a capital letter
                            if (!RegExp(r'^[A-Z][a-z]*([ ][A-Z][a-z]*)*$')
                                .hasMatch(value)) {
                              return 'Each word in the name must start with a capital letter';
                            }
                            // Validate that the name doesn't contain numbers or special characters
                            if (RegExp(r'[0-9!@#%^&*(),.?":{}|<>]')
                                .hasMatch(value)) {
                              return 'Name cannot contain numbers or special characters';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 54, 220, 220),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 3. Input Date
                        TextFormField(
                          readOnly: true, // Make the text field read-only
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : '',
                          ),
                          validator: (value) {
                            if (_selectedDate == null) {
                              return 'Date must be selected';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 54, 220, 220),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Date',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 4. Input Color
                        Row(
                          children: [
                            const Text('Color: '),
                            ElevatedButton(
                              onPressed: () async {
                                Color? pickedColor = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Pick a Color'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: _selectedColor,
                                          onColorChanged: (color) {
                                            _selectedColor = color;
                                          },
                                          pickerAreaHeightPercent: 0.8,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(_selectedColor);
                                          },
                                          child: const Text('Select'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (pickedColor != null) {
                                  setState(() {
                                    _selectedColor = pickedColor;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(_selectedColor),
                              ),
                              child: const Text('Pick Color'),
                            ),
                          ],
                        ),
                        //aktifkan ini jika ingin menampilkan boxcollor
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     height: 50,
                        //     color: _selectedColor,
                        //   ),
                        // ),
                        const SizedBox(height: 8),
                        // 5. Input Image
                        Row(
                          children: [
                            const Text('Image: '),
                            ElevatedButton(
                              onPressed: _pickImage,
                              child: Tooltip(
                                message: _selectedImageFileName ?? 'Pick Image',
                                child: Text(
                                  _selectedImageFileName != null
                                      ? _selectedImageFileName!.length > 20
                                          ? '${_selectedImageFileName!.substring(0, 17)}...'
                                          : _selectedImageFileName!
                                      : 'Pick Image',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 6. Submit Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addData();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [Text('Success')],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Text(editedData != null ? 'Edit' : 'Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'List Contacts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (final data in _myDataList) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2, // Added elevation for the list data card
                    child: ListTile(
                      title: Text(data['name'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['phone'] ?? ''),
                          Text(
                            data['date'] != null
                                ? '${data['date']!.day}/${data['date']!.month}/${data['date']!.year}'
                                : '',
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: data['color'],
                        backgroundImage: data['image'] != null
                            ? FileImage(data['image']!)
                            : null,
                        child: data['image'] == null
                            ? Text(
                                data['name']
                                    .toString()
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editData(data);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteData(data);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
