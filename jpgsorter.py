#!/usr/bin/python
import os
import subprocess
import time
import shutil
import collections
import getopt
import sys

config_file = "~/.jpgsorter.config"

print("load config")

f = open(config_file)
config_lines = [elem.strip("\r\n") for elem in f.readlines() if not "dir" in elem.split(" ")[0]]
config_lines = [elem for elem in config_lines if not elem == ""]
f.close()

#variables_dict
variables_dict = dict()
for line in config_lines:
    l = line.split("=")
    variables_dict[l[0].strip(" \"")] = l[1].strip(" \"")

try:
    opts, args = getopt.getopt(sys.argv[1:], "s:d:t:n:", ["scan_folder", "documents_folder", "time_image_show", "number_folder_suggestions"])
    for opt, arg in opts:
        if opt in ("-s", "--scan_folder"):
            variables_dict["scan_folder"] = arg
        if opt in ("-d", "--documents_folder"):
            variables_dict["documents_folder"] = arg
        if opt in ("-t", "--time_image_show"):
            variables_dict["showtime"] = arg
        if opt in ("-n", "--number_folder_suggestions"):
            variables_dict["size_last_folders"] = arg

except getopt.GetoptError:
    print("argument-error: usage: -s [--scan_folder](path) -d [--documents_folder](path) -t [--time_image_show](seconds) -n [--number_folder_suggestions](integer)")
    sys.exit(1)

#scan_folder
scan_folder = "/"+variables_dict["scan_folder"].strip("/")
inp = str(raw_input("scan_folder = "+scan_folder+" ... [y|folder_location]?\n"))
if not any(inp == ok for ok in ["y", ""]):
    scan_folder = "/"+inp.strip("\r\n/")

#documents_folder
documents_folder = "/"+variables_dict["documents_folder"].strip("/")
inp = str(raw_input("documents_folder = "+documents_folder+" ... [y|folder_location]?\n"))
if not any(inp == ok for ok in ["y", ""]):
    documents_folder = "/"+inp.strip("\r\n/")

#showtime
showtime = int(variables_dict["showtime"])
inp = str(raw_input("showtime = "+str(showtime)+" ... [y|showtime]?\n"))
if not any(inp == ok for ok in ["y", ""]):
    showtime = int(inp)

#size_last_folders
size_last_folders = int(variables_dict["size_last_folders"])
inp = str(raw_input("size_last_folders = "+str(size_last_folders)+" ... [y|size_last_folders]?\n"))
if not any(inp == ok for ok in ["y", ""]):
    size_last_folders = int(inp)

def load_folder_suggestions(filename, documents_folder):
    f = open(filename)
    lines = f.readlines()
    f.close()

    folder_list = [elem.split(" ")[1].strip("\r\n") for elem in lines if "dir" in elem]
    folder_list = [elem for elem in folder_list if documents_folder in elem]
    return folder_list

def save_folder_suggestions(filename):
    f = open(filename)
    save_lines = [elem.strip("\r\n") for elem in f.readlines() if not "dir" in elem]
    f.close()
    f = open(filename, "w")
    for line in save_lines:
        f.write(line+"\n")
    for line in folder_suggestions:
        f.write("dir "+line+"\n")
    f.close()

def load_folder_suggestions_deque(folder_suggestions, size):
    deque_return = collections.deque(folder_suggestions, maxlen=size)
    deque_return.reverse()
    return deque_return

def load_folder_suggestions_dict(folder_suggestions_deque):
    shortcuts = [chr(i) for i in range(97,97+len(folder_suggestions_deque))]
    dict_return = dict( zip(shortcuts, folder_suggestions_deque) )
    return dict_return


def print_folder_suggestions(folders_dict):
    for key in sorted(folders_dict.keys()) :
        print("(", key, ")", folders_dict[key].replace(documents_folder+"/", ""))

def update_folder_suggestions(newest_directory):
    f_s_return = [elem for elem in folder_suggestions if not newest_directory == elem]
    f_s_return.append(newest_directory)

    f_s_de_return = load_folder_suggestions_deque(f_s_return, size_last_folders)
    f_s_di_return = load_folder_suggestions_dict(f_s_de_return)

    return f_s_return, f_s_de_return, f_s_di_return

def format_number(number, num_digits):
    return str(number).zfill(num_digits)

def get_filename_suggestions(directory):
    filenames = [".".join(elem.split(".")[:-1]) for elem in os.listdir(directory) if ".jpg" in elem.lower()]
    variations = []
    for name in filenames:
        for i, part in enumerate(name.split("_")):
            if part.isdigit():
                variations.append(("_".join(name.split("_")[:i]) + "_" + format_number(int(part)+1,2) + "_" + "_".join(name.split("_")[i+1:])).strip("_"))
    suggestions = [elem for elem in variations if not any(filename == elem for filename in filenames)]
    suggestions = sorted(suggestions)
    suggestions.reverse()

    suggestions_intelligent = []
    for i, name in enumerate(suggestions):
        for j, part in enumerate(name.split("_")):
            if part.isdigit():
                prefix = "_".join(name.split("_")[:j])
                rest = suggestions[i+1:]
                if not any(prefix in x for x in rest):
                    if not any(name in x for x in suggestions_intelligent):
                        suggestions_intelligent.append(name)
    suggestions_intelligent.reverse()
    shortcuts = [chr(i) for i in range(97,97+len(suggestions_intelligent))]
    dict_return = dict( zip(shortcuts,suggestions_intelligent) )
    return dict_return

def print_filename_suggestions(filename_suggestions_dict):
    for key in sorted(filename_suggestions_dict.keys()):
        print("(", key, ")", filename_suggestions_dict[key])



folder_suggestions = load_folder_suggestions(config_file, documents_folder)
folder_suggestions_deque = load_folder_suggestions_deque(folder_suggestions, size_last_folders)
folder_suggestions_dict = load_folder_suggestions_dict(folder_suggestions_deque)

print("\nload .jpg's from " + scan_folder)

scan_folder_list = os.listdir(scan_folder)
image_list = [obj for obj in scan_folder_list if ".jpg" in obj.lower()]
image_list = sorted(image_list)

print("sort: \n")


move_directory = ""
move_filename = ""
presentation = True
show_folder_suggestions = True
ask_for_move_folder = True
show_filename_suggestions = True
while len(image_list) > 0:

    if presentation:
        command = ["gpicview", scan_folder+'/'+image_list[0]]
        proc = subprocess.Popen(command)
        time.sleep(showtime)
        proc.poll()
        proc.kill()
    presentation = True

    if show_folder_suggestions:
        print_folder_suggestions(folder_suggestions_dict)
    show_folder_suggestions = True

    if ask_for_move_folder:
        inp = str(raw_input("choose folder: ("+documents_folder+"/)"))
        if inp in folder_suggestions_dict.keys():
            move_directory = folder_suggestions_dict[inp]
        else:
            if any(x == inp for x in ["delete", "remove"]):
                os.remove(scan_folder+"/"+image_list[0])
                image_list.pop(0)
                continue
            elif any(x == inp for x in ["repeat", "back"]):
                show_folder_suggestions = False
                continue
            elif inp == "tree":
                command = "tree -d "+documents_folder
                os.system(command)
                presentation = False
                show_folder_suggestions = False
                continue
            elif inp == "help":
                print("delete/remove: delete this file")
                print("repeat/back: show file again")
                print("tree: show folder-structure of documents-folder")
                presentation = False
                show_folder_suggestions = False
                continue
            else:
                move_directory = documents_folder+"/"+inp.strip("/")
                if not os.path.isdir(move_directory):
                    os.makedirs(move_directory)
    ask_for_move_folder = True


    if show_filename_suggestions:
        filename_dict = get_filename_suggestions(move_directory)
        print_filename_suggestions(filename_dict)
    show_filename_suggestions = True

    inp = str(raw_input("choose filename: "))
    if inp in filename_dict.keys():
        move_filename = filename_dict[inp]+".jpg"
    elif inp == "back":
        presentation = False
        continue
    elif inp == "help":
        print("back: go back to folder_selection without showing the image again")
        presentation = False
        show_folder_suggestions = False
        ask_for_move_folder = False
        show_filename_suggestions = False
        continue
    else:
        move_filename = inp.replace(".jpg","%").strip("%")+".jpg"

    print("move file:", image_list[0], "to: .../", move_directory.replace(documents_folder+"/",""), "/", move_filename, "\n")
    shutil.move(scan_folder+"/"+image_list[0], move_directory+"/"+move_filename)
    folder_suggestions, folder_suggestions_deque, folder_suggestions_dict = update_folder_suggestions(move_directory)
    save_folder_suggestions(config_file)
    image_list.pop(0)
