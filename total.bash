#!/bin/bash

total=$(ls data/*.crs | wc -l)
echo "Total course records: $total"