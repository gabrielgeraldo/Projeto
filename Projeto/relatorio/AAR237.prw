/*/
==================================================================
Autor      : Gabriel Geraldo / Frias
------------------------------------------------------------------
Data       : 31/11/17
------------------------------------------------------------------
Descricao  : Relatório - Itens PVs por Centro de Custo
------------------------------------------------------------------
Partida    : Menu
==================================================================
/*/         

#include "rwmake.ch"
#include "topconn.ch" 
#include "protheus.ch"  
#DEFINE  cEol CHR(13)+CHR(10)    

**********************
User Function AAR237()
**********************

   Local aArrSay     := {}
   Local aArrBut     := {}
   Local cArqTxt     := ""
   Local lExeFun     := .F.
 
   Private aSX1      := {}
   Private cPerg     := "AAR237"
   Private cNomeRel  := "Relatório - Itens PVs por Centro de Custo"       
   
            //(<cGrupo>, <cOrdem>, <cPergunt>             , <cPergSpa>, <cPergEng>, <cVar>   , <cTipo>, <nTamanho> , [nDecimal] , [nPreSel], <cGSC>, [cValid], [cF3]   , [cGrpSXG], [cPyme], <cVar01>  , [cDef01]   , [cDefSpa1], [cDefEng1], [cCnt01]   , [cDef02]   , [cDefSpa2], [cDefEng2], [cDef03], [cDefSpa3], [cDefEng3], [cDef04], [cDefSpa4], [cDefEng4], [cDef05], [cDefSpa5], [cDefEng5], [aHelpPor], [aHelpEng], [aHelpSpa], [cHelp])
   aAdd(aSX1, {cPerg   , "01"    , "Filial de?     "      , ""        , ""        , "MV_CH1" , "C"    , 2          , 0          , 1        , "G"   , ""      , ""      , ""       , "N"    , "MV_PAR01", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })
   aAdd(aSX1, {cPerg   , "02"    , "Filial ate?    "      , ""        , ""        , "MV_CH2" , "C"    , 2          , 0          , 1        , "G"   , ""      , ""      , ""       , "N"    , "MV_PAR02", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "03"    , "Emissao de?    "      , ""        , ""        , "MV_CH3" , "D"    , 8          , 0          , 0        , "G"   , ""      , ""      , ""       , "N"    , "MV_PAR03", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })
   aAdd(aSX1, {cPerg   , "04"    , "Emissao de?    "      , ""        , ""        , "MV_CH4" , "D"    , 8          , 0          , 0        , "G"   , ""      , ""      , ""       , "N"    , "MV_PAR04", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })
   aAdd(aSX1, {cPerg   , "05"    , "C. Custo de?   "      , ""        , ""        , "MV_CH5" , "C"    , 9          , 0          , 0        , "G"   , ""      , "CTT"   , ""       , "N"    , "MV_PAR05", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "06"    , "C. Custo ate?  "      , ""        , ""        , "MV_CH6" , "C"    , 9          , 0          , 0        , "G"   , ""      , "CTT"   , ""       , "N"    , "MV_PAR06", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })
   aAdd(aSX1, {cPerg   , "07"    , "Produto de?    "      , ""        , ""        , "MV_CH7" , "C"    , 15         , 0          , 0        , "G"   , ""      , "SB1"   , ""       , "N"    , "MV_PAR07", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "08"    , "Produto ate?   "      , ""        , ""        , "MV_CH8" , "C"    , 15         , 0          , 0        , "G"   , ""      , "SB1"   , ""       , "N"    , "MV_PAR08", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "09"    , "TES de?        "      , ""        , ""        , "MV_CH9" , "C"    , 3          , 0          , 0        , "G"   , ""      , "SF4"   , ""       , "N"    , "MV_PAR09", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "10"    , "TES ate?       "      , ""        , ""        , "MV_CHA" , "C"    , 3          , 0          , 0        , "G"   , ""      , "SF4"   , ""       , "N"    , "MV_PAR10", ""         , ""        , ""        , ""         , ""         , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
   aAdd(aSX1, {cPerg   , "11"    , "Faturado?      "      , ""        , ""        , "MV_CHB" , "N"    , 1          , 0          , 0        , "C"   , ""      , ""      , ""       , "N"    , "MV_PAR11", "Sim"      , ""        , ""        , ""         , "Nao"      , ""        , ""        , "Todos" , ""        , ""        , ""      , ""        , ""        , ""      , ""        , ""        , {}        , {}        , {}        , ""     })   
                                                                                                        
   fCriaSX1()
   
   Pergunte(cPerg, .T.)
 
   aAdd(aArrSay, "Relatório - Itens PVs por Centro de Custo")
 
   aAdd(aArrBut, {5, .T., {|| Pergunte(cPerg, .T.)        }})
   aAdd(aArrBut, {1, .T., {|| lExeFun := .T., FechaBatch()}})
   aAdd(aArrBut, {2, .T., {|| lExeFun := .F., FechaBatch()}})
 
   FormBatch(cNomeRel, aArrSay, aArrBut)
   
   If !lExeFun                                                     
      Return()   
   EndIf

   Processa({|| fMontaRel()}, "Aguarde...", "Capturando dados para montar o relatório...")
Return()

***************************
Static Function fMontaRel()
***************************   

   Private lPlanilha := .T.         
   Private aDetalhes := {}
   Private nCont     := 0
      
   Private cFilIni     := MV_PAR01
   Private cFilFim     := MV_PAR02
   Private cEmiIni     := MV_PAR03
   Private cEmiFim     := MV_PAR04  
   Private cCenIni     := MV_PAR05
   Private cCenFim     := MV_PAR06  
   Private cProIni     := MV_PAR07
   Private cProFim     := MV_PAR08
   Private cTesIni     := MV_PAR09
   Private cTesFim     := MV_PAR10
   Private cFatFim     := MV_PAR11
   
   cQuery  := "SELECT 						   			"+cEol
   cQuery  += "   SC6.C6_FILIAL FILIAL,			   		"+cEol
   cQuery  += "   SC6.C6_NUM PV,						"+cEol
   cQuery  += "   SC5.C5_NUMINTE PEDIDO_LV,				"+cEol
   cQuery  += "   SC6.C6_ITEM ITEM,	   	   				"+cEol
   cQuery  += "   SC6.C6_PRODUTO CODIGO,				"+cEol
   cQuery  += "   SC6.C6_DESCRI SERVICO,				"+cEol
   cQuery  += "   SC6.C6_UM UN,	  						"+cEol
   cQuery  += "   SC6.C6_QTDVEN QUANT,					"+cEol
   cQuery  += "   SC6.C6_PRCVEN P_UNIT,	   				"+cEol
   cQuery  += "   SC6.C6_VALOR TOTAL,					"+cEol
   cQuery  += "   SC6.C6_TES TES,	   					"+cEol
   cQuery  += "   SC6.C6_NOTA NFSE,						"+cEol
   cQuery  += "   SC6.C6_SERIE SERIE,			   		"+cEol
   cQuery  += "   SC6.C6_DATFAT EMISSAO_NF,				"+cEol
   cQuery  += "   SC5.C5_CC C_CUSTO,					"+cEol
   cQuery  += "   SC5.C5_EMISSAO EMISSAO_PV				"+cEol
   cQuery  += "FROM "+RetSQLName("SC6")+" SC6,	   		"+cEol
   cQuery  += "   	"+RetSQLName("SC5")+" SC5			"+cEol
   cQuery  += "WHERE SC5.D_E_L_E_T_ = ' '				"+cEol
   cQuery  += "  AND SC6.D_E_L_E_T_ = ' '				"+cEol
   cQuery  += "  AND SC5.C5_FILIAL  					"+cEol
   cQuery  += "  BETWEEN '"+cFilIni+"'      		  	"+cEol
   cQuery  += "      AND '"+cFilFim+"'      	    	"+cEol
   cQuery  += "   AND SC5.C5_FILIAL = SC6.C6_FILIAL		"+cEol
   cQuery  += "   AND SC5.C5_NUM = SC6.C6_NUM			"+cEol
   cQuery  += "   AND SC5.C5_EMISSAO           			"+cEol
   cQuery  += "  BETWEEN '"+DTOS(cEmiIni)+"' 		 	"+cEol
   cQuery  += "      AND '"+DTOS(cEmiFim)+"'			"+cEol  
   cQuery  += "   AND SC5.C5_CC             			"+cEol
   cQuery  += "  BETWEEN '"+cCenIni+"' 			    	"+cEol
   cQuery  += "      AND '"+cCenFim+"'			     	"+cEol   
   cQuery  += "   AND SC6.C6_PRODUTO                 	"+cEol
   cQuery  += "  BETWEEN '"+cProIni+"' 			    	"+cEol
   cQuery  += "      AND '"+cProFim+"'			     	"+cEol
   cQuery  += "   AND SC6.C6_TES                     	"+cEol
   cQuery  += "  BETWEEN '"+cTesIni+"' 			    	"+cEol
   cQuery  += "      AND '"+cTesFim+"'			     	"+cEol
   
   IF cFatFim = 1
     cQuery  += "AND SC6.C6_NOTA <> ' '					"+cEol
   ELSEIF cFatFim = 2
     cQuery  += "AND SC6.C6_NOTA = ' '					"+cEol
   ELSEIF cFatFim = 3
     cQuery  += "AND (SC6.C6_NOTA <> ' '				"+cEol
     cQuery  += "OR SC6.C6_NOTA = ' ')					"+cEol
   ENDIF           
     
   cQuery  += "ORDER BY SC6.C6_FILIAL,					"+cEol
   cQuery  += "   SC6.C6_NUM,							"+cEol
   cQuery  += "   SC6.C6_ITEM							"+cEol

   cQuery := ChangeQuery(cQuery)
   MemoWrite("C:\relsiga\AAR237.txt",cQuery)   

   If Select("TRB") > 0
      TRB->(DBCloseArea())
   EndIf

   DBUseArea( .T., "TOPCONN", TcGenQry(,, cQuery), "TRB", .T., .T.)
   
   nCont := 0
   
   TRB->(DBGoTop())
   TRB->(DBEval({|| nCont++}))
   TRB->(DBGoTop())
   
   ProcRegua(nCont)
   
   While TRB->(!Eof()) 
   
      IncProc("Capturando dados...")
   
      aAdd(aDetalhes, {TRB->FILIAL,;
                       TRB->PV,;
                       TRB->PEDIDO_LV,;
                       TRB->ITEM,; 
                       TRB->CODIGO,;
      				   TRB->SERVICO,;
      				   TRB->UN,;
      				   TRB->QUANT,;
      				   TRB->P_UNIT,;
      				   TRB->TOTAL,;
      				   TRB->TES,;
      				   TRB->NFSE,;
      				   TRB->SERIE,;
      				   TRB->EMISSAO_NF,;
      				   TRB->C_CUSTO,;
                       TRB->EMISSAO_PV})	                    		
               	                            
      TRB->(DBSkip())
   End
         
   TRB->(DBCloseArea())
   
   If lPlanilha
      fGeraPlan()   
   EndIf         
Return()

***************************
Static Function fGeraPlan()
***************************

   Local oExcelApp := Nil
   Local oExcel    := FWMSEXCEL():New()
   Local cArquivo  := "AAR237.xls"
   Local cPath     := "C:\RELSIGA"
   Local cAba1     := "Parametros"
   Local cTab1     := "Parametros"
   Local cAba2     := "Relatório"
   Local cTab2     := cNomeRel
   
   If !ApOleClient("MsExcel") //Verifica que o Excel está instalado
      MsgAlert("MsExcel nao instalado")
      Return()
   EndIf
   
   oExcel:AddworkSheet(cAba1) 
   oExcel:AddTable(cAba1, cTab1)
   oExcel:AddColumn(cAba1, cTab1, "Parâmetros"          , 1, 1, .F.)
   oExcel:AddColumn(cAba1, cTab1, "Conteúdo Selecionado", 1, 1, .F.)
   For I := 1 To Len(aSX1)
       oExcel:AddRow(cAba1, cTab1, {aSX1[I, 03], &(aSX1[I, 16])})
   Next	   

   oExcel:AddworkSheet(cAba2) 
   oExcel:AddTable(cAba2, cTab2)
   oExcel:AddColumn(cAba2, cTab2, "FILIAL"           , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "PV"     			 , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "PEDIDO_LV"        , 1, 1, .F.)
   oExcel:AddColumn(cAba2, cTab2, "ITEM"             , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "CODIGO"           , 1, 1, .F.)          
   oExcel:AddColumn(cAba2, cTab2, "SERVICO"          , 1, 1, .F.)    
   oExcel:AddColumn(cAba2, cTab2, "UN"               , 1, 1, .F.)    
   oExcel:AddColumn(cAba2, cTab2, "QUANT"            , 1, 1, .F.)
   oExcel:AddColumn(cAba2, cTab2, "P_UNIT"           , 1, 1, .F.)
   oExcel:AddColumn(cAba2, cTab2, "TOTAL"            , 1, 1, .F.)
   oExcel:AddColumn(cAba2, cTab2, "TES"              , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "NFSE"             , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "SERIE"            , 1, 1, .F.) 
   oExcel:AddColumn(cAba2, cTab2, "EMISSAO_NE"       , 1, 1, .F.)                         
   oExcel:AddColumn(cAba2, cTab2, "C_CUSTO"          , 1, 1, .F.)                                                            
   oExcel:AddColumn(cAba2, cTab2, "EMISSAO_PV"       , 1, 1, .F.)        
   
   ProcRegua(Len(aDetalhes))
                         
   For I := 1 To Len(aDetalhes)
   
       IncProc("Gerando planilha...")        
           
          oExcel:AddRow(cAba2, cTab2, {aDetalhes[I, 1],;
                                       aDetalhes[I, 2],;
                                       aDetalhes[I, 3],;
                                       aDetalhes[I, 4],;
                                       aDetalhes[I, 5],;
                                       aDetalhes[I, 6],;
                                       aDetalhes[I, 7],;
                                       aDetalhes[I, 8],;
                                       aDetalhes[I, 9],;
                                       aDetalhes[I, 10],;
                                       aDetalhes[I, 11],;
                                       aDetalhes[I, 12],;
                                       aDetalhes[I, 13],;
                                       aDetalhes[I, 14],;
                                       aDetalhes[I, 15],;
                                       aDetalhes[I, 16]})                                    
   Next

   If !Empty(oExcel:aWorkSheet)
      If File(cPath+"\"+cArquivo)
         If FErase(cPath+"\"+cArquivo) < 0
            MsgAlert("Não foi possível criar o arquivo temporário do planilha no servidor.", "Atenção")
            Return()
         EndIf
      EndIf 

      If ExistDir(cPath+"\")
         If File(cPath+"\"+cArquivo)
            If FErase(cPath+"\"+cArquivo) < 0
               MsgAlert("Não foi possível criar o arquivo temporário do planilha na estação.", "Atenção")
               Return()
            EndIf
         EndIf 
      Else
         If MakeDir(cPath) != 0
            MsgAlert("Não foi possível criar a pasta C:\RELSIGA na máquina do usuário!", "Atenção")
            Return()
         EndIf
      EndIf

      oExcel:Activate()
      oExcel:GetXMLFile(cPath+"\"+cArquivo)
            
      //ShellExecute("Open", +cPath+"\"+cArquivo, " /k dir", "C:\", 1 )
      
      oExcelApp := MsExcel():New()
      oExcelApp:WorkBooks:Open(cPath+"\"+cArquivo) // Abre uma planilha
      oExcelApp:SetVisible(.T.)
      
   EndIf
      
Return()   

**************************
Static Function fCriaSX1()
**************************

   For I := 1 To Len(aSX1)
       PutSx1(aSX1[I, 01],;
              aSX1[I, 02],;
              aSX1[I, 03],;
              aSX1[I, 04],;
              aSX1[I, 05],;
              aSX1[I, 06],;
              aSX1[I, 07],;
              aSX1[I, 08],;
              aSX1[I, 09],;
              aSX1[I, 10],;
              aSX1[I, 11],;
              aSX1[I, 12],;
              aSX1[I, 13],;
              aSX1[I, 14],;
              aSX1[I, 15],;
              aSX1[I, 16],;
              aSX1[I, 17],;
              aSX1[I, 18],;
              aSX1[I, 19],;
              aSX1[I, 20],;
              aSX1[I, 21],;
              aSX1[I, 22],;
              aSX1[I, 23],;
              aSX1[I, 24],;
              aSX1[I, 25],;
              aSX1[I, 26],;
              aSX1[I, 27],;
              aSX1[I, 28],;
              aSX1[I, 29],;
              aSX1[I, 30],;
              aSX1[I, 31],;
              aSX1[I, 32],;
              aSX1[I, 33],;
              aSX1[I, 34],;
              aSX1[I, 35],;
              aSX1[I, 36])
   Next   
Return()       