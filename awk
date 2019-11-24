行:NR
$ sudo netstat -ant|awk 'NR>2{print $NF}'|sort|uniq -c

列:NF
$ sudo netstat -ant|awk '{print $(NF-1)}'        # $(NF-1)  倒数第二列

wadeson@wadeson-Inspiron-7460:~$ sudo netstat -atn | awk '/^tcp/{print NF}'|head -1
6
wadeson@wadeson-Inspiron-7460:~$ sudo netstat -atn | awk '/^tcp/{print $NF}'|head -1
LISTEN

wadeson@wadeson-Inspiron-7460:~$ awk 'BEGIN{for(i=1;i<=9;i++){for(j=9;j>=i;j--)printf "%d*%d= %d\t",i,j,i*j;print}}'
1*9= 9	1*8= 8	1*7= 7	1*6= 6	1*5= 5	1*4= 4	1*3= 3	1*2= 2	1*1= 1	
2*9= 18	2*8= 16	2*7= 14	2*6= 12	2*5= 10	2*4= 8	2*3= 6	2*2= 4	
3*9= 27	3*8= 24	3*7= 21	3*6= 18	3*5= 15	3*4= 12	3*3= 9	
4*9= 36	4*8= 32	4*7= 28	4*6= 24	4*5= 20	4*4= 16	
5*9= 45	5*8= 40	5*7= 35	5*6= 30	5*5= 25	
6*9= 54	6*8= 48	6*7= 42	6*6= 36	
7*9= 63	7*8= 56	7*7= 49	
8*9= 72	8*8= 64	
9*9= 81

wadeson@wadeson-Inspiron-7460:~$ sudo netstat -atn | awk '/^tcp/{++S[$NF]}END{for(a in S)print a,S[a]}'
LISTEN 12
CLOSE_WAIT 3
TIME_WAIT 1
ESTABLISHED 23
LAST_ACK 1
SYN_SENT 13
S为数组,S['LISTEN']为LISTEN在数组中叠加的数值
