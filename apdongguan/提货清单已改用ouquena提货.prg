
SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF
SET EXACT ON
SET DEFAULT TO d:\apdongguan
CLOSE ALL

SELECT 6
USE patrackinputhelp
SELECT 1
USE patrack
COPY TO goodstake1 FOR iftake='yes' AND taketime=f.taketime FIELDS item_no,contract3,conprice3,orderqty,qtytake,moneyneed,takeshort,taketime,moneylimit
USE d:\apdongguan\goodstake1
&&INDEX on  contract3 TAG contract3 &&rushmore技术
SORT TO goodstake4 ON contract3  FIELDS item_no,contract3,conprice3,orderqty,qtytake,moneyneed,takeshort,taketime,moneylimit
USE goodstake4
REPLACE ALL moneyneed with ROUND(qtytake*conprice3*1.17,2)
SUM ALL moneyneed TO paymoney
paymoney = ROUND(paymoney,2)
&&moneyleft=f.moneylimit-paymoney
&&COPY TO goodstake2
&&USE goodstake2
&&ZAP

COPY TO goodstake3
USE goodstake3
ZAP
CLOSE all
SELECT 2
USE d:\apdongguan\goodstake4
GO bottom
APPEND BLANK
GO top
aa=ALLTRIM(contract3)
FOR MyCount=1 TO RECCOUNT()
GO MyCount
bb=ALLTRIM(contract3)
IF bb!=aa then
   CLOSE ALL
   SELECT 2
   USE d:\apdongguan\goodstake4
   COPY TO goodstake2 FOR contract3=aa
           SELECT 3
           USE goodstake2
           SUM ALL moneyneed TO paymoney1
           SELECT 4
           USE goodstake3
           APPEND FROM goodstake2
           APPEND BLANK
           GO bottom
           REPLACE item_no WITH '合同小计：'
           REPLACE moneylimit WITH paymoney1
   aa=bb 
 ENDIF 
 SELECT 2      
NEXT MyCount

&&GO bottom
&&REPLACE  moneylimit WITH moneyleft
*USE d:\apdongguan\goodstake
*APPEND FROM d:\apdongguan\goodstake1
SELECT 4
oExcel=Createobject("Excel.application")
oExcel.Workbooks.Open("E:\LWG\欧确纳固邦采购事宜\提货文件\提货清单模板.xls")
oExcel.Worksheets("sheet1").Activate

&&IF RECCOUNT()<=50 then
USE goodstake3
GO top
MyCount=1
MyRows=2
FOR MyCount=1 TO RECCOUNT()
GO MyCount

oExcel.Cells(1,1).Value=ALLTRIM('订货号')&&给所选单元格覆值
oExcel.cells(1,2).Value=ALLTRIM('合同编号')
oExcel.cells(1,3).Value=ALLTRIM('提货数量')
oExcel.cells(1,4).Value=ALLTRIM('价格')
oExcel.cells(1,5).Value=ALLTRIM('合同小计及总计')
&&oExcel.cells(MyRows,1).Value=MyCount
oExcel.CELLS(MyRows,1).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.Selection.NumberFormatLocal = "@" &&把被选定的单元格设为文本格式
oExcel.Cells(MyRows,1).Value=ALLTRIM(item_no)&&给所选单元格覆值
oExcel.CELLS(MyRows,2).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,2).Value=ALLTRIM(contract3)
oExcel.CELLS(MyRows,3).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,3).Value=qtytake
oExcel.CELLS(MyRows,4).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,4).Value=moneyneed
oExcel.CELLS(MyRows,5).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,5).Value=moneylimit
MyRows=MyRows+1
NEXT MyCount
oExcel.cells(MyRows,4).Value=ALLTRIM('价格总计：')
oExcel.cells(MyRows,5).Value=paymoney
&&ELSE
 &&WAIT WINDOW "不能超过50条记录！"
&&EXIT
&&ENDIF
MyFile='E:\LWG\欧确纳固邦采购事宜\提货文件\'
SELECT 6
&&MyFile=MyFile+ALLTRIM(contract3)+ALLTRIM('提货清单')+ALLTRIM(DTOC(taketime))
MyFile=MyFile+ALLTRIM('提货清单')
oExcel.ActiveWorkbook.saved=.T.  &&不保存当前EXCEL表
oExcel.ActiveWorkbook.SaveAs(MyFile,39) &&另存为5.0的Excel，或用43表示95/97格式
oExcel.Workbooks.Close &&关闭表
oExcel.Quit &&退出EXCEL
Release oExcel &&释放变量
SELECT 6
USE patrackinputhelp
SELECT 1
USE patrack
REPLACE ALL iftake WITH 'yap' FOR iftake='yes' AND taketime=f.taketime

SELECT 6
&&REPLACE moneylimit WITH moneyleft
SET TALK ON
SET SAFETY ON
SET EXACT OFF
CLEAR 
RETURN
CLOSE ALL
