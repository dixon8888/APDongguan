Sqlhandle=sqlstringconnect("DRIVER={MySQL ODBC 5.2w Driver};SERVER=localhost;UID=root;PWD=ilikeit123;DATABASE=mysql;CharSet=gb2312;")
      MESSAGEBOX(sqlhandle)
      IF sqlhandle<0 
         MESSAGEBOX("mySQL数据库连接失败！",16,"提示")
         RETURN
         ELSE
         MESSAGEBOX('mySQL数据库连接成功',16,'提示')
      ENDIF
      
&& SQLExec(sqlhandle,'select * from apdongguan.pamaterial;')
      