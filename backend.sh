print_Task_heading(){
  echo $1
  "######## $1 #####" &>>/tmp/expense.log
}
dnf module disable nodejs -y  &>>/tmp/expense.log
dnf module enable nodejs:20 -y  &>>/tmp/expense.log
print_Task_heading "Installing nodejs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?
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
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?
print_Task_heading "change dir"
cd /app
echo $?
print_Task_heading "Unzip backend contents"
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?
print_Task_heading "Download dependencies"
npm install &>>/tmp/expense.log
echo $?
print_Task_heading "Starting backend app"
systemctl daemon-reload
systemctl enable backend &>>/tmp/expense.log
systemctl start backend
echo $?
print_Task_heading "Installing mysql client"
dnf install mysql -y &>>/tmp/expense.log
echo $?
print_Task_heading "Setting up mysql Initial password"
mysql -h 54.152.222.238 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
echo $?