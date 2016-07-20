SELECT 2
USE d:\apdongguan\paproduct555.dbf EXCLUSIVE
SELECT 1
USE d:\apdongguan\paproduct.dbf exclusive
maxnum=RECCOUNT()
FOR num=1 TO maxnum
GO num
want=ALLTRIM(p_no)
SELECT 2
DELETE ALL FOR ALLTRIM(p_no)=want
SELECT 1
NEXT num
CLOSE ALL



