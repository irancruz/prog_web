function piramide(numero) {
    let resposta = '';
    if (!isNaN(numero)) {
        for (let i = 0; i <= numero; i++) {
            for (let j = 0; j <= i; j++) {
                resposta += (j+1) + ' ';
            }
            resposta += '\n';
        }
        return resposta;
    }
    return -1;
}