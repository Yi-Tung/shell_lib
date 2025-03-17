#!/bin/sh

[[ ! "${__SH_COMMONLIB__}" = "" ]] && exit
readonly __SH_COMMONLIB__="enable_commonLib_sh"

g_os_platform=""

#================================#
# Function: get_os_platform      #
# Parameter: NONE                #
# Output: "Linux" or "Mac"       #
# Return: 0 or 1                 #
# Description: The function will #
#  judge whether the environment #
#  is Linux or Mac. And then     #
#  print the result. If the      #
#  result is not one of them, it #
#  will return 0. Otherwise, it  #
#  will return 1.                #
#================================#
function get_os_platform() {
  if [ -z ${g_os_platform} ]
  then
    case "`uname -s`" in
      "Linux"*)
        g_os_platform="Linux"
        ;;
      "Darwin"*)
        g_os_platform="Mac"
        ;;
      *)
        ;;
    esac
  fi

  echo ${g_os_platform}
  [ -z ${g_os_platform} ] && return 0 || return 1
}

#================================#
# Function: to_lowercase         #
# Parameter: data                #
# Output: lowercase parameter    #
# Return: NONE                   #
# Description: The function will #
#  convert the parameter to      #
#  lowercase and print it out.   #
#================================#
function to_lowercase() {
  echo "`awk -v mVar="${1}" 'BEGIN {print tolower(mVar);}'`"
}

#================================#
# Function: to_uppercase         #
# Parameter: data                #
# Output: uppercase parameter    #
# Return: NONE                   #
# Description: The function will #
#  convert the parameter to      #
#  uppercase and print it out.   #
#================================#
function to_uppercase() {
  echo "`awk -v mVar="${1}" 'BEGIN {print toupper(mVar);}'`"
}

