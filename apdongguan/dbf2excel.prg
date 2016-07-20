c=0
DO WHILE .t.
bm=SPACE(100)
CLEAR
@2,10 say "请输入需要转化的表名(带路径和扩展名): " get bm
read
bm=ALLTRIM(bm)
IF FILE("&bm") 
USE &bm
IF c=0
exc=createobject("excel.application")
exc.workbooks.add
ENDIF
IF c>=3
exc.sheets.add
ENDIF
c=c+1
sh="sheet"+STR(c,1)
exc.worksheets("&sh").activate
exc.visible=.t.
zds=FCOUNT()
FOR m=1 TO zds
exc.cells(1,m).value=FIELD(m)
ENDFOR
jls=RECCOUNT()
FOR n=1 TO jls
GO n
SCATTER TO sj memo
FOR x=1 TO zds
exc.cells(n+1,x).value=sj(x)
ENDFOR
ENDFOR
USE
exc.visible=.f.
ELSE
wait"该文件不存在！" windows at 20,50 timeout 2
ENDIF
ss=MESSAGEBOX("还要继续转换吗？",36,"转换文件")
IF ss=7
IF c>0
exc.visible=.t.
ENDIF
EXIT
ENDIF
ENDDO
