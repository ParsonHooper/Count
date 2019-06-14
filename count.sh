#!/bin/bash

################################################################################
## Author: Devin P Shanahan                                                   ##
## Version: 0.0.1                                                             ##
##                                                                            ##
## This shell script counts the number of files in the working directory and  ##
## outputs the result sorted by file type.                                    ##
##                                                                            ##
## Usage: count [-r]                                                          ##
## -r: Count files recursively                                                ##
################################################################################

# Declare variables
countStandardFiles=0
countHiddenFiles=0
countStandardDirectories=0
countHiddenDirectories=0
countLinks=0
standardCommand="ls -lA | grep -c "
recursiveCommand="ls -lAR | grep -c "
standardFileRegex="'^-.*\s[^.]\S*$'"
hiddenFileRegex="'^-.*\s[.]\S*$'"
standardDirectoryRegex="'^d.*\s[^.]\S*$'"
hiddenDirectoryRegex="'^d.*\s[.]\S*$'"
linkRegex="^l"

# Output usage instructions to the console
printUsage() {
  printf "This program counts the number of files in the working directory and outputs the result sorted by file type.\n\n"
  printf "Usage: count [-r]\n"
  printf "   -r: Count files recursively.\n"
}

# Output results to the console
printOutput() {
  echo "Standard files: " $countStandardFiles
  echo "Hidden files: " $countHiddenFiles
  echo "Standard directories: " $countStandardDirectories
  echo "Hidden directories: " $countHiddenDirectories
  echo "Links: " $countLinks
}

# Parse arguments and perform counting
if [ $# -gt 1 ]
then
  printf "ERROR: Too many arguments.\n\n"
  printUsage
elif [ $# -lt 1 ]
then
  countStandardFiles=$(eval $standardCommand$standardFileRegex)
  countHiddenFiles=$(eval $standardCommand$hiddenFileRegex)
  countStandardDirectories=$(eval $standardCommand$standardDirectoryRegex)
  countHiddenDirectories=$(eval $standardCommand$hiddenDirectoryRegex)
  countLinks=$(eval $standardCommand$linkRegex)
  printOutput
elif [ $# -eq 1 ] && [ $1 = "-h" ]
then
  printUsage
elif [ $# -eq 1 ] && [ $1 = "-r" ]
then
  countStandardFiles=$(eval $recursiveCommand$standardFileRegex)
  countHiddenFiles=$(eval $recursiveCommand$hiddenFileRegex)
  countStandardDirectories=$(eval $recursiveCommand$standardDirectoryRegex)
  countHiddenDirectories=$(eval $recursiveCommand$hiddenDirectoryRegex)
  countLinks=$(eval $recursiveCommand$linkRegex)
  printOutput
else
  printf "ERROR: Incorrect argument.\n\n"
  printUsage
fi
