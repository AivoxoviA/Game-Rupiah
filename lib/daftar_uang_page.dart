import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DaftarUangPage extends StatefulWidget {
  @override
  State<DaftarUangPage> createState() => _DaftarUangPageState();
}

class _DaftarUangPageState extends State<DaftarUangPage> {
  List _dataUang = [];

  Future<void> loadData() async {
    final String response =
        await rootBundle.loadString('assets/data/uang.json');
    final data = await json.decode(response);
    setState(() {
      _dataUang = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Uang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _dataUang.isNotEmpty
            ? Expanded(
              child: ListView.builder(
                itemCount: _dataUang.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 128,
                          maxWidth: 512,
                          maxHeight: 256,
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/images/uang/uang-$index.jpg'
                          )
                        ),
                      ),
                      title: Text(_dataUang[index]['judul']),
                      subtitle: _dataUang[index]['tipe'] == 'Khusus'
                      ? Text('Khusus')
                      : Container(),
                    ),
                  );
                }
              )
            )
            : Container()
          ],
        ),
      ),
    );
  }
}
