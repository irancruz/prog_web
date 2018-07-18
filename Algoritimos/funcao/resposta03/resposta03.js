function somar(a, b, c) {
    let resultado = -1;
    if (!isNaN(a) && !isNaN(b) && !isNaN(c)) {
        resultado = a + b + c;   
    }
    
    return resultado;
}