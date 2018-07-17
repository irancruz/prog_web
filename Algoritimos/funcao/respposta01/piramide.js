function piramide(numero){
    let resposta = '';
    if (!isNaN(numero)) {//se não é um numero
        for (let i = 1; i <= numero; i++){
            for (let j = 1; j <= i; j++){
                resposta += i + ' ';
            }
            resposta += '\n';
        }
        return resposta;
    }
    return 0;
}

function piramidesoma(numero){
    let resposta = '';
    if (!isNaN(numero)) {//se não é um numero
        for (let i = 1; i <= numero; i++){
            for (let j = 1; j <= i; j++){
                resposta += j + ' ';
            }
            resposta += '\n';
        }
        return resposta;
    }
    return 0;
}
