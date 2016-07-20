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
&&USE patrack
Sqlhandle=sqlstringconnect("DRIVER={MySQL ODBC 5.2w Driver};SERVER=localhost;UID=root;PWD=ilikeit123;DATABASE=mysql;CharSet=gbk;")
SQLExec(sqlhandle,'select * from apdongguan.patrack;')
COPY TO patracksqlall
USE  patracksqlall

COPY TO patrackorder FOR contract2=f.contract2 AND !'cancel'$note
REPLACE ALL qty WITH qtyin-qtyout
REPLACE ALL qtyshort WITH qtyin-orderqty
&&INDEX on item_no TO d:\apdongguan\T
INDEX on item_no TAG item_no  &&rushmore技术
TOTAL ON item_no TO d:\apdongguan\pamaterial1 FIELDS orderqty,qtyin,qtyout,qty,qtyshort

USE patracksqlall
COPY TO totalgoodstake1  FIELDS item_no,contract3,conprice3,orderqty,qtytake,moneyneed,takeshort,taketime,moneylimit
USE d:\apdongguan\totalgoodstake1
INDEX on contract3+item_no TAG contract3  &&rushmore技术
TOTAL ON contract3+item_no TO d:\apdongguan\totalgoodstake FIELDS qtytake
USE d:\apdongguan\totalgoodstake
REPLACE ALL takeshort WITH orderqty-qtytake

USE pamaterial1
COPY TO pamaterial FIELDS item_no,supplier,descrip,orderqty,qtyin,qtyout,qty,qtyshort,conprice1,conprice2,conprice3
SELECT 5
USE patrackorder
&&INDEX on item_no TO d:\apdongguan\Torder
INDEX on item_no TAG item_no   &&rushmore技术
TOTAL ON item_no TO d:\apdongguan\pareport1 FIELDS orderqty
USE pareport1
COPY TO pareport FIELDS item_no,descrip,orderqty,contract2,condate2,conprice1,conprice2,conprice3 FOR orderqty>0
CLOSE ALL
SET TALK ON
SET SAFETY ON
SET EXACT OFF
RETURN
CLOSE ALL
