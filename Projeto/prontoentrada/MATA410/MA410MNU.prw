//Bibliotecas
#Include 'Protheus.ch'
#Include 'RwMake.ch'
#Include 'TopConn.ch'

/*------------------------------------------------------------------------------------------------------*
| P.E.:  MA410MNU                                                                                      |
| Desc:  Adição de opção no menu de ações relacionadas do Pedido de Vendas                             |
| Links: http://tdn.totvs.com/display/public/mp/MA410MNU                                               |
*------------------------------------------------------------------------------------------------------*/

User Function MA410MNU()
	Local aArea := GetArea()

	//Adicionando função de vincular
	aadd( aRotina,{"Imp NF-e ITA","U_JOBATAE1()",0,7,0, nil} )

	RestArea(aArea)
Return