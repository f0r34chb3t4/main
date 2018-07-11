ORIGINAL:http://mcsp.wartburg.edu/zelle/cs360/handouts/python-process.html


System Calls in Python
Processing arguments
import sys

# argv is a list of strings containing the commandline params
#   argv[0] is always the name of the invoked command
for arg in sys.argv:
    print arg
argc = len(sys.argv)
fork
import os

# fork creates a child process. Returns 0 to the child, 
#    child's PID to the parent, and -1 on failure.

if os.fork() == 0:
   print "in child"
else:
   print "in parent"
exec
import os

# exec overlays the process with a program. exec is shorthand for a
#   family of functions:

# These versions reuqire full path to executeable program
#  execl(pathToProg, arg0, arg1, arg2, ...)
#  execv(pathToProg, argList)

# These two will search for prog on current PATH
#  execlp(prog, arg0, arg1, arg2, ...)
#  execvp(prog, argList)

os.execl("/bin/more", "more", "foo.txt")
os.execvp(sys.argv[0], sys.argv)
sleep
import time

# sleep(n) puts process to sleep for n seconds.
time.sleep(10)
exit
import sys

sys.exit(0)
wait
import os

# waits (sleeps) for child to terminate, returns pid and status
pid, status = wait()  # no arguments, returns a pair of values
print "Returned status:", status/256
getpid
import os

myId = os.getpid()
 
