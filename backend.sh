source common.sh

set_root_password=$1

dnf module disable nodejs -y  &>>$LOG
dnf module enable nodejs:20 -y  &>>$LOG
print_Task_heading "Installing nodejs"
dnf install nodejs -y &>>$LOG
print_status $?
print_Task_heading "Add user"
useradd expense
echo $?
print_Task_heading "Create Directory"
rm -rf /app
mkdir /app
echo $?
print_Task_heading "Remove Old contents"
rm -rf /tmp/backend.zip
echo $?
print_Task_heading "copy backend services to systemd"
cp backend.service /etc/systemd/system/backend.service
echo $?
print_Task_heading "Download backend app"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
echo $?
print_Task_heading "change dir"
cd /app
echo $?
print_Task_heading "Unzip backend contents"
unzip /tmp/backend.zip &>>$LOG
echo $?
print_Task_heading "Download dependencies"
npm install &>>$LOG
echo $?
print_Task_heading "Starting backend app"
systemctl daemon-reload
systemctl enable backend &>>$LOG
systemctl start backend
echo $?
print_Task_heading "Installing mysql client"
dnf install mysql -y &>>$LOG
echo $?
print_Task_heading "Setting up mysql Initial password"
mysql -h 54.152.222.238 -uroot -p${set_root_password} < /app/schema/backend.sql &>>$LOG
echo $?