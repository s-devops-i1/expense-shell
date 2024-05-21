source common.sh
setting_root_password=$1

print_task_heading "Install mysql-server"
dnf install mysql-server -y &>>${LOG}
print_status $?
print_task_heading "Enable mysql"
systemctl enable mysqld &>>${LOG}
print_status $?
print_task_heading "Starting mysql"
systemctl start mysqld &>>${LOG}
print_status $?
print_task_heading "Setting up root password"
if [ -z ${setting_root_password}  ]; then
  mysql_secure_installation --set-root-pass ${setting_root_password} &>>${LOG}
  else
    echo -e "\e[33mPlease provide password\e[0m"
fi
print_status $?
