source common.sh

app_dir=/usr/share/nginx/html
component=frontend

print_task_heading "Install Nginx"
dnf install nginx -y  &>>/tmp/expense.log
print_status $?
systemctl enable nginx &>>/tmp/expense.log
print_task_heading "Starting Nginx"
systemctl start nginx
print_status $?

print_task_heading "Copying config"
cp expense.conf /etc/nginx/default.d/expense.conf
print_status $?

app-pre-req



print_task_heading "Restarting Nginx"
systemctl restart nginx &>>/tmp/expense.log
print_status $?


