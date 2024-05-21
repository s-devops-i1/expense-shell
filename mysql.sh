dnf install mysql-server -y &>>/tmp/expense.log
echo $?
systemctl enable mysqld &>>/tmp/expense.log
echo $?
systemctl start mysqld &>>/tmp/expense.log
echo $?
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log
