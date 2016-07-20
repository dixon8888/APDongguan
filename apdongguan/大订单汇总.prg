SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF
SET EXACT ON
SET DEFAULT TO d:\apdongguan

SELECT 6
USE patrackinputhelp
SELECT 1
USE d:\apdongguan\patrack.dbf EXCLUSIVE
COPY TO ordersum1 FOR contract2=f.contract2 AND !'cancel'$note
USE ordersum1
INDEX on item_no+contract2 TAG item_no   &&rushmoreºº ı  
TOTAL ON item_no+contract2 TO d:\apdongguan\ordersum2 FIELDS orderqty
USE ordersum2 
COPY TO ordersum FIELDS item_no,orderqty,contract2,conprice3 TYPE fox2x

CLOSE ALL
SET TALK ON
SET SAFETY ON
SET EXACT OFF
CLEAR 
RETURN
CLOSE ALL