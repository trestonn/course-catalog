#!/bin/bash

read -p "Enter a course department code and number: " dept_code course_num
dept_code_upper=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]')
filename="data/${dept_code_upper}${course_num}.crs"

if [ -f "$filename" ]; then
    course_name=$(head -n 2 $filename | tail -n 1)
    rm $filename
    echo "[$(date)] DELETED: ${dept_code_upper} $course_num $course_name" >> data/queries.log
    echo "$course_num was successfully deleted."
else
    echo "ERROR: course not found"
fi