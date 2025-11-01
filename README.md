# NAME

exenv - execute a command in the environment of a specified process

# SYNOPSIS

**exenv** \<PID\> \<command\> \[args\]

# DESCRIPTION

The **exenv** command allows you to execute a new process with the same
environment variables as a specified running process.

**\<PID\>**

:   The process ID of the existing process whose environment variables
    you want to use.

<!-- -->

**\<command\>**

:   The command to execute. This can include script names or binaries.

<!-- -->

**\[args\]**

:   Optional arguments to pass to the command.

    If the specified **\<PID\>** is not valid, or if permission is
    denied when trying to access the environment of the specified
    process, the program will output an error message and terminate.

# EXAMPLES

To execute a command using the environment variables from the process
with PID 1234 obtaining environment variables required to run Xorg
application:

> **exenv 1234 /usr/bin/xclip -o**

To use SSH agent of running process you can use:

> **exenv 2345 ssh user@server**

To use environment of running process and add something extra:

> **exenv 3456 env FOO=bar /usr/bin/some_command \--with-args yes**

# COPYRIGHT

Copyright © 2025 Tomáš Čech \<sleep_walker@gnu.org\>

License GPLv3+: GNU GPL version 3 or later
https://gnu.org/licenses/gpl.html

\
This is free software: you are free to change and redistribute it. There
is NO WARRANTY, to the extent permitted by law.

# SEE ALSO

execvpe(2)
