SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF
SET EXACT ON
SET DEFAULT TO d:\apdongguan
CLOSE ALL

DO pamaterial.prg

oExcel=Createobject("Excel.application")
oExcel.Workbooks.Open("E:\LWG\欧确纳固邦采购事宜\采购单\伟马采购订单模板.xls")
oExcel.Worksheets("sheet1").Activate

&&USE 采购单厂家
 &&nc = namecount
&&GO nc
&&fn=faname
&&nc=nc+1
&&IF nc>RECCOUNT() then
&&   nc=1
&&ENDIF
&&REPLACE ALL namecount WITH nc

USE pareport

SUM ALL orderqty*conprice2 TO gvalue
vat=gvalue*0.17
mytotal=gvalue*1.17
gvalue=ROUND(gvalue,2)
vat=ROUND(vat,2)
mytotal=ROUND(mytotal,2)

IF RECCOUNT()<=20 then
GO top
MyCount=1
MyRows=15
FOR MyCount=1 TO RECCOUNT()
GO MyCount
oExcel.cells(MyRows,1).Value=MyCount
oExcel.CELLS(MyRows,2).Select &&或eole.Range("A1:E1").Select
oExcel.Selection.NumberFormatLocal = "@" &&把被选定的单元格设为文本格式
oExcel.Cells(MyRows,2).Value=ALLTRIM(item_no)&&给所选单元格覆值
oExcel.cells(MyRows,3).Value=ALLTRIM(descrip)
oExcel.cells(MyRows,4).Value=orderqty
oExcel.cells(MyRows,5).Value=conprice2
oExcel.cells(MyRows,6).Value=ROUND(orderqty*conprice2,2)

&&oExcel.cells(MyRows,7).Value=ALLTRIM(fn)

MyRows=MyRows+1
NEXT MyCount

oExcel.cells(35,6).Value=gvalue
oExcel.cells(36,6).Value=vat
oExcel.cells(37,6).Value=mytotal

ELSE
 WAIT WINDOW "不能超过20条记录！"
EXIT
ENDIF

MyFile='E:\LWG\欧确纳固邦采购事宜\采购单\'
USE patrackinputhelp

oExcel.cells(6,7).Value=ALLTRIM(contract2)
oExcel.cells(7,7).Value=ALLTRIM(DTOC(condate2))
MyFile=MyFile+ALLTRIM(contract2)
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
