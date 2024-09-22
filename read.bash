#!/bin/bash

read -p "Enter a department code and course number: " dept_code course_num
dept_code_upper=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]')
filename="data/${dept_code_upper}${course_num}.crs"

if [ -f "$filename" ]; then
    echo "Course department: $(head -n 1 $filename)"
    echo "Course number: $course_num"
    echo "Course name: $(head -n 2 $filename | tail -n 1)"
    
    schedule_line=$(head -n 3 $filename | tail -n 1)
    course_sched=$(echo $schedule_line | cut -d' ' -f1)
    course_start=$(echo $schedule_line | cut -d' ' -f2)
    course_end=$(echo $schedule_line | cut -d' ' -f3)
    
    echo "Scheduled days: $course_sched"
    echo "Course start: $course_start"
    echo "Course end: $course_end"
    echo "Credit hours: $(head -n 4 $filename | tail -n 1)"
    echo "Enrolled Students: $(head -n 5 $filename | tail -n 1)"
else
    echo "ERROR: course not found"
fi