#!/bin/bash

# A script for creating FreeIPA backups every <SPECIFIED_TIME_IN_HOURS>

# MIT License
#
# Copyright (c) 2022 Timofey Chuchkanov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

HOURS=$1

if [ "$HOURS" == "" ] || [ "$HOURS" == "--help" ] || [ "$HOURS" == "-h" ]; then
    echo You need to specify an interval for FreeIPA backups.
    echo -e "Example:\n\tipabakd.sh <HOURS>\n, where <HOURS> is a number."
    exit 1
fi

SCRIPT_NAME="$(echo $0 | rev | cut -d / -f 1 | rev)"
LOG_FILE="/var/log/$SCRIPT_NAME.log"

function backup_with_log() {
    TMP_OPER="/tmp/$SCRIPT_NAME.tmpoper"
    ipa-backup --data --online &> $TMP_OPER
    format_log "$(cat $TMP_OPER)"
}

function format_log() {
    LOG_BODY="$1"
    TIMEDATE="$(date)"
    DELIM="-----[ $TIMEDATE ]-----"
    DELIM_LEN=${#DELIM}
    DELIM_END="$(printf -- "-%.0s" $(seq 0 $DELIM_LEN))"
    
    echo -e "\n\n$DELIM\n$LOG_BODY\n$DELIM_END\n\n" >> $LOG_FILE
}

while [ 1 ] ; do
    backup_with_log
    sleep "$(($HOURS * 3600))"
done
