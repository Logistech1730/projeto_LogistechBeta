function analisar(){
  var unidades = Number(ipt_unidades.value);
  var valor = Number(ipt_valor.value);
  var rendaMensal = Number(ipt_renda.value);
  var rendaCalculada = (unidades * valor)
  if (rendaCalculada > rendaMensal){
      div_mensagem.innerHTML = `Seu faturamento mensal é de <br> <b style=color:red> R$${rendaMensal} </b> <br> <span><b style=color:red>R$${rendaMensal - rendaCalculada} </b>abaixo do valor esperado </span> <br>Pode indicar um possivel extravio de produtos em seu armazem <br> <br> Para averiguar o possível problema entre em contato conosco.`
  } else if (rendaCalculada < rendaMensal){
      div_mensagem.innerHTML = `Sua renda mensal é de <br> <b style=color:red> R$${rendaMensal - rendaCalculada} </b> <br> Está acima do esperado, <p style=color:green> O que pode ser uma boa noticia </p> <p style=color:red> ou algum erro grave no calculo da renda mensal </p> para averiguar esse possivel problema entre em contato conosco`
  } else if (rendaCalculada == rendaMensal){
      div_mensagem.innerHTML = `Sua renda mensal está de acordo com sua produção<br> <b style=color:green> Não há nenhum problema atualmente na detecção de entrada e saida de seus produtos </b> e caso queira saber mais sobre como melhorar sua produção entre em contato conosco`
  }
}