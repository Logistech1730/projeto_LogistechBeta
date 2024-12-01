
    var idUsuario = sessionStorage.getItem("idUsuario");
    fetch(`/usuarios/listarPorId/${idUsuario}`, {
      method: "GET",
    })
      .then((resposta) => {
        resposta
          .json()
          .then((resultado) => {
            nomeFuncionario.innerHTML = resultado[0].nome;
          })
          .catch((erro) => {
            console.log(erro);
          });
      })
      .catch((erro) => {
        console.log(erro);
      });
  