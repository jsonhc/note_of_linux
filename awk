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

NR：表示行数
NF：表示列数
$NR：表示行数的参数
$NF：表示最后一列的所有参数


#打印第一个参数和第二个
[root@aliyun awk_demo]# cat emp.txt |awk '{print $1;print $2}'
Beth
4.00

[root@aliyun awk_demo]# cat emp.txt |awk '{print $1"\n"$2}'
Beth
4.00

#当行数大于2，打印第一列参数
[root@aliyun awk_demo]# cat emp.txt |awk '{if(NR>=2){print $1}}'
Dan
kathy
Mark
Mary
Susie

#当第三列参数大于0，将第一列参数打印出来
[root@aliyun awk_demo]# cat emp.txt |awk '$3>0{print $1}'
kathy
Mark
Mary
Susie

#awk结合if用法
[root@aliyun awk_demo]# cat emp.txt |awk '{if($3>0){print $1}}'
kathy
Mark
Mary
Susie
[root@aliyun awk_demo]# cat emp.txt |awk '{if($3>0)print $1}'
kathy
Mark
Mary
Susie

#计算一列的总和
[root@aliyun awk_demo]# cat emp.txt |awk '{total=total+$2}END{print total}'
26.5

#结合if/else用法
[root@aliyun awk_demo]# cat emp.txt |awk '{if($2>5)print $2;else print $3}'

#结合变量用法
[root@aliyun awk_demo]# cat emp.txt |awk 'v=100{if($2>5)print v}'

#忽略大小写
[root@aliyun awk_demo]# cat emp.txt |awk '{IGNORECASE=1} /beth/'
Beth	4.00	0

#增加一列
[root@aliyun awk_demo]# cat emp.txt |awk '{$4=$2+$3}{print}'
[root@aliyun awk_demo]# cat emp.txt |awk '{$4="hello"}{print}'
[root@aliyun awk_demo]# cat emp.txt |awk '{$3=$3+1}{print}'   #第三列参数都增加1

[root@aliyun awk_demo]# cat emp.txt |awk '{if($NF==0) $NF="hello"}{print}'
Beth 4.00 hello
Dan 3.75 hello
kathy	4.00	10

[root@aliyun awk_demo]# cat emp.txt |awk '{if($NF==0) $NF="hello"}{if($NF==10) $NF="ok";if($NF==20) $NF="false"}{print}'

#将文件中的某一列添加到另一个文件中的第一列
[root@aliyun awk_demo]# awk '{print $0}' emp.txt | paste - emp1.txt   # 将emp.txt的全部数据添加到emp1.txt文件的第一列

#打印全部数据
[root@aliyun awk_demo]# cat emp.txt |awk '1'
[root@aliyun awk_demo]# cat emp.txt |awk '{print $0}'
[root@aliyun awk_demo]# cat emp.txt |awk '{print}'

# paste的用法
[root@aliyun awk_demo]# awk '{print $1}' emp.txt | paste -s   #该指令会将所有换行删掉，拼成一行 
Beth	Dan	kathy	Mark	Mary	Susie

[root@aliyun awk_demo]# awk '{print $1}' emp.txt | paste -s -d:
Beth:Dan:kathy:Mark:Mary:Susie
