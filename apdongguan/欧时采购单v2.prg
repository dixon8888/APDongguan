
DO pamaterial.prg
SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF

SET EXACT ON
SET DEFAULT TO d:\apdongguan

USE patrackorder
INDEX on contract2+item_no+contract1 TAG item_no   &&rushmore����
TOTAL ON contract2+item_no+contract1 TO d:\apdongguan\pareport1 FIELDS orderqty
USE pareport1
COPY TO pareport2 FIELDS item_no,descrip,orderqty,contract1,condate1,contract2,condate2,conprice1,conprice2,conprice3,note FOR orderqty>0
COPY TO pareport FIELDS item_no,descrip,orderqty,contract1,condate1,contract2,condate2,conprice1,conprice2,conprice3,note FOR orderqty>0

oExcel=Createobject("Excel.application")
oExcel.Workbooks.Open("E:\LWG\ŷȷ�ɹ̰�ɹ�����\�ɹ���\ŷʱ�ɹ�����ģ��.xls")
oExcel.Worksheets("sheet1").Activate

SELECT 6
USE patrackinputhelp
SELECT 5
USE pareport
zap
SELECT 1
USE patrack
COPY TO patracktemp FOR contract2=f.contract2 AND !'cancel'$note
SELECT 2
USE pareport2
SELECT 3
USE patracktemp
GO top
DO WHILE NOT EOF()
   SELECT 2
   LOCATE FOR  DELETED()=.f. AND ALLTRIM(item_no)=ALLTRIM(c.item_no) AND ALLTRIM(contract1)=ALLTRIM(c.contract1) 
     IF FOUND()
        DELETE
        REPLACE note WITH '�����'
        SELECT 5
        APPEND FROM pareport2 FOR ALLTRIM(note)='�����'
        SELECT 2
        REPLACE ALL note WITH '���������'
     ENDIF 
 SELECT 3
 SKIP
 ENDDO

CLOSE ALL

&&USE �ɹ�������
&& nc = namecount
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
oExcel.CELLS(MyRows,2).Select &&��eole.Range("A1:E1").Select
oExcel.Selection.NumberFormatLocal = "@" &&�ѱ�ѡ���ĵ�Ԫ����Ϊ�ı���ʽ
oExcel.Cells(MyRows,2).Value=ALLTRIM(item_no)&&����ѡ��Ԫ��ֵ
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

MyFile='E:\LWG\ŷȷ�ɹ̰�ɹ�����\�ɹ���\'
USE patrackinputhelp

oExcel.cells(6,7).Value=ALLTRIM(contract2)
oExcel.cells(7,7).Value=ALLTRIM(DTOC(condate2))
MyFile=MyFile+ALLTRIM(contract2)
&&oExcel.ActiveWorkbook.SaveAs('D:\APDongguan\NewTest.xls',39) &&���Ϊ5.0��Excel������43��ʾ95/97��ʽ
oExcel.ActiveWorkbook.saved=.T.  &&�����浱ǰEXCEL��
oExcel.ActiveWorkbook.SaveAs(MyFile,39) &&���Ϊ5.0��Excel������43��ʾ95/97��ʽ
oExcel.Workbooks.Close &&�رձ�
oExcel.Quit &&�˳�EXCEL
Release oExcel &&�ͷű���

else

&&IF RECCOUNT()>20 then

 &&WAIT WINDOW "���ܳ���20����¼��"
 oExcel.ActiveWorkbook.saved=.T.  &&�����浱ǰEXCEL��
 oExcel.Workbooks.Close &&�رձ�
oExcel.Quit &&�˳�EXCEL
Release oExcel &&�ͷű���

oExcel1=Createobject("Excel.application")
oExcel1.Workbooks.Open("E:\LWG\ŷȷ�ɹ̰�ɹ�����\�ɹ���\ŷʱ�ɹ�����ģ��multi.xls")
oExcel1.Worksheets("sheet1").Activate
 
GO top
MyCount=1
MyRows=15

FOR MyCount=1 TO RECCOUNT()
GO MyCount

oExcel1.CELLS(MyRows,1).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.cells(MyRows,1).Value=MyCount
oExcel1.CELLS(MyRows,2).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.Selection.NumberFormatLocal = "@" &&�ѱ�ѡ���ĵ�Ԫ����Ϊ�ı���ʽ
oExcel1.Cells(MyRows,2).Value=ALLTRIM(item_no)&&����ѡ��Ԫ��ֵ
oExcel1.CELLS(MyRows,3).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.Selection.NumberFormatLocal = "@" &&�ѱ�ѡ���ĵ�Ԫ����Ϊ�ı���ʽ
oExcel1.cells(MyRows,3).Value=ALLTRIM(descrip)
oExcel1.CELLS(MyRows,4).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.cells(MyRows,4).Value=orderqty
oExcel1.CELLS(MyRows,5).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.cells(MyRows,5).Value=conprice2
oExcel1.CELLS(MyRows,6).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.cells(MyRows,6).Value=ROUND(orderqty*conprice2,2)
oExcel1.CELLS(MyRows,7).Select &&��eole.Range("A1:E1").Select
oExcel1.Selection.BorderS(1).LineStyle=1
oExcel1.Selection.BorderS(2).LineStyle=1
oExcel1.Selection.BorderS(3).LineStyle=1
oExcel1.Selection.BorderS(4).LineStyle=1
oExcel1.cells(MyRows,7).Value=ALLTRIM(fn)

MyRows=MyRows+1
oExcel1.Rows(MyRows).RowHeight=27
NEXT MyCount
oExcel1.Rows(MyRows).RowHeight=27
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
oExcel1.cells(MyRows,3).Value='Goods value/�ϼ�(����˰)��'
oExcel1.cells(MyRows,6).Value=gvalue
MyRows=MyRows+1
oExcel1.Rows(MyRows).RowHeight=27
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
oExcel1.cells(MyRows,3).Value='Value added tax/��ֵ˰��'
oExcel1.cells(MyRows,6).Value=vat
MyRows=MyRows+1
oExcel1.Rows(MyRows).RowHeight=27
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
oExcel1.cells(MyRows,3).Value='Total/��˰�ϼƣ���'
oExcel1.cells(MyRows,6).Value=mytotal
MyRows=MyRows+1
oExcel1.ActiveSheet.Rows(MyRows).RowHeight=13.5
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"C"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="A"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='��ע�����ɹ���������������ɹ�����������ʽ��ͬΪ׼��'
MyRows=MyRows+3
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"G"+ALLTRIM(str(MyRows))
oExcel1.activesheet.range(MyRows1).BorderS(4).LineStyle=1
MyRows=MyRows+1
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"C"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="A"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='��ַ���麣�м���·57����¥705��(������麣��¥��'
MyRows1="F"+ALLTRIM(str(MyRows))+":"+"G"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="F"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='�ʱ�(Post Code)��519015'
MyRows=MyRows+1
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"C"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="A"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='Add��Room 705, 57 Jida Road, Zhuhai, Guangdong.'
MyRows=MyRows+1
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"C"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
oExcel1.range(MyRows1).value='�绰(Tel)��+86 0756 3253298'
MyRows1="F"+ALLTRIM(str(MyRows))+":"+"G"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="F"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='����(Fax)��4006768800-6768 �� +86 0756 3232715'
MyRows=MyRows+1
MyRows1="A"+ALLTRIM(str(MyRows))+":"+"C"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="A"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='��վ(Url)��www.aurchina.com'
MyRows1="F"+ALLTRIM(str(MyRows))+":"+"G"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).select
oExcel1.selection.merge
oExcel1.Selection.Font.Size=11
oExcel1.Selection.Font.Name="����"
MyRows1="F"+ALLTRIM(str(MyRows))
oExcel1.range(MyRows1).value='E-mail��brent@aurchina.com'

MyFile='E:\LWG\ŷȷ�ɹ̰�ɹ�����\�ɹ���\'
USE patrackinputhelp

oExcel1.cells(6,7).Value=ALLTRIM(contract2)
oExcel1.cells(7,7).Value=ALLTRIM(DTOC(condate2))
MyFile=MyFile+ALLTRIM(contract2)
&&oExcel.ActiveWorkbook.SaveAs('D:\APDongguan\NewTest.xls',39) &&���Ϊ5.0��Excel������43��ʾ95/97��ʽ
oExcel1.ActiveWorkbook.saved=.T.  &&�����浱ǰEXCEL��
oExcel1.ActiveWorkbook.SaveAs(MyFile,39) &&���Ϊ5.0��Excel������43��ʾ95/97��ʽ
oExcel1.Workbooks.Close &&�رձ�
oExcel1.Quit &&�˳�EXCEL
Release oExcel1 &&�ͷű���

ENDIF

CLOSE ALL
SET TALK ON
SET SAFETY ON
SET EXACT OFF
CLEAR 
RETURN
CLOSE ALL
