LOG=/tmp/expense.log
print_status(){
  if [ $? = 0 ]; then
      echo -e "\e[32mSuccess\e[0m"
  else
     echo -e "\e[32mFailure\e[0m"
  fi
}
print_task_heading() {
  echo -e "\e[35m#### $1 ####\e[0m"

}

app-pre-req() {
  print_task_heading "Removing Old contents"
  rm -rf ${app_dir}
  print_status $?

  print_task_heading "creating Directory"
  mkdir ${app_dir}
  print_status $?

  print_task_heading "Download App contents"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  print_status $?

  print_task_heading "Extracting "
  cd ${app_dir}
  unzip /tmp/${component}.zip &>>$LOG
  print_status $?


}