#include 'protheus.ch'
#include 'parmtype.ch'

// FONTE: http://advpl-protheus.blogspot.com.br/2011/03/conectar-o-protheus-outra-base-de-dados.html
User Function JOBATAE1()

	Local cDBOra  := "POSTGRES/tss" // alterar o alias/dsn para o banco/conexão que está utilizando
	Local cSrvOra  := "localhost" // alterar para o ip do DbAccess
	
	DBSelectArea("SA1")
	dbSetOrder(1)
	/*
	If !SA1->(DbSeek(xFilial("SA1")+"000010"+"1"))
		Alert("Cadastre o cliente: 000010 - CLIENTE PADRAO e realize o processo novamente.")
		Return
	EndIf

	DBSelectArea("SE4")
	dbSetOrder(1)

	If !SE4->(DbSeek(xFilial("SE4")+"001"))
		Alert("Cadastre a forma de pagamento: 001 e realize o processo novamente.")
		Return
	EndIf
	*/
	nHwnd := TCLink(cDBOra, cSrvOra, 7890)

	if nHwnd >= 0

		Alert("*** Conexão OK ***")

		TCSETCONN(nHwnd) // setando conexao com Postgres

		cDataIni := "2018-01-20"
		cDataFim := "2018-01-25"

		LerTab(cDataIni,cDataFim) // lendo uma tabela Postgres

	Else
		Alert("*** Erro de conexão ***")
	endif

	Alert("*** Desconectado ***")

	TCUnlink()

Return

Static Function LerTab(cDataIni, cDataFim)

	Local cQueryNFE
	Local cQueryITEM_NFE

	Local aCabec := {}

	cQueryNFE := "SELECT CODIGO "
	cQueryNFE += "FROM NFE "
	cQueryNFE += "WHERE DATA BETWEEN '"+cDataIni+"' AND '"+cDataFim+"'"

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQueryNFE), "TRS_NFE", .F., .T.)

	cQueryNFE := ChangeQuery(cQueryNFE)
	MemoWrite("C:\relsiga\JOBATAE1_cQueryNFE.txt",cQueryNFE)

	TRS_NFE->(dbGoTop())

	While TRS_NFE->(!Eof())

		Alert("CODIGO NFE: " + cValToChar(TRS_NFE->CODIGO) )

		//****************************************************************
		//* Cabeçalho do pedido.
		//****************************************************************

		aCabec := {}

		aadd(aCabec,{"C5_NUM"   ,"999",Nil})
		aadd(aCabec,{"C5_TIPO" ,"N",Nil})
		aadd(aCabec,{"C5_CLIENTE",SA1->A1_NOME,Nil})
		aadd(aCabec,{"C5_LOJACLI",SA1->A1_LOJA,Nil})
		aadd(aCabec,{"C5_LOJAENT",SA1->A1_LOJA,Nil})
		aadd(aCabec,{"C5_CONDPAG",SE4->E4_CODIGO,Nil})

		Alert(cValToChar( aCabec[1][1] ))

		//****************************************************************
		//* Cabeçalho do pedido.
		//****************************************************************

		cQueryITEM_NFE := "SELECT CODIGO, PRECOVENDA, QUANTIDADE, CFOP_CODIGO, NFE_CODIGO, PRODUTO_CODIGO "
		cQueryITEM_NFE += "FROM ITEM_NFE "
		cQueryITEM_NFE += "WHERE NFE_CODIGO = "+cValToChar(TRS_NFE->CODIGO)

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQueryITEM_NFE), "TRS_ITEM", .F., .T.)
		cQueryITEM_NFE := ChangeQuery(cQueryITEM_NFE)
		MemoWrite("C:\relsiga\JOBATAE1_cQueryITEM_NFEE.txt",cQueryITEM_NFE)

		While TRS_ITEM->(!Eof())

			//****************************************************************
			//* Verificacao produto cadastrado.
			//****************************************************************
			dbSelectArea("SB1")
			dbSetOrder(1)
			If !SB1->(DbSeek(xFilial("SB1")+cValToChar(TRS_ITEM->PRODUTO_CODIGO)))
				Alert("Cadastre o produto:" + cValToChar(TRS_ITEM->PRODUTO_CODIGO) + " e realize o processo novamente.")
				Return
			EndIf

			cItens :=""

			cItens += cValToChar(TRS_ITEM->CODIGO)
			cItens +=" - "+cValToChar(TRS_ITEM->PRECOVENDA)
			cItens +=" - "+cValToChar(TRS_ITEM->QUANTIDADE)
			cItens +=" - "+cValToChar(TRS_ITEM->CFOP_CODIGO)
			cItens +=" - "+cValToChar(TRS_ITEM->NFE_CODIGO)
			cItens +=" - "+cValToChar(TRS_ITEM->PRODUTO_CODIGO)

			Alert("ITENS: "+ cItens)

			TRS_ITEM->(DbSkip())

		EndDo

		TRS_ITEM->(DBCloseArea())

		TRS_NFE->(DbSkip())

	EndDo

	TRS_NFE->(DBCloseArea())

	Alert("*** Fim ***")

Return

