LOG=/tmp/expense.log
print_Task_heading(){
  echo $1
  "######## $1 #####" &>>/tmp/expense.log
}
print_status(){
  if [ $? = 0 ]; then
      echo "Success"
  else
    echo "Failure"
  fi
}