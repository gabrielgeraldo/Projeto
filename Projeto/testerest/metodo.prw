#include "protheus.ch"
#include "restful.ch"

//Constantes para utilização do SQLite
#define C_SQLITE_DRIVE "SQLITE_SYS"
#define C_TABLE_ETC_NAME "DNL_ETC_JSON"

//Controle de criação de tabelas no SQLite
static __lSqlOk as logical

static function existID(cID)
local lExist as logical
local cAlias as char

lExist := .F.
cAlias := GetNextAlias()

initSQLite()

if DBSqlExec(cAlias, "SELECT COUNT(*) AS QTD_REG FROM " + C_TABLE_ETC_NAME + " WHERE ID_JSON = '" + cId + "'", C_SQLITE_DRIVE)
    lExist := (cAlias)->QTD_REG > 0
    (cAlias)->(DBCloseArea())
endif

return lExist

static function addJson(cJson)
local cUUID as char

cUUID := FWUUIDv4(.F.)

initSQLite()
DBSqlExec("", "INSERT INTO " + C_TABLE_ETC_NAME + " VALUES ('" + cUUID + "', '" + cJson + "')", C_SQLITE_DRIVE)

return cUUID

static function getJson(cId)
local cAlias as char
local cJson as char

cAlias := GetNextAlias()
cJson := ""

initSQLite()

if DBSqlExec(cAlias, "SELECT VALUE_JSON FROM " + C_TABLE_ETC_NAME + " WHERE ID_JSON = '" + cId + "'", C_SQLITE_DRIVE)
    cJson := (cAlias)->VALUE_JSON
    (cAlias)->(DBCloseArea())
endif

return cJson

static function updateJson(cId, cJson)
initSQLite()
return DBSqlExec("", "UPDATE " + C_TABLE_ETC_NAME + " SET VALUE_JSON = '" + cJson + "' WHERE ID_JSON = '" + cId + "'", C_SQLITE_DRIVE)

static function deleteJson(cId)
initSQLite()
return DBSqlExec("", "DELETE FROM " + C_TABLE_ETC_NAME + " WHERE ID_JSON = '" + cId + "'", C_SQLITE_DRIVE)

static function initSQLite()

if __lSqlOk == nil
    if !existTable()
        createTable()
    endif
endif

return nil

static function createTable()
return DBSqlExec("", "CREATE TABLE " + C_TABLE_ETC_NAME + " (ID_JSON VARCHAR(32) PRIMARY KEY, VALUE_JSON CLOB)", C_SQLITE_DRIVE)

static function existTable()
local cAlias as char
local lExist as logical

lExist := .F.
cAlias := GetNextAlias()

if DBSqlExec(cAlias, "SELECT 1 FROM " + C_TABLE_ETC_NAME + " WHERE 0 = 1", C_SQLITE_DRIVE)
    lExist := .T.
    (cAlias)->(DBCloseArea())
endif

return lExist

Static Function getPrdList(oWS)

	Local lRet as logical
	Local oProd as object
	
	DEFAULT oWS:Page := 1
	
	lRet := .T.
	
	oProd := PrdAdapter():new('GET')

	oProd:setPage(oWS:Page)
	oProd:setPageSize(10)
	oProd:GetProd()
	
	IF oProd:lOk
		oWS:setResponse(oProd:getJSONResponse())
	ELSE
		SetRestFault(oProd:GetCode(),oProd:GetMessage())
	ENDIF
	
	oProd:DeActivate()
	oProd := nil
	
Return lRet
















