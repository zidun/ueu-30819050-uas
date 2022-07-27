import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_30819050_mobile/helper/base_response.dart';
import 'package:uas_30819050_mobile/helper/constants.dart';
import 'package:uas_30819050_mobile/model/DosenModel.dart';
import 'package:uas_30819050_mobile/widget/Button.dart';
import 'package:uas_30819050_mobile/widget/InputForm.dart';
import 'package:uas_30819050_mobile/widget/ItemDosen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Dosen',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Data Dosen'),
    );
  }
}

enum JenikKelamin { L, P }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DosenModel> listDosen = [];
  TextEditingController nipController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  JenikKelamin? jenikKelamin = JenikKelamin.L;
  var idDosen;

  void getDosenList() async {
    var response = await http.get(Uri.parse('$URL_SERVER$dosenPath'));
    if (response.statusCode == 200) {
      listDosen.clear();
    }
    var decodedData = BaseResponse
        .fromJson(jsonDecode(response.body))
        .data;
    for (var u in decodedData) {
      listDosen.add(DosenModel(
        u['id'],
        u['nip_dosen'],
        u['name_dosen'],
        u['address_dosen'],
        u['gender_dosen'],
      ));
    }
    setState(() {
      listDosen = listDosen;
    });
  }

  showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  void deleteDataDosen(BuildContext context, id) async {
    var response = await http.delete(Uri.parse('$URL_SERVER$dosenPath/$id'));
    if (response.statusCode == 200) {
      getDosenList();
      showToast(context, 'Berhasil Hapus Data Dosen');
    }
  }

  void addDataDosen(BuildContext context,) async {
    var response = await http
        .post(Uri.parse('$URL_SERVER$dosenPath'), headers: <String, String>{
      'Context-Type': 'application/json;charset=UTF-8',
    }, body: <String, String>{
      'nip_dosen': nipController.text,
      'name_dosen': nameController.text,
      'address_dosen': addressController.text,
      'gender_dosen': jenikKelamin.toString(),
    });
    if (BaseResponse
        .fromJson(jsonDecode(response.body))
        .statusCode == 201) {
      showToast(context, 'Berhasil Menambahkan Data Dosen');
      getDosenList();
      resetData();
    } else {
      showToast(context, 'Gagal Menambahkan Data Dose');
    }
  }

  void editDataDosen(BuildContext context,) async {
    var response = await http.put(Uri.parse('$URL_SERVER$dosenPath/$idDosen'),
        headers: <String, String>{
          'Context-Type': 'application/json;charset=UTF-8',
        },
        body: <String, String>{
          'nip_dosen': nipController.text,
          'name_dosen': nameController.text,
          'address_dosen': addressController.text,
          'gender_dosen': jenikKelamin.toString(),
        });
    if (BaseResponse
        .fromJson(jsonDecode(response.body))
        .statusCode == 200) {
      showToast(context, 'Berhasil Update Data Dosen');
      resetData();
      getDosenList();
    } else {
      showToast(context, 'Gagal Update Data Dosen');
    }
  }

  void resetData() {
    nipController.text = '';
    nameController.text = '';
    addressController.text = '';
    setState(() {
      idDosen = null;
      jenikKelamin = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getDosenList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputForm(
                              label: 'NIP Dosen',
                              controller: nipController,
                              hintText: 'Masukan NIP Dosen',
                            ),
                            InputForm(
                              label: 'Nama Dosen',
                              controller: nameController,
                              hintText: 'Masukan Nama Dosen',
                            ),
                            InputForm(
                              label: 'Alamat Dosen',
                              controller: addressController,
                              hintText: 'Masukan Alamat Dosen',
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jenis Kelamin",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<JenikKelamin>(
                                          value: JenikKelamin.L,
                                          groupValue: jenikKelamin,
                                          onChanged: (JenikKelamin? value) {
                                            setState(() {
                                              jenikKelamin = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          "Laki-laki",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<JenikKelamin>(
                                          value: JenikKelamin.P,
                                          groupValue: jenikKelamin,
                                          onChanged: (JenikKelamin? value) {
                                            setState(() {
                                              jenikKelamin = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          "Perempuan",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (idDosen != null) ...[
                                    Button(
                                      borderColor: Colors.red,
                                      bgColor: Colors.red,
                                      text: "Cancel",
                                      onPressed: () {
                                        resetData();
                                      },
                                    ),
                                    SizedBox(width: 16)
                                  ],
                                  Button(
                                    text: (idDosen != null)
                                        ? 'UPDATE DATA'
                                        : 'TAMBAH DATA',
                                    onPressed: () {
                                      if (idDosen != null) {
                                        editDataDosen(context);
                                      } else {
                                        addDataDosen(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Text(
                      "List Dosen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listDosen.length,
                    itemBuilder: (BuildContext context, index) =>
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: ItemDosen(
                              nip: listDosen[index].nip_dosen,
                              name: listDosen[index].name_dosen,
                              address: listDosen[index].address_dosen,
                              onEdit: () {
                                nipController.text = listDosen[index].nip_dosen;
                                nameController.text =
                                    listDosen[index].name_dosen;
                                addressController.text =
                                    listDosen[index].address_dosen;
                                setState(() {
                                  idDosen = listDosen[index].id;
                                  jenikKelamin =
                                  listDosen[index].gender_dosen == 'L'
                                      ? JenikKelamin.L
                                      : JenikKelamin.P;
                                });
                              },
                              onDelete: () {
                                deleteDataDosen(context, listDosen[index].id);
                              },
                            ),
                          ),
                        ),
                    // itemBuilder: (BuildContext context, index) => InkWell(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 16,
                    //       vertical: 4,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         SizedBox(
                    //           // height: 200,
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 listDosen[index].name_dosen,
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.bold),
                    //               ),
                    //               Text(
                    //                 listDosen[index].id.toString(),
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w400,
                    //                   color: Colors.grey,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             deleteDataDosen(context, listDosen[index].id);
                    //           },
                    //           child: const Icon(
                    //             Icons.delete,
                    //             color: Colors.red,
                    //             size: 24,
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             nipController.text = listDosen[index].nip_dosen;
                    //             nameController.text =
                    //                 listDosen[index].name_dosen;
                    //             addressController.text =
                    //                 listDosen[index].address_dosen;
                    //             setState(() {
                    //               idDosen = listDosen[index].id;
                    //               jenikKelamin =
                    //                   listDosen[index].gender_dosen == 'L'
                    //                       ? JenikKelamin.L
                    //                       : JenikKelamin.P;
                    //             });
                    //           },
                    //           child: const Icon(
                    //             Icons.edit,
                    //             color: Colors.black,
                    //             size: 24,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //               width: 300,
  }
}
