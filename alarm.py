#!/usr/bin/python
import os
import sys
import datetime
import time

inp2 = None
if len(sys.argv) > 1:
    inp = str(sys.argv[1])
    if len(sys.argv) > 2:
        inp2 = str(sys.argv[2])
else:
    print("you have to pass a time")


time_alarm = datetime.datetime.strptime(inp, "%X")
time_now = datetime.datetime.strptime(datetime.datetime.now().strftime("%X"), "%X")


diff_time = time_alarm - time_now
sleep_seconds = int(diff_time.total_seconds())
if sleep_seconds <= 0:
    print("You set an alarm to the past")
    exit(1)

print("alarm set: ", time_alarm)
time.sleep(sleep_seconds)
os.system("mplayer -noconsolecontrols /usr/local/zmann_bin/tone.wav")

if inp2 == "suspend":
    os.system("systemctl suspend")
if inp2 == "hibernate":
    os.system("sudo shutdown -h 0")
