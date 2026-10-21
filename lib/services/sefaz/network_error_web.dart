// No navegador não há acesso ao socket: o package:http converte toda falha de
// rede em ClientException, que o chamador já trata.
bool isLowLevelNetworkError(Object error) => false;
