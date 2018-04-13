#! /bin/bash
#variable
file="$(osascript -e 'POSIX path of (get choose file of application "System Events" default location "'"$HOME"'")' || echo /dev/null)"
type="$(nkf --guess $@ $file | sed -e "s/ (//" -e "s/)//")"

#NoFile
if [[ "$file" =~ null ]]; then
  /usr/bin/osascript -e 'tell application "System Events" to display dialog "ファイルが選択されていませんがExcelを開きますか?" with icon (caution)'
  if [ $? = 0 ]; then
	open -a /Applications/Microsoft\ Excel.app
  else
	 /usr/bin/osascript -e 'tell application "System Events" to display dialog "キャンセルしました" with icon (note) buttons {"OK"}'
  fi

#Shift_JIS
elif [[ "$type" =~ Shift_JISCR ]] \
  || [[ "$type" =~ Shift_JISLF ]] \
  || [[ "$type" =~ Shift_JISCRLF ]]; then
	#Unix/Linux/IntelMac
	if [[ "$type" =~ Shift_JISLF ]]; then
	  /usr/bin/osascript -e 'tell application "System Events" to display dialog "Shift_JIS(LF)をUTF-8(LF)に変換してExcelで開きますか?" with icon (caution)'
	#Windows
	elif [[ "$type" =~ Shift_JISCRLF ]]; then
	/usr/bin/osascript -e 'tell application "System Events" to display dialog "Shift_JIS(CRLF)をUTF-8(LF)に変換してExcelで開きますか?" with icon (caution)'
	#PowerMac
	elif [[ "$type" =~ Shift_JISCR ]]; then
	/usr/bin/osascript -e 'tell application "System Events" to display dialog "Shift_JIS(CR)をUTF-8(LF)に変換してExcelで開きますか?" with icon (caution)'
	fi
	if [ $? = 0 ]; then
	  /usr/local/bin/nkf -w --overwrite --oc=UTF-8-BOM $file \
  	  && open $file -a /Applications/Microsoft\ Excel.app \
  	  && /usr/bin/osascript -e 'display notification "変換が完了しました!" with title "Convcsv"'
	else
	  /usr/bin/osascript -e 'tell application "System Events" to display dialog "キャンセルしました" with icon (note) buttons {"OK"}'
	fi
fi
