#!/bin/bash

read -p "Department code: " dept_code
read -p "Department name: " dept_name
read -p "Course number: " course_num
read -p "Course name: " course_name
read -p "Course schedule (MWF/TH): " course_sched
read -p "Course start date: " course_start
read -p "Course end date: " course_end
read -p "Course credit hours: " course_hours
read -p "Initial course enrollment: " course_size

dept_code_upper=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]')
filename="data/${dept_code_upper}${course_num}.crs"

if [[ -f $filename ]]; then
    echo "ERROR: course already exists"
else
    echo "${dept_code_upper} $dept_name" > $filename
    echo "$course_name" >> $filename
    echo "$course_sched $course_start $course_end" >> $filename
    echo "$course_hours" >> $filename
    echo "$course_size" >> $filename

    echo "[$(date)] CREATED: ${dept_code_upper} $course_num $course_name" >> data/queries.log
fi