//Bibliotecas
#Include "Protheus.ch"

/*-------------------------------------------------*
 | P.E.:   A010TOK                                 |
 | Autor:  Daniel Atilio                           |
 | Data:   13/12/2015                              |
 | Descr.: Fun��o que valida o cadastro de produto |
 *-------------------------------------------------*/

User Function A010TOK()
	Local aArea := GetArea()
	Local aAreaB1 := SB1->(GetArea())
	Local aAreaZ9 := ZZ9->(GetArea())
	Local lRet := .T.
	
	//Mostrando a pergunta
	lRet := MsgYesNo("Confirma o cadastro do produto <b>"+M->B1_DESC+"</b>?", "Aten��o")
	
	If lRet = .T.
 		//Verifica cadastro ZZ9
		dbSelectArea("ZZ9")
   		dbSetOrder(1)

		If DbSeek(xFilial() + "210" + "gabriel domingos geraldo" )
   	   		MsgInfo("A 'pessoa' <b>gabriel domingos geraldo</b> com o c�digo <b>210</b> foi localizada na tabela ZZ9, o produto <b>"+AllTrim(M->B1_DESC)+"</b> ser� cadastrado!", "Aviso")
   		Else   
	   		MsgAlert("A 'pessoa' <b>gabriel domingos geraldo</b> com o c�digo <b>210</b> n�o est� cadastrada na tabela ZZ9, o produto <b>"+AllTrim(M->B1_DESC)+"</b> n�o ser� cadastrado!", "Aviso")
   	   		lRet := .F.
   		EndIf
  	EndIf
		
	RestArea(aAreaB1)
	RestArea(aAreaZ9)
	RestArea(aArea)
Return lRet