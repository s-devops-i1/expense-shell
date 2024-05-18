dnf module disable nodejs -y  &>>/tmp/expense.log
dnf module enable nodejs:20 -y  &>>/tmp/expense.log
echo "Install nodejs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?
echo "Add user"
useradd expense
echo $?
echo "Create Directory"
rm -rf /app
mkdir /app
echo $?
echo "Remove Old contents"
rm -rf /tmp/backend.zip
echo $?
echo "copy backend services to systemd"
cp backend.service /etc/systemd/system/backend.service
echo $?
echo "Download backend app"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?
echo "change dir"
cd /app
echo $?
echo "Unzip backend contents"
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?
echo "Download dependencies"
npm install &>>/tmp/expense.log
echo $?
echo "Starting backend app"
systemctl daemon-reload
systemctl enable backend &>>/tmp/expense.log
systemctl start backend
echo $?
echo "Installing mysql client"
dnf install mysql -y &>>/tmp/expense.log
echo $?
echo "Setting up mysql Initial password"
mysql -h 54.152.222.238 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
echo $?