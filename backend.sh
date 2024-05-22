source common.sh

mysql_root_password=$1
app_dir=/app
component=backend

print_task_heading "Disable nodejs"
dnf module disable nodejs -y &>>${LOG}
print_status $?
print_task_heading "Enable nodejs"
dnf module enable nodejs:20 -y &>>$LOG
print_status $?
print_task_heading "Install nodejs"
dnf install nodejs -y &>>$LOG
print_status $?
print_task_heading "Creating User"
id expense &>>$LOG
if [ $? != 0 ]; then
   useradd expense
   exit 2
 fi
 print_status $?
print_task_heading "Copying config"
cp backend.service /etc/systemd/system/backend.service
print_status $?
rm -rf /tmp/backend.zip

app-pre-req

print_task_heading "Install nodejs dependencies"
npm install &>>$LOG
print_status $?
print_task_heading "Starting backend service"
systemctl daemon-reload
systemctl enable backend &>>$LOG
systemctl start backend
print_status $?
print_task_heading "Installing mysql"
dnf install mysql -y &>>$LOG
print_status $?
print_task_heading "Load schema"
mysql -h mysql-dev.shujathdevops.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
print_status $?
