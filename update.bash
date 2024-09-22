#!/bin/bash

read -p "Enter a department code and course number: " dept_code course_num
dept_code_upper=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]')
filename="data/${dept_code_upper}${course_num}.crs"

if [ -f "$filename" ]; then
    echo "Updating course: ${dept_code_upper}${course_num}"
    echo "Press Enter to keep the existing value for each field."

    current_dept=$(head -n 1 "$filename")
    current_name=$(head -n 2 "$filename" | tail -n 1)
    current_schedule=$(head -n 3 "$filename" | tail -n 1 | cut -d' ' -f1)
    current_start=$(head -n 3 "$filename" | tail -n 1 | cut -d' ' -f2)
    current_end=$(head -n 3 "$filename" | tail -n 1 | cut -d' ' -f3)
    current_hours=$(head -n 4 "$filename" | tail -n 1)
    current_size=$(head -n 5 "$filename" | tail -n 1)

    [ -z "$current_dept" ] && current_dept="No existing value"
    [ -z "$current_name" ] && current_name="No existing value"
    [ -z "$current_schedule" ] && current_schedule="No existing value"
    [ -z "$current_hours" ] && current_hours="No existing value"
    [ -z "$current_size" ] && current_size="No existing value"

    read -p "Department name [$current_dept]: " new_dept
    [ -z "$new_dept" ] && new_dept="$current_dept"

    read -p "Course name [$current_name]: " new_name
    [ -z "$new_name" ] && new_name="$current_name"

    read -p "Course schedule [$current_schedule]: " new_schedule
    [ -z "$new_schedule" ] && new_schedule="$current_schedule"

    read -p "Course start date [$current_start]: " new_start
    [ -z "$new_start" ] && new_start="$current_start"

    read -p "Course end date [$current_end]: " new_end
    [ -z "$new_end" ] && new_end="$current_end"

    read -p "Credit hours [$current_hours]: " new_hours
    [ -z "$new_hours" ] && new_hours="$current_hours"

    read -p "Enrolled students [$current_size]: " new_size
    [ -z "$new_size" ] && new_size="$current_size"

    echo "$new_dept" > "$filename"
    echo "$new_name" >> "$filename"
    echo "$new_schedule $new_start $new_end" >> "$filename"
    echo "$new_hours" >> "$filename"
    echo "$new_size" >> "$filename"

    echo "[$(date)] UPDATED: ${dept_code_upper} $course_num $new_name" >> data/queries.log
    echo "Course updated successfully."
else
    echo "ERROR: course not found"
fi