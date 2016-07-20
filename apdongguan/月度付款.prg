SET CENTURY on
SET DATE TO ymd
SET TALK OFF
SET SAFETY OFF
SET EXACT ON
SET DEFAULT TO d:\apdongguan
CLOSE ALL

USE pataken
COPY TO monthpay1 FOR taketime>={^2013/04/01} and taketime<{^2013/05/01}
USE monthpay1
REPLACE ALL moneyneed WITH ROUND(conprice3*qtytake*1.17,2)
INDEX on taketime TAG taketime
TOTAL ON taketime FIELDS moneyneed TO monthpay2
USE monthpay2
COPY TO monthpay FIELDS taketime,moneyneed

CLOSE ALL
SET TALK ON
SET SAFETY ON
SET EXACT OFF
CLEAR 
RETURN
CLOSE ALL