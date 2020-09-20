import 'dart:convert';

import 'package:artes_decoracoes/constants/default_config.dart';
import 'package:artes_decoracoes/model/Usuario.dart';
import 'package:http/http.dart' as http;

class CarregaInfoUsuario {
  Usuario usuario = new Usuario();
  http.Response response;
  DefaultConfig defaultConfig = new DefaultConfig();
  String urlPadrao;

  CarregaInfoUsuario() {
    urlPadrao = defaultConfig.retornaUrlPadrao();
  }

  Future<Usuario> carregaInfoUsuario(String usuarioLogin) async {
    try {
      response = await http
          .post("${urlPadrao}picos/info-usuario?usuario=${usuarioLogin}");

      Map<String, dynamic> infoUsuario = jsonDecode(response.body);

      usuario.setLoginUsuario(infoUsuario['usuarioCadatsro']);
      usuario.setEmailUsuario(infoUsuario['emailCadastro']);
      usuario.setFoneUsuario(infoUsuario['foneCadastro']);
      usuario.setIdEndereco(infoUsuario['enderecoUsuario']);
      usuario.setIdFotoPerfil(infoUsuario['idImagePefil']);
      usuario.setIdUsuario(infoUsuario['idCadastro']);
      usuario.setNomeUsuario(infoUsuario['nomeCadastro']);
      usuario.setTipoCliente(infoUsuario['tipoCadastro']);
      usuario.setLoginUsuario(infoUsuario['usuarioCadatsro']);

      return usuario;
    } catch (e) {
      print(e);
    }
  }
}
