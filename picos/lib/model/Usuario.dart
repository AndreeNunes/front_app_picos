class Usuario {

  int idUsuario;
  String nomeUsuario;
  String emailUsuario;
  String foneUsuario;
  String tipoCliente;
  String idFotoPerfil;
  int idEndereco;
  String loginUsuario;

	String getLoginUsuario() {
		return this.loginUsuario;
	}

	 void setLoginUsuario(String loginUsuario) {
		this.loginUsuario = loginUsuario;
	}

  int getIdUsuario() {
    return this.idUsuario;
  }

  void setIdUsuario(int idUsuario) {
    this.idUsuario = idUsuario;
  }

  String getNomeUsuario() {
    return this.nomeUsuario;
  }

  void setNomeUsuario(String nomeUsuario) {
    this.nomeUsuario = nomeUsuario;
  }

  String getEmailUsuario() {
    return this.emailUsuario;
  }

  void setEmailUsuario(String emailUsuario) {
    this.emailUsuario = emailUsuario;
  }

  String getFoneUsuario() {
    return this.foneUsuario;
  }

  void setFoneUsuario(String foneUsuario) {
    this.foneUsuario = foneUsuario;
  }

  String getTipoCliente() {
    return this.tipoCliente;
  }

  void setTipoCliente(String tipoCliente) {
    this.tipoCliente = tipoCliente;
  }

  String getIdFotoPerfil() {
    return this.idFotoPerfil;
  }

  void setIdFotoPerfil(String idFotoPerfil) {
    this.idFotoPerfil = idFotoPerfil;
  }

  int getIdEndereco() {
    return this.idEndereco;
  }

  void setIdEndereco(int idEndereco) {
    this.idEndereco = idEndereco;
  }  
}
