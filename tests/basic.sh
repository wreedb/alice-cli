#!/bin/bash

esc="\e["
bold_green="${esc}1;32m"
bold_red="${esc}1;31m"
bold_yellow="${esc}1;33m"
bold_blue="${esc}1;34m"
bold_magenta="${esc};1;35m"
_reset="${esc}0m"

total_tests=0
expected_pass_count=0
expected_fail_count=0
unexpected_pass_count=0
fail_count=0

info_pass() {
    echo -e "[${bold_green}PASS${_reset}] $@"
	expected_pass_count="$(($expected_pass_count +1))"
}

info_fail() {
    echo -e "[${bold_red}FAIL${_reset}] $@"
	fail_count="$(($fail_count +1))"
}

expect_fail()
{
	echo -e "[${bold_blue}EXPECT FAIL${_reset}] $@"
	expected_fail_count="$(($expected_fail_count +1))"
}

unexpected_pass()
{
	echo -e "[${bold_yellow}UNEXPECTED PASS${_reset}] $@"
	unexpected_pass_count="$(($unexpected_pass_count +1))"
}

cmd_base="./alice"

echo "" > tests/log


# DESC: normal/bright [8 named colors] hex/hsl/hwb/rgb
#       all should pass
for color in black red green yellow blue magenta cyan white
do
    for p in normal bright
    do
        for format in hex hsl hwb rgb
        do
			pass="1"
			cmd="${cmd_base} -s ${p} -c ${color} -f ${format}"
			printf '[command] %s: ' "${cmd}" >> tests/log 2>&1
            "${cmd_base}" -s "${p}" -c "${color}" -f "${format}" >> tests/log 2>&1 || pass="0"
			if test "${pass}" = "1"
			then
				info_pass "${p}/${format}/${color}"
			else
				info_fail "${p}/${format}/${color}"
			fi
			
			total_tests="$(($total_tests +1))"
        done
    done
done

# DESC: normal/bright [base color names & shorthand] hex/hsl/hwb/rgb
#       all should fail
for color in foreground background selection-foreground selection-background cursor-foreground cursor-background fg bg sel-fg sel-bg cursor-fg cursor-bg
do
	for format in hex hsl hwb rgb
	do
		for p in normal bright
		do
			pass="1"
			cmd="${cmd_base} -s ${p} -c ${color} -f ${format}"
			printf '[command] %s: ' "${cmd}" >> tests/log 2>&1
			"${cmd_base}" -s "${p}" -c "${color}" -f "${format}" >> tests/log 2>&1 || pass="0"
			if test "${pass}" = "1"
			then
				unexpected_pass "${p}/${color}/${format}"
			else
				expect_fail "${p}/${color}/${format}"
			fi
			total_tests="$(($total_tests +1))"
		done
	done
done


# DESC: normal/bright/base (full palette takes no argument) hex/hsl/hwb/rgb
#       all should pass
for palette in normal bright base
do
    for format in hex hsl hwb rgb
    do
		pass="1"
		cmd="${cmd_base} -s base -c ${color} -f ${format}"
		printf '[command] %s: ' "${cmd}" >> tests/log 2>&1
        "${cmd_base}" -s "${palette}" -f "${format}" >> tests/log 2>&1 || pass="0"
		if test "${pass}" = "1"
		then
			info_pass "full-${palette}/${format}"
		else
			info_fail "full-${palette}/${format}"
		fi
		total_tests="$(($total_tests +1))"
    done
done

# DESC: base [8 named colors] hex/hsl/hwb/rgb
#       all should fail
for format in hex hsl hwb rgb
do
	for color in black red green yellow blue magenta cyan white
	do
		pass="1"
		cmd="${cmd_base} -s base -c ${color} -f ${format}"
		printf '[command] %s: ' "${cmd}" >> tests/log 2>&1
		"${cmd_base}" -s base -c "${color}" -f "${format}" >> tests/log 2>&1 || pass="0"
		if test "${pass}" = "1"
		then
			unexpected_pass "base/${color}/${format}"
		else
			expect_fail "base/${color}/${format}"
		fi
		
		total_tests="$(($total_tests +1))"
	done
done

# DESC: base [base color names & shorthand] hex/hsl/hwb/rgb
#       all should pass
for format in hex hsl hwb rgb
do
	for color in foreground background selection-foreground selection-background cursor-foreground cursor-background fg bg sel-fg sel-bg cursor-fg cursor-bg
	do
		printf '[command] %s: ' "${cmd_base} -s base -c ${color} -f ${format}" >> tests/log 2>&1
		pass="1"
		"${cmd_base}" -s base -c "${color}" -f "${format}" >> tests/log 2>&1 || pass="0"

		if [ "${pass}" = "1" ]
		then
			info_pass "base/${color}/${format}"
		else
			info_fail "base/${color}/${format}"
		fi

		total_tests="$(($total_tests +1))"
	done
done

printf '\nRESULTS:\n'
echo "------------"

echo -en "[${bold_magenta}TOTAL${_reset}]: ${total_tests}\n"
echo -en "[${bold_green}EXPECTED PASSES${_reset}]: ${expected_pass_count}\n"
echo -en "[${bold_blue}EXPECTED FAILURES${_reset}]: ${expected_fail_count}\n"
echo -en "[${bold_yellow}UNEXPECTED PASSES${_reset}]: ${unexpected_pass_count}\n"
echo -en "[${bold_red}UNEXPECTED FAILURES${_reset}]: ${fail_count}\n"