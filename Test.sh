#!/bin/bash

RETURN_VALUE=0

test_success()
{
    ./imageCompressor $1
    if [ $? -eq 0 ]; then
        echo -e "[\e[92mPASS\e[0m]"
    else
        echo -e "[\e[91mFAIL\e[0m]"
        RETURN_VALUE=1
    fi
}

test_fail()
{
    ./imageCompressor $1
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

test_name "Basic File"
test_success tests_file/subject_example

exit $RETURN_VALUE
