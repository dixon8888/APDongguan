
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
&&INDEX on  contract3 TAG contract3 &&rushmore����
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
           REPLACE item_no WITH '��ͬС�ƣ�'
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
oExcel.Workbooks.Open("E:\LWG\ŷȷ�ɹ̰�ɹ�����\����ļ�\����嵥ģ��.xls")
oExcel.Worksheets("sheet1").Activate

&&IF RECCOUNT()<=50 then
USE goodstake3
GO top
MyCount=1
MyRows=2
FOR MyCount=1 TO RECCOUNT()
GO MyCount

oExcel.Cells(1,1).Value=ALLTRIM('������')&&����ѡ��Ԫ��ֵ
oExcel.cells(1,2).Value=ALLTRIM('��ͬ���')
oExcel.cells(1,3).Value=ALLTRIM('�������')
oExcel.cells(1,4).Value=ALLTRIM('�۸�')
oExcel.cells(1,5).Value=ALLTRIM('��ͬС�Ƽ��ܼ�')
&&oExcel.cells(MyRows,1).Value=MyCount
oExcel.CELLS(MyRows,1).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.Selection.NumberFormatLocal = "@" &&�ѱ�ѡ���ĵ�Ԫ����Ϊ�ı���ʽ
oExcel.Cells(MyRows,1).Value=ALLTRIM(item_no)&&����ѡ��Ԫ��ֵ
oExcel.CELLS(MyRows,2).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,2).Value=ALLTRIM(contract3)
oExcel.CELLS(MyRows,3).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,3).Value=qtytake
oExcel.CELLS(MyRows,4).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,4).Value=moneyneed
oExcel.CELLS(MyRows,5).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.BorderS(1).LineStyle=1
oExcel.Selection.BorderS(2).LineStyle=1
oExcel.Selection.BorderS(3).LineStyle=1
oExcel.Selection.BorderS(4).LineStyle=1
oExcel.cells(MyRows,5).Value=moneylimit
MyRows=MyRows+1
NEXT MyCount
oExcel.cells(MyRows,4).Value=ALLTRIM('�۸��ܼƣ�')
oExcel.cells(MyRows,5).Value=paymoney
&&ELSE
 &&WAIT WINDOW "���ܳ���50����¼��"
&&EXIT
&&ENDIF
MyFile='E:\LWG\ŷȷ�ɹ̰�ɹ�����\����ļ�\'
SELECT 6
&&MyFile=MyFile+ALLTRIM(contract3)+ALLTRIM('����嵥')+ALLTRIM(DTOC(taketime))
MyFile=MyFile+ALLTRIM('����嵥')
oExcel.ActiveWorkbook.saved=.T.  &&�����浱ǰEXCEL��
oExcel.ActiveWorkbook.SaveAs(MyFile,39) &&���Ϊ5.0��Excel������43��ʾ95/97��ʽ
oExcel.Workbooks.Close &&�رձ�
oExcel.Quit &&�˳�EXCEL
Release oExcel &&�ͷű���
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
