
const display = document.getElementById('display');
const botoes = document.querySelectorAll('.btn');
const temaBtn = document.getElementById('alternar-tema');
const listaHistorico = document.getElementById('lista-historico');

temaBtn.addEventListener('click', () => {
  document.body.classList.toggle('escuro');
  document.body.classList.toggle('claro');
  temaBtn.textContent = document.body.classList.contains('escuro') ? '☀️' : '🌙';
});

// Armazena o histórico localmente
let historico = [];

function adicionarAoHistorico(expressao, resultado) {
  const entrada = `${expressao} = ${resultado}`;
  historico.unshift(entrada);
  if (historico.length > 10) historico.pop();

  listaHistorico.innerHTML = '';
  historico.forEach(item => {
    const li = document.createElement('li');
    li.textContent = item;
    listaHistorico.appendChild(li);
  });
}

function calcularExpressao(expr) {
  try {
    let expressao = expr
      .replace(/÷/g, '/')
      .replace(/×/g, '*')
      .replace(/,/g, '.')
      .replace(/√/g, 'Math.sqrt')
      .replace(/%/g, '/100')
      .replace(/(\d+)\^/g, 'Math.pow($1,2)');

    const resultado = eval(expressao);
    adicionarAoHistorico(expr, resultado);
    return resultado;
  } catch (e) {
    return 'Erro';
  }
}

botoes.forEach(botao => {
  botao.addEventListener('click', () => {
    const valor = botao.dataset.valor;

    switch (valor) {
      case 'C':
        display.value = '';
        break;
      case '=':
        display.value = calcularExpressao(display.value);
        break;
      case '←':
        display.value = display.value.slice(0, -1);
        break;
      default:
        display.value += valor;
    }
  });
});

// Suporte ao teclado físico
document.addEventListener('keydown', (e) => {
  const tecla = e.key;

  if ("0123456789()+-*/.".includes(tecla)) {
    display.value += tecla;
  } else if (tecla === 'Enter') {
    display.value = calcularExpressao(display.value);
  } else if (tecla === 'Backspace') {
    display.value = display.value.slice(0, -1);
  } else if (tecla === 'Delete') {
    display.value = '';
  }
});
