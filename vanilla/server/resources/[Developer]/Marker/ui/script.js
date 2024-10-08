// Estrutura dos itens
const items = [
    {
        name: 'ITEM 1',
        image: 'assets/flor.png',
        price: '$100,00'
    },
    {
        name: 'ITEM 2',
        image: 'assets/flor.png',
        price: '$150,00'
    },
    {
        name: 'ITEM 3',
        image: 'assets/flor.png',
        price: '$200,00'
    }
];

// Função para criar os itens na interface
function loadItems() {
    const containerItens = document.getElementById('container-itens');
    containerItens.innerHTML = ''; // Limpa o container antes de adicionar novos itens

    items.forEach(item => {
        const itemDiv = document.createElement('div');
        itemDiv.classList.add('item');

        itemDiv.innerHTML = `
            <p>${item.name}</p>
            <img src="${item.image}" alt="${item.name}" width="50" height="60">
            <p>${item.price}</p>
            <button>Comprar</button>
        `;

        containerItens.appendChild(itemDiv);
    });
}

// Receber mensagens do Lua
window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        document.getElementById('container').style.display = 'flex';
        loadItems(); // Carrega os itens dinamicamente quando abrir
    }
});

// Fechar o menu
document.getElementById('fechar').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/fecharNui`);
    document.getElementById('container').style.display = 'none';
});

// Fechar o menu com 'ESC'
document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        fetch(`https://${GetParentResourceName()}/fecharNui`);
        document.getElementById('container').style.display = 'none';
    }
});
