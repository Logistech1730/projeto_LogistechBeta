//Seleciono o botão para abrir e fechar o modal
const openButton = document.getElementById('btnCadastro')
const closeButton = document.getElementById('closeButton')

//Adiciono um ouvinte de click no botão para abrir o modal
    openButton.addEventListener('click', () => {
        //O valor de data-modal é atribuido a constante modalId
        const modalId = openButton.getAttribute('data-modal');
        //O valor modal-1 está na tag dialog, sendo referenciado pelo valor que está dentro de data-modal
        const modal = document.getElementById(modalId);
        //adiciona a classe show ao elemento modal
        modal.classList.add('show');
        //função nativa do js que abre o modal
        modal.showModal();
    });

    closeButton.addEventListener('click', () => {
        const modalId = closeButton.getAttribute('data-modal');
        const modal = document.getElementById(modalId);
        modal.classList.remove('show');
        modal.close();
    });


function dataAtual() {
    return new Date().toLocaleDateString('pt-BR');
}

function gerarAleatorio(){
    return Math.floor((Math.random() * 1000))
}

function horarioAleatorio(){
    let hora = Math.floor((Math.random() * 25))
    let minuto = Math.floor((Math.random() * 60))

    if (hora < 10){
        hora = `0${hora}`
    }

    if(minuto < 10){
        minuto = `0${minuto}`
    }

    return `${hora}:${minuto}`
}

document.getElementById('cadastroBtn').addEventListener('click', () => {

     //O valor de data-modal é atribuido a constante modalId
     const modalId = openButton.getAttribute('data-modal');
     //O valor modal-1 está na tag dialog, sendo referenciado pelo valor que está dentro de data-modal
     const modal = document.getElementById(modalId);


    const nomeMetrica = document.getElementById('inpNome').value;
    const valorMinimo = document.getElementById('inpValorMinimo').value;
    const valorMaximo = document.getElementById('inpValorMaximo').value;
    const cor = document.getElementById('inpCor').value;

    let containerAviso = document.getElementById('container-aviso')
    let conteudoExistente = containerAviso.querySelectorAll('p').length

    if((nomeMetrica.value === '' ||  valorMinimo.value === ''  || valorMaximo.value === '' || cor === '') && conteudoExistente < 1){
        let aviso = document.createElement('p')
        aviso.textContent = 'Preencha os campos'
        aviso.style.color = 'red'
        containerAviso.appendChild(aviso)
        return
    }else{
        div_containerEsteiras.innerHTML += `
         <div class="cardEsteira">
                    <div class="leftContainer">
                        <div class="titulo">
                            <h6 style="color: ${cor};">${nomeMetrica}</h6>
                            <div class="icons">
                                <i class="fa-solid fa-trash"></i>
                                <i class="fa-solid fa-pencil"></i>
                            </div>
                        </div>
                        
                        <p>Nome</p>
                        <p>${nomeMetrica}</p>
                        <p>Valor mínimo</p>
                        <p>${valorMinimo}%</p>
                        <p>Valor Máximo</p>
                        <p>${valorMaximo}%</p>
                        <p>Data de cadastro</p>
                        <p>30/10/2024</p>
                        <p>Cor</p>
                        <p>${cor}</p>
                </div>

        `;

        // depois que cadastrei, devo desaparecer com o modal de cadastro
        const modalId = closeButton.getAttribute('data-modal');
        const modal = document.getElementById(modalId);
        modal.classList.remove('show');
        modal.close();
    
        
        }


    
 }) 