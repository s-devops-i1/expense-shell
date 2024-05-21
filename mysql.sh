source common.sh

print_task_heading "Install mysql-server"
dnf install mysql-server -y &>>${LOG}
print_status $?
print_task_heading "Enable mysql"
systemctl enable mysqld &>>${LOG}
print_status $?
print_task_heading "Starting mysql"
systemctl start mysqld &>>${LOG}
print_status $?
print_task_heading "Setting up root password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>${LOG}
print_status $?
