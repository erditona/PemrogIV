import 'package:flutter/material.dart';

class MyInputValidation extends StatefulWidget {
  const MyInputValidation({Key? key}) : super(key: key);

  @override
  State<MyInputValidation> createState() => _MyInputValidationState();
}

class _MyInputValidationState extends State<MyInputValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
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
        title: const Text('Input Validation'),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Halloo: ${_controllerNama.text}'),
                            Text('Email: ${_controllerEmail.text}'),
                          ],
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
              child: const Text('Submit'),
            ),
          ]),
        ),
      ),
    );
  }
}
