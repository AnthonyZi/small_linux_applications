#!/usr/bin/python
import os
import sys
import getopt


# turn notification on and off
config_full_file_path = "/usr/local/zmann_bin/.customisation.config"
try:
        config_file = open(config_full_file_path, "r")
        config_lines = config_file.readlines()
        config_file.close()
except:
        pass



try:
        opts, args = getopt.getopt(sys.argv[1:], "tn:", ["toggle_notification", "notification="])
        config_change = False
        for opt, arg in opts:
                if opt in ("-t", "--toggle_notification"):
                        for i in xrange(len(config_lines)):
                                if "batterynotifier" in config_lines[i].split(" ")[0] and "notification" in config_lines[i].split("=")[0]:
                                        if "on" in config_lines[i].split("=")[1]:
                                                config_lines[i] = "=".join([config_lines[i].split("=")[0], config_lines[i].split("=")[1].replace("on", "off")])
                                                notify_state = "off"
                                        elif "off" in config_lines[i].split("=")[1]:
                                                config_lines[i] = "=".join([config_lines[i].split("=")[0], config_lines[i].split("=")[1].replace("off", "on")])
                                                notify_state = "on"
                                        else:
                                                config_lines[i] = "batterynotifier notification = on"
                                                notify_state = "on"


                                        notify_cmd_temp = "/usr/bin/notify-send batterynotifier 'Turned notification {0}' -t 1".format(notify_state)
                                        os.system(notify_cmd_temp)
                                        config_change = True

                if opt in ("-n", "--notification"):
                        if not any(["batterynotifier" in x and "notification" in x for x in config_lines]):
                                config_lines.append("batterynotifier notification = off")

                        for i in xrange(len(config_lines)):
                                if "batterynotifier" in config_lines[i].split(" ")[0] and "notification" in config_lines[i].split("=")[0]:
                                        if "off" in arg:
                                                config_lines[i] = "batterynotifier notification = off"
                                        else:
                                                config_lines[i] = "batterynotifier notification = on"
                        config_change = True
        if config_change:
                config_file = open(config_full_file_path, "w")
                for line in config_lines:
                        config_file.write(line)
                config_file.close()
                sys.exit(1)

except getopt.GetoptError:
        print("batterynotifier.py -t [--toggle_notificatoin] -n [--notification=(on|off)]")
        sys.exit(101)


# test whether battery notification shall return a message or not - if not exit programm here
if not any(["batterynotifier" in x and "notification" in x for x in config_lines]):
        sys.exit(0)
for line in config_lines:
        if "batterynotifier" in line and "notification" in line:
                if "off" in line.split("=")[1]:
                        sys.exit(0)



# batterynotification
loadstring = os.popen("acpi").read().strip().split(" ")
load = ""
isDischarging = False
for l in loadstring:
        if "%" in l:
                load = l.strip(",").strip("%")
        if "Discharging" in l:
                isDischarging = True
if load != "":
        load = int(load)
else:
        load = -1

temperature = float(str(os.popen("acpi -t").read().strip().split("ok,")[1].split("degree")[0].strip()))
if not load == -1:
        if int(temperature) > 55:
                notify_cmd_temp = "/usr/bin/notify-send batterynotifier 'Temperature-Warning: battery temperature is {0:.2f} degrees' -t 5000 -u low".format(temperature)
                os.system(notify_cmd_temp)
        elif int(temperature) > 70:
                notify_cmd_temp = "/usr/bin/notify-send batterynotifier 'Temperature-Warning: battery temperature is {0:.2f} degrees' -t 20000 -u critical".format(temperature)
                os.system(notify_cmd_temp)

        if load >= 85 and not isDischarging:
                notify_cmd_load = "/usr/bin/notify-send batterynotifier 'Battery charged! (" + str(load) + "%) ' -t 5000 -u low"
                if load >= 95:
                        notify_cmd_load = "/usr/bin/notify-send batterynotifier 'Battery charged! (" + str(load) + "%) ' -t 20000 -u critical"
                os.system(notify_cmd_load)
        if load <= 15:
                notify_cmd_load = "/usr/bin/notify-send batterynotifier 'Battery almost empty! (" + str(load) + "%) ' -t 5000 -u low"
                if load <= 6: 
                        notify_cmd_load = "/usr/bin/notify-send batterynotifier 'Battery empty! (" + str(load) + "%) ' -t 20000 -u critical"
                os.system(notify_cmd_load)
else:
        if int(temperature) > 70:
                notify_cmd_temp = "/usr/bin/notify-send batterynotifier 'Temperature-Warning: battery temperature is {0:.2f} degrees' -t 20000 -u critical".format(temperature)
                os.system(notify_cmd_temp)
