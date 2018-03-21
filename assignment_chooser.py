import random
import sys


filename = "tasks.txt"
#####
#
# easily put all tasks into $filename
# one line each task
#
#####

def readlist(file_list):
    with open(file_list, "r") as f:
        lines = f.readlines()
    lines = [l.strip("\n\r") for l in lines if not l.startswith("#")]

    return lines

def checkline(file_list, line):
    with open(file_list, "r") as f:
        lines = f.readlines()
    lines = [l.strip("\n\r") for l in lines]

    idx = lines.index(line)
    l = lines[idx]

    print("task '{}' done!".format(line))
    l_new = input("note: ")
    lines[idx] = "# " + l + " --- " + l_new

    with open(file_list, "w") as f:
        for l in lines:
            f.write(l + "\n")

def get_task(file_list):
    l = readlist(filename)
    if len(l) == 0:
        print("all tasks done!")
        sys.exit(0)
    random.shuffle(l)
    task = l[0]
    print("next task: ", task)
    return task

def get_input(text, l_valid):
    inp = input(text)
    if inp in l_valid:
        return inp
    else:
        print("your input was invalid")
        return get_input(text,l_valid)

def work(file_list):
    task = get_task(file_list)
    inp = get_input("task_done?\n", ["yes","no","exit"])

    if inp == "no":
        return
    if inp == "exit":
        sys.exit(0)
    checkline(file_list, task)

if __name__ == "__main__":
    while(True):
        work(filename)
