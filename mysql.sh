echo "Installing Mysql server"
dnf install mysql-server -y &>>/tmp/expense.log
echo $?
echo "Enabling mysqld"
systemctl enable mysqld &>>/tmp/expense.log
echo $?
echo "Starting mysqld"
systemctl start mysqld  &>>/tmp/expense.log
echo $?
echo "Setting up Password"
mysql_secure_installation --set-root-pass ExpenseApp@1  &>>/tmp/expense.log
echo $?
