dnf install nginx -y  &>>/tmp/expense.log
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx
rm -rf /usr/share/nginx/html/*
cp expense.conf /etc/nginx/default.d/expense.conf
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/expense.log

systemctl restart nginx &>>/tmp/expense.log


