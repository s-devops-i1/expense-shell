echo "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log
echo $?
echo "Enable Nginx"
systemctl enable nginx &>>/tmp/expense.log
echo $?
echo "Starting Nginx"
systemctl start nginx &>>/tmp/expense.log
echo $?
echo "Removing Default contents"
rm -rf /usr/share/nginx/html/*
echo $?
echo "Copying configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?
echo "Downloading app contents"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip  &>>/tmp/expense.log
echo $?
echo "Changing Dir"
cd /usr/share/nginx/html &>>/tmp/expense.log
echo $?
echo "unzip frontend contents"
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?
echo "Restarting Nginx"
systemctl restart nginx &>>/tmp/expense.log
echo $?