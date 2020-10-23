#!/bin/bash

yum install –y wget > /dev/null 2>&1
cd /etc/yum.repos.d/ && mv CentOS-Base.repo CentOS-Base.repo_bak
wget -O CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo > /dev/null 2>&1
wget -O /etc/yum.repos.d/epel-7.repo http://mirrors.aliyun.com/repo/epel-7.repo > /dev/null 2>&1
yum clean all > /dev/null 2>&1
yum makecache > /dev/null 2>&1

# install basic package
echo "start to install basic package:vim wget net-tools tree lrzsz ntpdate lsof lftp"
yum install vim net-tools tree lrzsz ntpdate lsof lftp -y > /dev/null 2>&1

basic_package=("vim" "net-tools" "tree" "lrzsz" "ntpdate" "lsof" "lftp")

for i in ${basic_package[*]};
do
    package=$i
    if [ $package == 'vim' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 4 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'wget' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'net-tools' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'tree' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'lrzsz' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'ntpdate' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'lsof' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    elif [ $package == 'lftp' ];then
        result=`rpm -qa|grep $package|wc -l`
        if [ $result -ge 1 ];then
            echo "$package has installed successfully"
        else
            echo "$package has not installed,please check"
            exit 1
        fi
    else
        echo "install basic package failed,please check"
    fi
done

# check postfix.service
echo "start to check postfix.service"
postfix_check=`systemctl status postfix.service|sed -n '3p'|awk -F'[:()]' '{print $3}'`
if [ ${postfix_check} == 'running' ];then
    echo "start to stop postfix.service"
    systemctl stop postfix.service > /dev/null 2>&1
    systemctl disable postfix.service > /dev/null 2>&1
    postfix_check=`systemctl status postfix.service|sed -n '3p'|awk -F'[:()]' '{print $3}'`
    if [ ${postfix_check} == 'dead' ];then
        echo "stop postfix.service successfully"
    else
        echo "stop postfix.service failed,please check"
    fi
elif [ ${postfix_check} == 'dead' ];then
    echo "postfix.service has stopped"
else
    echo "postfix.service status is wrong,please check"
fi

# check firewalld.service
echo "start to check firewalld.service"
firewalld_check=`systemctl status firewalld.service|sed -n '3p'|awk -F'[:()]' '{print $3}'`
if [ ${firewalld_check} == 'running' ];then
    echo "start to stop firewalld.service"
    systemctl stop firewalld.service > /dev/null 2>&1
    systemctl disable firewalld.service > /dev/null 2>&1
    firewalld_check=`systemctl status firewalld.service|sed -n '3p'|awk -F'[:()]' '{print $3}'`
    if [ ${firewalld_check} == 'dead' ];then
        echo "stop firewalld.service successfully"
    else
        echo "stop firewalld.service failed,please check"
    fi
elif [ ${firewalld_check} == 'dead' ];then
    echo "firewalld.service has stopped"
else
    echo "firewalld.service status is wrong,please check"
fi

# close selinux
setenforce 0 > /dev/null 2>&1 && sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/sysconfig/selinux && echo "selinux is close" || echo "selinux is open,please check"

# modify hostname
name=$1
hostnamectl set-hostname $name && echo $name >> /etc/sysconfig/network && echo "hostname is $name" || echo "modify hostname failed,please check"
