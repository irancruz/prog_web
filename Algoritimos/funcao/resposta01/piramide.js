function piramide(numero) {
    let resposta = '';
    if (!isNaN(numero)) {
        for (let i = 1; i <= numero; i++) {
            for (let j = 1; j < i; j++) {
                resposta += j + ' ';
            }
            resposta += '\n';
        }
        return resposta;
    }
    return -1;
}