import 'dart:convert';
import 'dart:io';
import 'package:artes_decoracoes/components/button_primary.dart';
import 'package:artes_decoracoes/components/photo_page.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario_cep.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario_tipo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CadastraUsuarioPhoto extends StatefulWidget {
  String usuario;

  CadastraUsuarioPhoto(String usuario){
    this.usuario = usuario;
  }

  @override
  _CadastraUsuarioPhotoState createState() => _CadastraUsuarioPhotoState(usuario);
}

class _CadastraUsuarioPhotoState extends State<CadastraUsuarioPhoto> {
  String urlImage = '';
  bool loading = false;
  ProgressDialog pr;
  String usuario;

  _CadastraUsuarioPhotoState(String usuario){
    this.usuario = usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buidBody(),
    );
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Por favor espere...',
        borderRadius: 20.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
        padding: EdgeInsets.all(30),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      title: Text("Cadastro"),
      backgroundColor: Color(0xcc4B0082),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.infoCircle),
          onPressed: () {},
        )
      ],
    );
  }

  _buidBody() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.purple[50]])),
      height: MediaQuery.of(context).size.height / 1,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, left: 45),
            height: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              'Adicione sua foto',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
          ),
          Container(margin: EdgeInsets.only(top: 20.0), child: Divider()),
          _buildContainerPhoto(),
          Container(
            height: 100,
          ),
          ButtonPrimary(
            () {
              _addPhoto();
            },
            urlImage.isEmpty ? 'Adicionar foto' : 'Alterar a foto',
          ),
          Container(
            height: 30,
          ),
          ButtonPrimary(() {
            _buildButtonProsseguir();
          }, 'Prosseguir'),
        ],
      ),
    );
  }

  _buildContainerPhoto() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildPhotoExist(),
            ],
          ),
        ],
      ),
    );
  }

  _buildPhotoExist() {
    if (urlImage.isEmpty) {
      return CircleAvatar(
        maxRadius: 80,
        backgroundColor: Colors.black12,
        child: IconButton(
          icon: FaIcon(FontAwesomeIcons.userEdit),
          onPressed: () {},
          iconSize: 70,
          color: Colors.white70,
        ),
      );
    } else {
      return GestureDetector(
        child: CircleAvatar(
            backgroundImage:
                NetworkImage('https://ucarecdn.com/${urlImage}/-/resize/380x/'),
            maxRadius: 80,
            backgroundColor: Colors.black12),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotoPage(urlImage)));
        },
      );
    }
  }

  Future<dynamic> _addPhoto() async {
    var fileName = await ImagePicker.pickImage(source: ImageSource.gallery);
    uplaod(fileName);
  }

  uplaod(File imageFile) async {
    setState(() {
      pr.show();
    });

    try {
      var stream = imageFile.openRead();
      var length = await imageFile.length();
      var uri = Uri.parse('https://upload.uploadcare.com/base/');

      var request = http.MultipartRequest('POST', uri);
      var multipartFile = http.MultipartFile('uploadedfile', stream, length,
          filename: imageFile.path);

      request.files.add(multipartFile);
      request.fields.addAll({'UPLOADCARE_PUB_KEY': 'demopublickey'});

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final JsonDecoder decoder = JsonDecoder();
        dynamic map = decoder.convert(value ?? '');
        setState(() {
          urlImage = map['uploadedfile'];
          pr.hide();
        });
      });
    } catch (e) {

    }
  }

  _buildButtonProsseguir() async{

    http.Response response;

    if(urlImage != null){
      response = await http.get("http://andreeez.ddns.net:9090/picos/foto/cadastro/${urlImage}");
    }

    Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastraUsuarioCep(usuario)));
  }

}
