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