source common.sh
mysql_root_password=$1

if [ -z ${mysql_root_password}  ]; then
   echo -e "\e[33mPlease provide password\e[0m"
   exit 1
 fi

print_task_heading "Install mysql-server"
dnf install mysql-server -y &>>${LOG}
print_status $?
print_task_heading "Enable mysql"
systemctl enable mysqld &>>${LOG}
print_status $?
print_task_heading "Starting mysql"
systemctl start mysqld &>>${LOG}
print_status $?
print_task_heading "Setting up MySQL password"
echo 'show databases' | mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${LOG}
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG
fi
print_status $?
