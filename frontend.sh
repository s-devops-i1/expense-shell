source common.sh

print_task_heading "Install Nginx"
dnf install nginx -y  &>>/tmp/expense.log
print_status $?
systemctl enable nginx &>>/tmp/expense.log
print_task_heading "Starting Nginx"
systemctl start nginx
print_status $?
print_task_heading "Removing old contents"
rm -rf /usr/share/nginx/html/*
print_status $?
print_task_heading "Copying config"
cp expense.conf /etc/nginx/default.d/expense.conf
print_status $?
print_task_heading "Downloading frontend contents"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
print_status $?
cd /usr/share/nginx/html
print_task_heading "Extracting frontend contents"
unzip /tmp/frontend.zip &>>/tmp/expense.log
print_status $?
print_task_heading "Restarting Nginx"
systemctl restart nginx &>>/tmp/expense.log
print_status $?


