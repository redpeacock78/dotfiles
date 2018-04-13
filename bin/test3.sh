#! /bin/bash

PW=$(osascript -e 'tell application "System Events" to display dialog "ログイン時のパスワードを入力してください。" default answer "" with hidden answer' \
	| sed -e "s/button returned:OK, text returned://")

expect -c "
spawn sudo su
expect "Password:"
send \"${PW}\n\"

interact"
