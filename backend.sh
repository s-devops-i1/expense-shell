source common.sh

print_task_heading "Disable nodejs"
dnf module disable nodejs -y &>>/tmp/expense.log
print_status $?
print_task_heading "Enable nodejs"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
print_status $?
print_task_heading "Install nodejs"
dnf install nodejs -y &>>/tmp/expense.log
print_status $?
print_task_heading "Creating User"
UID=$(id)
if [ "${UID}" != 0 ]; then
   useradd expense
 fi
 print_status $?
 rm -rf /app
print_task_heading "creating Directory"
mkdir /app
print_status $?
print_task_heading "Copying config"
cp backend.service /etc/systemd/system/backend.service
print_status $?
print_task_heading "Download backend contents"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
print_status $?
cd /app
print_task_heading "Extracting "
unzip /tmp/backend.zip &>>/tmp/expense.log
print_status $?
print_task_heading "Install nodejs dependencies"
npm install
print_status $?
print_task_heading "Starting backend service"
systemctl daemon-reload
systemctl enable backend &>>/tmp/expense.log
systemctl start backend
print_status $?
print_task_heading "Installing mysql"
dnf install mysql -y &>>/tmp/expense.log
print_status $?
print_task_heading "Setting Up Password"
mysql -h 172.31.33.255 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
print_status $?
