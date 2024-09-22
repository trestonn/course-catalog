#!/bin/bash

read -p "Enter a course department code and number: " dept_code course_num
read -p "Enter an enrollment change amount: " change_amt
dept_code_upper=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]')
filename="data/${dept_code_upper}${course_num}.crs"

if [[ -f $filename ]]; then
    course_name=$(head -n 2 $filename | tail -n 1)
    curr_size=$(tail -n 1 $filename)
    new_size=$((curr_size + change_amt))
    
    head -n 4 $filename > temp.txt
    echo $new_size >> temp.txt
    mv temp.txt $filename
    
    echo "[$(date)] ENROLLMENT: ${dept_code_upper} $course_num $course_name changed by $change_amt" >> data/queries.log
    echo "Enrollment for course ${dept_code_upper}${course_num} has been updated."
else
    echo "ERROR: course not found"
fi