#!/bin/bash
#
# simple test with a not existing command, to check exit status 127

command="command_not_found"
tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"

# create a pseudo random file
touch $tmp_file
# send commands
echo "$command" | $HSHELL > $tmp_file 2>/dev/null
let ret_actual=$?
echo "$ret_actual"
echo "$command" | $OSHELL > $tmp_file2 2>/dev/null
let ret_expected=$?
echo "$ret_expected"

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
if [[ $ret_actual -eq $ret_expected ]]; then
    print_ok
    TEST_PASSED=$((TEST_PASSED+1))
else
    print_ko
    TEST_FAILED=$((TEST_FAILED+1))
fi

# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2
