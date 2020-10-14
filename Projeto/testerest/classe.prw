#include "protheus.ch"
#include "restful.ch"

wsrestful DnlRestETC description "REST de exemplo! =]"
wsdata idJSON as char optional

wsmethod post description "Recebe um JSON e armazena o mesmo no SQLite" wssyntax "dnlrestetc/v1" path "dnlrestetc/v1"
wsmethod get description "Retorna o JSON armazenado do ID informado" wssyntax "dnlrestetc/v1/{idJSON}" path "dnlrestetc/v1/{idJSON}"
wsmethod put description "Atualiza o JSON do ID informado" wssyntax "dnlrestetc/v1/{idJSON}" path "dnlrestetc/v1/{idJSON}"
wsmethod delete description "Deleta o JSON do ID informado" wssyntax "dnlrestetc/v1/{idJSON}" path "dnlrestetc/v1/{idJSON}"

wsmethod get ProdList; 
	DESCRIPTION "Retorna uma lista de produtos";
	wssyntax "/api/v1/products";
	path "/api/v1/products";
	PRODUCES APPLICATION_JSON

end wsrestful