source common.sh
print_Task_heading "Installing Mysql server"
dnf install mysql-server -y &>>/tmp/expense.log
echo $?
print_Task_heading "Enabling mysqld"
systemctl enable mysqld &>>/tmp/expense.log
echo $?
print_Task_heading "Starting mysqld"
systemctl start mysqld  &>>/tmp/expense.log
echo $?
print_Task_heading "Setting up Password"
mysql_secure_installation --set-root-pass ExpenseApp@1  &>>/tmp/expense.log
echo $?
