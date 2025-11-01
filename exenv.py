#!/usr/bin/env python3

import os
import sys

class EnvError(Exception):
    pass

class ExecError(Exception):
    pass


def read_env_variables(pid):
    try:
        with open('/proc/{pid}/environ'.format(pid=pid), 'r') as f:
            env_vars = f.read().split('\0')
            return {
                name: value
                for var in env_vars if '=' in var
                for name, _, value in [var.partition('=')]
            }
    except FileNotFoundError as e:
        raise EnvError("Process with PID {pid} not found".format(pid=pid)) from e

    except PermissionError as e:
        raise EnvError("Permission denied: Cannot read the environment variables of the process.") from e


def exec_process_with_env(pid, command):
    env_vars = read_env_variables(pid)
    
    if env_vars is not None:
        env = {key: value for key, value in env_vars.items()}
        try:
            os.execve(command[0], command, env)
        except Exception as e:
            print("Failed to execute command: {e}".format(e=e))
            sys.exit(1)

def print_usage():
    print("Usage: exenv <PID> <command> [args]")    
        
def parse_command_line():
    if len(sys.argv) < 3:
        print_usage()
        sys.exit(1)

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Invalid PID: {pid}".format(pid=sys.argv[1]))
        print_usage()
        sys.exit(1)

    command = sys.argv[2:]

    return pid, command
    
def main():
    pid, command = parse_command_line()

    try:
        exec_process_with_env(pid, command)
    except (EnvError, ExecError) as e:
        print(e)
        sys.exit(1)
    
    
if __name__ == "__main__":
    main()
