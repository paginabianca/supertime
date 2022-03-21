![supertime logo](img/supertime-logo-left.png)

`supertime` is the easiest way to measure all your command timings.

Designed for \*nix systems, `supertime` uses the GNU time command to accurately
measure execution times for any executable command and saves the measurements
in one place.

## **Usage**

Usage: `supertime.sh "command to execute"`

Supertime automatically detects if you're in a git repository and marks a
recorded timing with the respecting version.

## **Installation**

Simply clone this repository to your favorite place to store shell scripts.

The only thing `supertime` depends on is the GNU `time` package. You can install
it though your distributions package manager.

## **How to Contribute**

1. Clone repo and create a new branch: `$ git checkout https://github.com/paginabianca/supertime -b new_branch_name`.
2. Make changes and perform some tests.
3. Submit a Pull Request with a description of your changes.

## Info

This tool is made for my own needs and I do not provide ANY warranty whatsoever.
