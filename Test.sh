#!/bin/bash

RETURN_VALUE=0

test_success()
{
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

i_test=1

test_name()
{
    echo -e "Test[\e[95m$i_test\e[0m]: $1"
    ((i_test++))
}

make re

for file in tests_file/single/*
do
    test_name "File: $file"
    test_success $file
done

for file in tests_file/error/*
do
    test_name "File: $file"
    test_fail $file
done

exit $RETURN_VALUE
