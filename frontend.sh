source common.sh
print_Task_heading "Install Nginx"
dnf install nginx -y &>>$LOG
print_status $?
print_Task_heading "Enable Nginx"
systemctl enable nginx &>>$LOG
echo $?
print_Task_heading "Starting Nginx"
systemctl start nginx &>>$LOG
echo $?
print_Task_heading "Removing Default contents"
rm -rf /usr/share/nginx/html/*
echo $?
print_Task_heading "Copying configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?
print_Task_heading "Downloading app contents"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip  &>>$LOG
echo $?
print_Task_heading "Changing Dir"
cd /usr/share/nginx/html &>>$LOG
echo $?
print_Task_heading "unzip frontend contents"
unzip /tmp/frontend.zip &>>$LOG
echo $?
print_Task_heading "Restarting Nginx"
systemctl restart nginx &>>$LOG
echo $?