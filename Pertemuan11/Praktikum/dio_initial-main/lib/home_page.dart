// import 'package:dio/dio.dart';
import 'package:dio_initial/data_service.dart';
import 'package:dio_initial/user.dart';
import 'package:dio_initial/user_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _jobCtl = TextEditingController();
  final _idUserCtl = TextEditingController();
  String _result = '-';
  List<User> _users = [];
  UserCreate? _userCreate;
  UserPut? _userPut;

  @override
  void dispose() {
    _nameCtl.dispose();
    _jobCtl.dispose();
    _idUserCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API (DIO)'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Name',
                  suffixIcon: IconButton(
                    onPressed: _nameCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _jobCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Job',
                  suffixIcon: IconButton(
                    onPressed: _jobCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _idUserCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'id(User)',
                  suffixIcon: IconButton(
                    onPressed: _idUserCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.getUsers();
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                          });
                        }
                      },
                      child: const Text('GET'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Isi Semua data omm');
                          return;
                        }

                        final postModel = UserCreate(
                          name: _nameCtl.text,
                          job: _jobCtl.text,
                        );

                        UserCreate? res =
                            await _dataService.postUser(postModel);
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                            _userCreate = res;
                            _userPut = null;
                          });
                        }
                        _nameCtl.clear();
                        _jobCtl.clear();
                        _idUserCtl.clear();
                      },
                      child: const Text('POST'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Isi Semua Omm');
                          return;
                        }

                        final putModel = UserPut(
                          id: _idUserCtl.text,
                          name: _nameCtl.text,
                          job: _jobCtl.text,
                        );
                        // var idUser = '2';
                        UserPut? res = await _dataService.putUser(putModel);
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                            _userPut = res;
                            _userCreate = null;
                          });
                        }
                        _nameCtl.clear();
                        _jobCtl.clear();
                        _idUserCtl.clear();
                      },
                      child: const Text('PUT'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var res =
                            await _dataService.deleteUser(_idUserCtl.text);
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                            _userPut = null;
                            _userCreate = null;
                          });
                        }
                      },
                      child: const Text('DELETE'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.getUserModel();
                        if (res != null) {
                          setState(() {
                            _users = res.toList();
                            _userCreate = null;
                            _userPut = null;
                          });
                        }
                      },
                      child: const Text('Model Class User Example'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _users.clear();
                        _result = 'Berhasil direset';
                        _userCreate = null;
                        _userPut = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Result',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _users.isEmpty ? Text(_result) : _buildListUser(),
              ),
              Column(
                children: <Widget>[
                  if (_userCreate != null) _buildCard(),
                  if (_userPut != null) _buildCardPut(),
                  if (_userCreate == null && _userPut == null)
                    const Text('Data Kosong'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListUser() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final user = _users[index];
        return Card(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                user.avatar,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10.0,
      ),
      itemCount: _users.length,
    );
  }

  Widget _buildCard() {
    return _userCreate != null
        ? Column(
            children: [
              UserCard(userCreate: _userCreate!),
            ],
          )
        : const SizedBox
            .shrink(); // Return an empty container if _userCreate is null
  }

  Widget _buildCardPut() {
    return _userPut != null
        ? Column(
            children: [
              UserPutCard(userPut: _userPut!),
            ],
          )
        : const SizedBox
            .shrink(); // Return an empty container if _userPut is null
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
