SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF

SET EXACT ON
SET DEFAULT TO d:\apdongguan
CLOSE ALL

loXls = Createobject("excel.application")
bookExcel = loXls.Application.Workbooks.Open("d:\download\欧确纳到货.xls")
nrows=bookExcel.Worksheets('sheet1')
UsedRange =nrows.UsedRange
MyMaxRow=UsedRange.Rows.Count &&有数据的总行数
MyMaxColumn=UsedRange.Columns.Count &&有数据的总列数
loXls.Workbooks.Close
loXls.Quit

oExcel=Createobject("Excel.application")
oExcel.Workbooks.Open("d:\download\欧确纳到货.xls")
oExcel.Worksheets("sheet1").Activate
&&objexcel.worksheets("sheet1").range("a:c").activate
oExcel.worksheets("sheet1").range("A1").activate
oExcel.selection.sort(oExcel.range("A1"),1,,,,,,0, 1, ,1, ,,,) 

USE  patrack
COPY TO patrackcomp1 FOR !'cancel'$note AND contract2!=' '
USE patrackcomp1
INDEX on contract2+item_no+contract0 TAG item_no
TOTAL ON contract2+item_no+contract0 TO patrackcomp2 FIELDS orderqty

USE patrackcomp2
FOR MyRows=2 TO MyMaxRow
&&EuContract=LEFT(oExcel.cells(MyRows,1).Value,14)
oExcel.CELLS(MyRows,2).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.NumberFormatLocal = "@" &&把被选定的单元格设为文本格式
AurContract=oExcel.cells(MyRows,2).Value
&&AurContract
&&AurContract=STR(AurContract,100)
&&AurContract= ALLTRIM(AurContract)

oExcel.CELLS(MyRows,4).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.NumberFormatLocal = "@" &&把被选定的单元格设为文本格式
AurItem=oExcel.cells(MyRows,4).Value
&&?AurItem
&&AurItem=ALLTRIM(STR(AurItem,50))

oExcel.CELLS(MyRows,7).Select &&或eole.Range("A1:E1").Select
AurQty=oExcel.cells(MyRows,7).Value

&&AurQty=INT(AurQty)
&&AurQty=VAL(ALLTRIM(AurQty))
AurQty=STR(AurQty,20)
AurQty=VAL(AurQty)
AurQty=INT(AurQty)
&&?AurQty

GO top
LOCATE FOR ALLTRIM(AurContract)$ALLTRIM(contract2) AND (ALLTRIM(item_no)$ALLTRIM(AurItem);
OR ALLTRIM(AurItem)$ALLTRIM(item_no) OR ALLTRIM(AurItem)=ALLTRIM(item_no) ) AND AurQty=orderqty AND DELETED()=.F. 
&&LOCATE FOR ALLTRIM(AurContract)$ALLTRIM(contract2) 
IF FOUND() 
oExcel.cells(MyRows,MyMaxColumn+1).Value=ALLTRIM(contract0)
DELETE
ELSE
oExcel.cells(MyRows,MyMaxColumn+1).Value=ALLTRIM('not found')
ENDIF
NEXT MyRows
RECALL all
USE

MyFile='E:\LWG\欧确纳固邦采购事宜\最新库存\'
MyFile=MyFile+ALLTRIM('欧确纳最新到货')
&&oExcel.ActiveWorkbook.SaveAs('D:\APDongguan\NewTest.xls',39) &&另存为5.0的Excel，或用43表示95/97格式
oExcel.ActiveWorkbook.saved=.T.  &&不保存当前EXCEL表
oExcel.ActiveWorkbook.SaveAs(MyFile,39) &&另存为5.0的Excel，或用43表示95/97格式
oExcel.Workbooks.Close &&关闭表
oExcel.Quit &&退出EXCEL
Release oExcel &&释放变量

CLOSE ALL
SET TALK ON
SET SAFETY ON
SET EXACT OFF
CLEAR 
RETURN
CLOSE ALL