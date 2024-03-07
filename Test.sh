#!/bin/bash

RETURN_VALUE=0

test_success()
{
    ./imageCompressor -n 2 -l 0.8 -f $1 &> /dev/null
    ./imageCompressor -n 2 -l 0.8 -f $1 &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "[\e[92mPASS\e[0m]"
    else
        echo -e "[\e[91mFAIL\e[0m]"
        RETURN_VALUE=1
    fi
}

test_fail()
{
    ./imageCompressor -n 2 -l 0.8 -f $1 &> /dev/null
    if [ $? -eq 84 ]; then
        echo -e "[\e[92mPASS\e[0m]"
    else
        echo -e "[\e[91mFAIL\e[0m]"
        RETURN_VALUE=1
    fi
}

check_success()
{
    if [ $? -eq 0 ]; then
        echo -e "[\e[92mPASS\e[0m]"
    else
        echo -e "[\e[91mFAIL\e[0m]"
        RETURN_VALUE=1
    fi
}

check_fail()
{
    if [ $? -eq 84 ]; then
        echo -e "[\e[92mPASS\e[0m]"
    else
        echo -e "[\e[91mFAIL\e[0m]"
        RETURN_VALUE=1
    fi
}

i_test=1

test_name()
{
    echo -e "Test[\e[95m$i_test\e[0m]: $1"
    ((i_test++))
}

make re

echo -e "\n\e[1mTest correct file:\e[0m\n"

for file in tests_file/single/*
do
    test_name "File: $file"
    test_success $file
done

echo -e "\n\e[1mTest invalid file:\e[0m\n"

for file in tests_file/error/*
do
    test_name "File: $file"
    test_fail $file
done

echo -e "\n\e[1mTest invalid command:\e[0m\n"

test_name "No argument"
./imageCompressor &> /dev/null
check_fail

test_name "Too much arg"
./imageCompressor -n 2 -l 0.8 -f "tests_file/single/subject_example" "error" &> /dev/null
check_fail

test_name "Invalid flag"
./imageCompressor -n 2 -a 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "0 color"
./imageCompressor -n 0 -l 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Negative nb color"
./imageCompressor -n -1 -l 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid nb color"
./imageCompressor -n 2a -l 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "0 convergence limit"
./imageCompressor -n 2 -l 0 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Negative convergence limit"
./imageCompressor -n 2 -l -1 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid convergence limit 1"
./imageCompressor -n 2 -l 1..6 -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid convergence limit 2"
./imageCompressor -n 2 -l 1.6. -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid convergence limit 3"
./imageCompressor -n 2 -l 1.6a -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid convergence limit 4"
./imageCompressor -n 2 -l 16a -f "tests_file/single/subject_example" &> /dev/null
check_fail

test_name "Invalid file"
./imageCompressor -n 2 -l 0.8 -f "tests_file/single/this_file_not_exist" &> /dev/null
check_fail

test_name "Directory"
./imageCompressor -n 2 -l 0.8 -f "." &> /dev/null
check_fail

echo -e "\n\e[1mTest valid command:\e[0m\n"

test_name "Valid command 1"
./imageCompressor -n 2 -l 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_success

test_name "Valid command 2"
./imageCompressor -l 0.8 -f "tests_file/single/subject_example" -n 2 &> /dev/null
check_success

test_name "Valid command 3"
./imageCompressor -f "tests_file/single/subject_example" -n 2 -l 0.8 &> /dev/null
check_success

test_name "Valid command 4"
./imageCompressor -l 0.8 -f "tests_file/single/subject_example" -n 2 &> /dev/null
check_success

test_name "Valid command 5"
./imageCompressor -n 2 -f "tests_file/single/subject_example" -l 0.8 &> /dev/null
check_success

test_name "Valid command 6"
./imageCompressor -n 2 -l 0.8 -f "tests_file/single/one_color.txt" &> /dev/null
check_success

test_name "Valid command 7"
./imageCompressor -n 2 -l 0.00001 -f "tests_file/single/subject_example" &> /dev/null
check_success

test_name "Valid command 8"
./imageCompressor -n 20 -l 0.8 -f "tests_file/single/subject_example" &> /dev/null
check_success

test_name "Valid command 9"
./imageCompressor -n 20 -l 25 -f "tests_file/single/subject_example" &> /dev/null
check_success

exit $RETURN_VALUE
