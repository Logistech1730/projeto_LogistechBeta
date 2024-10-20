var valor_nome_empresa = '';
    var valor_cnpj = '';
    var valor_telefone_empresa = '';
    var valor_cep_empresa = '';

    var valor_logradouro = '';
    var valor_cidade ='';
    var valor_uf = '';
    var valor_numero = '';
    var valor_complemento = '';

    var valor_nome_usuario = '';
    var valor_email_usuario = '';
    var valor_senha_usuario = '';
    var valor_telefone_usuario = '';
    
    var nome_empresa_valido = false;
    var cnpj_valido = false;
    var telefone_comercial_valido = false;
    var cep_valido = false;

    var logradouro_valido = false;
    var cidade_valida = false;
    var uf_valido = false;
    var numero_valido = false;
    var complemento_valido = false;

    var nome_usuario_valido = false;
    var email_usuario_valido = false;
    var senha_usuario_valida = false;
    var confirmacao_usuario_valida = false;
    var telefone_usuario_valido = false;

    function validarNomeEmpresa() {
        valor_nome_empresa = ipt_nome_empresa.value;
        if (valor_nome_empresa != '' && valor_nome_empresa.length >= 3 && valor_nome_empresa.length <= 64) {
            span_validar_nome_empresa.innerHTML = `Razão Social validada com sucesso`;
            span_validar_nome_empresa.style.color = '#069206';
            nome_empresa_valido = true;
        } else {
            span_validar_nome_empresa.style.color = 'red'
            span_validar_nome_empresa.innerHTML = `A Razão Social deve ter no mínimo 3 caracteres`;
            nome_empresa_valido = false;
        }
    }
    function validarCNPJ() {
        valor_cnpj = ipt_cnpj.value;
        var tamanho_cnpj = valor_cnpj.length
        var possui_caractere_especial = valor_cnpj.includes('@') || valor_cnpj.includes('!') || valor_cnpj.includes("'") || valor_cnpj.includes(`"`) || valor_cnpj.includes('#') || valor_cnpj.includes('$') || valor_cnpj.includes('%') || valor_cnpj.includes('¨') || valor_cnpj.includes('&') || valor_cnpj.includes('*') || valor_cnpj.includes(`)`) || valor_cnpj.includes(`(`) || valor_cnpj.includes('_') || valor_cnpj.includes('-') || valor_cnpj.includes('=') || valor_cnpj.includes('+') || valor_cnpj.includes('§') || valor_cnpj.includes('|') || valor_cnpj.includes('\u005C') || valor_cnpj.includes('`') || valor_cnpj.includes('´') || valor_cnpj.includes('[') || valor_cnpj.includes(']') || valor_cnpj.includes('{') || valor_cnpj.includes('}') || valor_cnpj.includes('^') || valor_cnpj.includes('~') || valor_cnpj.includes('ª') || valor_cnpj.includes('º') || valor_cnpj.includes('<') || valor_cnpj.includes('>') || valor_cnpj.includes(',') || valor_cnpj.includes('.') || valor_cnpj.includes(':') || valor_cnpj.includes(';') || valor_cnpj.includes('?') || valor_cnpj.includes('/') || valor_cnpj.includes('°') || valor_cnpj.includes('¹') || valor_cnpj.includes('²') || valor_cnpj.includes('³') || valor_cnpj.includes('£') || valor_cnpj.includes('¢') || valor_cnpj.includes('¬') ;
        if (valor_cnpj != '' && possui_caractere_especial == false && tamanho_cnpj == 14) {
            span_validar_cnpj.style.color = '#069206'
            span_validar_cnpj.innerHTML = `CNPJ preenchido com sucesso`;
            cnpj_valido = true;
        } else if(valor_cnpj == ''){
            span_validar_cnpj.style.color = 'red'
            span_validar_cnpj.innerHTML = `Preencha o CNPJ da empresa para continuar`;
            cnpj_valido = false;
        } else if(possui_caractere_especial == true){
            span_validar_cnpj.style.color = 'red'
            span_validar_cnpj.innerHTML = `o CNPJ deve possuir apenas números e letras`;
            cnpj_valido = false;
        } else if(tamanho_cnpj != 14){
            span_validar_cnpj.style.color = 'red'
            span_validar_cnpj.innerHTML = `o CNPJ deve possuir apenas 14 caracteres`;
            cnpj_valido = false;
        }
    }
    function validarTelefone() {
        valor_telefone_empresa = ipt_telefone_comercial.value;
        var tamanho_telefone = valor_telefone_empresa.length
        var possui_e = valor_telefone_empresa.includes('e')
        if (valor_telefone_empresa != '' && possui_e == false && tamanho_telefone == 11) {
            span_validar_telefone.style.color = '#069206'
            span_validar_telefone.innerHTML = `Telefone preenchido com sucesso`;
            telefone_comercial_valido = true;
        } else if(valor_telefone_empresa == ''){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `Preencha o campo para continuar`;
            telefone_comercial_valido = false;
        } else if(possui_e == true){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `Apenas números são permitidos`;
            telefone_comercial_valido = false;
        } else if(tamanho_telefone != 11){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `O Telefone tem de ter apenas 11 números`;
            telefone_comercial_valido = false;
        }
} 
function validarCEP() {
        valor_cep_empresa = ipt_cep.value;
        var tamanho_telefone = valor_cep_empresa.length
        var possui_e = valor_cep_empresa.includes('e')
        if (valor_telefone_empresa != '' && possui_e == false && tamanho_telefone == 8) {
            span_validar_cep.style.color = '#069206'
            span_validar_cep.innerHTML = `CEP preenchido com sucesso`;
            cep_valido = true;
        } else if(valor_telefone_empresa == ''){
            span_validar_cep.style.color = 'red'
            span_validar_cep.innerHTML = `Preencha o campo para continuar`;
            cep_valido = false;
        } else if(possui_e == true){
            span_validar_cep.style.color = 'red'
            span_validar_cep.innerHTML = `Apenas números são permitidos`;
            cep_valido = false;
        } else if(tamanho_telefone != 11){
            span_validar_cep.style.color = 'red'
            span_validar_cep.innerHTML = `O CEP tem de ter somente 8 números`;
            cep_valido = false;
        }
} 
    function validarParte1() {
        if (nome_empresa_valido == true && cnpj_valido == true && telefone_comercial_valido == true && cep_valido == true) {
            cadastroParte1.style.display = 'none'
            cadastroParte2.style.display = 'flex'
        } else {
            console.log('Algo está errado')
            
        }
    }
    function validarLogradouro() {
        valor_logradouro = ipt_logradouro.value;
        if (valor_logradouro != '' && valor_logradouro.length >= 3 && valor_logradouro.length <= 64) {
            span_validar_logradouro.innerHTML = `Logradouro validado com sucesso`;
            span_validar_logradouro.style.color = '#069206';
            nome_empresa_valido = true;
        } else {
            span_validar_logradouro.style.color = 'red'
            span_validar_logradouro.innerHTML = `A Razão Social deve ter de 3 a 64 caracteres`;
            nome_empresa_valido = false;
        }
    }
    function validarCidade() {
        valor_cidade = ipt_cidade.value;
        if (valor_cidade != '' && valor_cidade.length >= 3 && valor_cidade.length <= 64) {
            span_validar_cidade.innerHTML = `Nome de cidade validado com sucesso`;
            span_validar_cidade.style.color = '#069206';
            cidade_valida = true;
        } else {
            span_validar_cidade.style.color = 'red'
            span_validar_cidade.innerHTML = `O nome de cidade deve ter de 3 a 64 caracteres`;
            cidade_valida = false;
        }
    }
    function validarEstado() {
        valor_estado = ipt_cidade.value;
        uf_valido = true;
    }
    function validarNumero() {
        valor_numero = ipt_numero.value;
        var possui_e = valor_numero.includes('e')
        if (valor_numero != '' && possui_e == false) {
            span_validar_numero.style.color = '#069206'
            span_validar_numero.innerHTML = `Número preenchido com sucesso`;
            numero_valido = true;
        } else if(valor_numero == ''){
            span_validar_numero.style.color = 'red'
            span_validar_numero.innerHTML = `Preencha o campo para continuar`;
            numero_valido = false;
        } else if(possui_e == true){
            span_validar_numero.style.color = 'red'
            span_validar_numero.innerHTML = `Apenas números são permitidos`;
            numero_valido = false;
        } 
    }
    function validarComplemento() {
        valor_complemento = ipt_cidade.value;
        if (valor_complemento != '' && valor_complemento.length >= 3) {
            span_validar_complemento.innerHTML = `Complemento validado com sucesso`;
            span_validar_complemento.style.color = '#069206';
            complemento_valido = true;
        } else {
            span_validar_complemento.style.color = 'red'
            span_validar_complemento.innerHTML = `O Complemento tem de ter no mínimo 6 caracteres`;
            complemento_valido = false;
        }
    }
    function voltarToParte1() {
        cadastroParte1.style.display = 'flex'
        cadastroParte2.style.display = 'none'
    }
    function validarParte2() {
        if (logradouro_valido == true && cidade_valida == true && uf_valido == true && numero_valido == true && complemento_valido == true) {
            cadastroParte2.style.display = 'none'
            cadastroParte3.style.display = 'flex'
        } else {
            console.log('Algo está errado')
            
        }
    }
    function validarNomeUsuario() {
        valor_nome_usuario = ipt_nome_usuario.value;
        if (valor_nome_usuario != '' && valor_nome_usuario.length >= 3 && valor_nome_usuario.length <= 64) {
            span_validar_nome_usuario.innerHTML = `Razão Social validada com sucesso`;
            span_validar_nome_usuario.style.color = '#069206';
            nome_empresa_valido = true;
        } else {
            span_validar_nome_usuario.style.color = 'red'
            span_validar_nome_usuario.innerHTML = `A Razão Social deve ter no mínimo 3 caracteres`;
            nome = false;
        }
    }
    function validarEmail (){
        valor_email_empresa = ipt_email.value;
        var tamanho_email = valor_email_empresa.length;
        var possui_arroba = valor_email_empresa.includes('@');
        var indice_arroba = valor_email_empresa.indexOf('@') + 1;
        var possui_ponto_depois_arroba = valor_email_empresa.includes('.', indice_arroba);
        var indice_ponto_depois_arroba = valor_email_empresa.indexOf('.', indice_arroba) - indice_arroba;
        var possui_pontocom = valor_email_empresa.includes('.com');
        var indice_pontocom = valor_email_empresa.indexOf('.com')+1;
        var indice_extensao = indice_ponto_depois_arroba + indice_arroba;
        console.log(indice_ponto_depois_arroba)
        console.log(indice_extensao)
        console.log(tamanho_email)
        if (valor_email_empresa != '' && possui_arroba == true && indice_arroba > 1 && indice_arroba < tamanho_email && possui_ponto_depois_arroba == true && indice_ponto_depois_arroba >= 2 && (indice_ponto_depois_arroba + indice_arroba+1) < tamanho_email) {
            span_validar_email.style.color = '#069206'
            span_validar_email.innerHTML = `email preenchido com sucesso`;
            valor_email_empresa = valor_email_empresa.toLowerCase();
            email_valido = true;
        } else if(valor_email_empresa == ''){
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `Preencha o campo para continuar`;
            email_valido = false;
        }  else if(possui_arroba == false) {
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `O email precisa ter @`;
            email_valido = false;
        } else if(indice_arroba == 1){
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `O @ não pode ser o primeiro caractere`;
            email_valido = false;
        } else if(indice_arroba == tamanho_email){
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `O @ não pode ser o último caractere`;
            email_valido = false;
        } else if(possui_ponto_depois_arroba == false) {
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `O email precisa ter extensão após o @`;
            email_valido = false;
        } else if(indice_ponto_depois_arroba < 2) {
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `A extensão tem de estar no mínimo a 3 caracteres do @`;
            email_valido = false;
        } else if(indice_ponto_depois_arroba+indice_arroba +1 >= tamanho_email) {
            span_validar_email.style.color = 'red'
            span_validar_email.innerHTML = `O ponto não pode ser o último caractere`;
            email_valido = false;
        }
    }
    function validarSenha() {
        valor_senha_empresa = ipt_senha.value;
        var tamanho_senha = valor_senha_empresa.length;
        var possui_caractere_especial = valor_senha_empresa.includes('@') || valor_senha_empresa.includes('!') || valor_senha_empresa.includes("'") || valor_senha_empresa.includes(`"`) || valor_senha_empresa.includes('#') || valor_senha_empresa.includes('$') || valor_senha_empresa.includes('%') || valor_senha_empresa.includes('¨') || valor_senha_empresa.includes('&') || valor_senha_empresa.includes('*') || valor_senha_empresa.includes(`)`) || valor_senha_empresa.includes(`(`) || valor_senha_empresa.includes('_') || valor_senha_empresa.includes('-') || valor_senha_empresa.includes('=') || valor_senha_empresa.includes('+') || valor_senha_empresa.includes('§') || valor_senha_empresa.includes('|') || valor_senha_empresa.includes('\u005C') || valor_senha_empresa.includes('`') || valor_senha_empresa.includes('´') || valor_senha_empresa.includes('[') || valor_senha_empresa.includes(']') || valor_senha_empresa.includes('{') || valor_senha_empresa.includes('}') || valor_senha_empresa.includes('^') || valor_senha_empresa.includes('~') || valor_senha_empresa.includes('ª') || valor_senha_empresa.includes('º') || valor_senha_empresa.includes('<') || valor_senha_empresa.includes('>') || valor_senha_empresa.includes(',') || valor_senha_empresa.includes('.') || valor_senha_empresa.includes(':') || valor_senha_empresa.includes(';') || valor_senha_empresa.includes('?') || valor_senha_empresa.includes('/') || valor_senha_empresa.includes('°') || valor_senha_empresa.includes('¹') || valor_senha_empresa.includes('²') || valor_senha_empresa.includes('³') || valor_senha_empresa.includes('£') || valor_senha_empresa.includes('¢') || valor_senha_empresa.includes('¬') ;
        var possui_numeros = valor_senha_empresa.includes('1') || valor_senha_empresa.includes('2') || valor_senha_empresa.includes('3') || valor_senha_empresa.includes('4') || valor_senha_empresa.includes('5') || valor_senha_empresa.includes('6') || valor_senha_empresa.includes('7') || valor_senha_empresa.includes('8') || valor_senha_empresa.includes('9') || valor_senha_empresa.includes('0');
        var SENHA_MAIUSCULA = valor_senha_empresa.toUpperCase();
        var senha_minuscula = valor_senha_empresa.toLowerCase();
        if (valor_senha_empresa != '' && senha_minuscula != valor_senha_empresa && SENHA_MAIUSCULA != valor_senha_empresa && possui_caractere_especial == true && tamanho_senha >= 8) {
            span_validar_senha.style.color = '#069206'
            span_validar_senha.innerHTML = `Senha validada com sucesso`;
            senha_valida = true;
        } else if(valor_senha_empresa == '') {
            span_validar_senha.style.color = 'red'
            span_validar_senha.innerHTML = `Preencha a senha para continuar`;
            senha_valida = false;
        } else if(valor_senha_empresa == senha_minuscula) {
            span_validar_senha.style.color = 'red'
            span_validar_senha.innerHTML = `A senha deve conter pelo menos uma letra maiuscula`;
            senha_valida = false;
        } else if(valor_senha_empresa == SENHA_MAIUSCULA) {
            span_validar_senha.style.color = 'red'
            span_validar_senha.innerHTML = `A senha deve conter pelo menos uma letra minuscula`;
            senha_valida = false;
        } else if (possui_caractere_especial == false) {
            span_validar_senha.style.color = 'red'
            span_validar_senha.innerHTML = `A senha deve conter pelo menos um caractere especial`;
            senha_valida = false;
        } else if (tamanho_senha < 8){
            span_validar_senha.style.color = 'red'
            span_validar_senha.innerHTML = `A senha deve conter no mínimo 8 caracteres`;
            senha_valida = false;
        }                
    }
            
    function validarConfirmacao() {
        valor_senha_empresa = ipt_senha.value
        var confirmarSenha = ipt_confirme_senha.value;
        if (confirmarSenha == valor_senha_empresa) {
            span_validar_confirmacao.style.color = '#069206'
            span_validar_confirmacao.innerHTML = `senha confirmada com sucesso`;
            senha_valida = true
        } else {
            span_validar_confirmacao.style.color = 'red'
            span_validar_confirmacao.innerHTML = `A senha está diferente`;
            senha_valida = false;
        }
    }
    function validarTelefoneUsuario() {
        valor_telefone_usuario = ipt_telefone_usuario.value;
        var possui_e = valor_telefone_empresa.includes('e')
        if (valor_telefone_usuario != '' && possui_e == false && valor_telefone_usuario.length == 11) {
            span_validar_telefone.style.color = '#069206'
            span_validar_telefone.innerHTML = `Telefone preenchido com sucesso`;
            telefone_usuario_valido = true;
        } else if(valor_telefone_usuario == ''){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `Preencha o campo para continuar`;
            telefone_usuario_valido = false;
        } else if(possui_e == true){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `Apenas números são permitidos`;
            telefone_usuario_valido = false;
        } else if(valor_telefone_usuario != 11){
            span_validar_telefone.style.color = 'red'
            span_validar_telefone.innerHTML = `O Telefone tem de ter apenas 11 números`;
            telefone_usuario_valido = false;
        }
    }
    function voltarToParte2() {
        cadastroParte2.style.display = 'flex'
        cadastroParte3.style.display = 'none'
    }
    function validarParte3() {
        if (nome_usuario_valido == true && email_valido == true && senha_valida == true && confirmacao_usuario_valida == true && telefone_usuario_valido == true) {
            window.location.href = 'dashboard.html'
        } else {
            console.log('Algo está errado')
            
        }
    }
        

    function cadastrar() {
        window.location.href = 'cadastro.html'
    }