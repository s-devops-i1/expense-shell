dnf module disable nodejs -y
dnf module enable nodejs:20 -y
echo "Install nodejs"
dnf install nodejs -y
echo "Add user"
useradd expense
echo "Create Directory"
mkdir /app
echo "Remove Old contents"
rm -rf /tmp/backend.zip
echo "copy backend services to systemd"
cp backend.service /etc/systemd/system/backend.service
echo "Download backend app"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
echo "change dir"
cd /app
echo "Unzip backend contents"
unzip /tmp/backend.zip
echo "Download dependencies"
npm install
echo "Starting backend app"
systemctl daemon-reload
systemctl enable backend
systemctl start backend
echo "Installing mysql client"
dnf install mysql -y
echo "Setting up mysql Initial password"
mysql -h 54.152.222.238 -uroot -pExpenseApp@1 < /app/schema/backend.sql
