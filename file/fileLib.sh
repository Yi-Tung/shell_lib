#!/bin/sh

[[ ! "${__SH_FILELIB__}" = "" ]] && exit
readonly __SH_FILELIB__="enable_fileLib_sh"

g_ini_file_name="default_config.ini"

#================================#
# Function: set_ini_file_name    #
# Parameter: file name           #
# Output: NONE                   #
# Return: 0 or 1                 #
# Description: The function will #
#  try to set the file name to   #
#  the global variable           #
#  'g_ini_file_name'. When the   #
#  file does not exist, setting  #
#  will fail and the function    #
#  will return 0. Otherwise, it  #
#  will change the global        #
#  variable 'g_ini_file_name     #
#  and return 1.                 #
#================================#
function set_ini_file_name() {
  local _isSet=false
  if [[ ! "${1}" = "" ]]
  then
    if [ -f ${1} ]
    then
      g_ini_file_name="${1}"
      _isSet=true
    fi
  fi
  ${_isSet} && return 1 || return 0
}

#================================#
# Function: get_ini_file_name    #
# Parameter: NONE                #
# Output: file name              #
# Return: 0 or 1                 #
# Description: The function will #
#  print the global variable     #
#  'g_ini_file_name'. If the     #
#  variable is empty, the        #
#  function will return 0.       #
#  Otherwise, it will return 1,  #
#================================#
function get_ini_file_name() {
  echo "${g_ini_file_name}"
  [ -z ${g_ini_file_name} ] && return 0 || return 1
}

#==================================#
# Function: get_data_from_ini_file #
# Parameter: group, field          #
# Output: data correspondgin to    #
#         the field in the group   #
# Return: 0 or 1                   #
# Description: The function will   #
#  read a configuration file via   #
#  the global variable             #
#  'g_ini_file_name'. And search   #
#  the target via the group and    #
#  field. If the target exists in  #
#  the configuration file, the     #
#  function will print the data    #
#  corresponding by the target and #
#  return 1, Otherwise, it print   #
#  nothing and return 0.           #
#==================================#
function get_data_from_ini_file() {
  local _isFound=false
  if [[ ! "${1}" = "" ]] && [[ ! "${2}" = "" ]]
  then
    local _ret=""
    local _group="${1}"
    local _field="${2}"
    local _gFound=false
    local _mFound=false

    while read line
    do
      if ${_gFound}
      then
        if [[ "${line}" = "["*"]" ]]
        then
          _mFound=false
          break
        elif [[ "`echo ${line} | awk -F '=' '{print $1}'`" = "${_field}" ]]
        then
          _ret=`echo ${line} | awk -F '=' '{print $2}'`
          _mFound=true
          break
        fi
      elif [[ "[${_group}]" = "${line}" ]]
      then
        _gFound=true
      fi
    done < ${g_ini_file_name}

    _isFound=${_mFound}
    echo ${_ret}
  fi
  ${_isFound} && return 1 || return 0
}

#==================================#
# Function: set_data_to_ini_file   #
# Parameter: group, field, data    #
# Output: NONE                     #
# Return: 0 or 1                   #
# Description: The function will   #
#  try to search the target via    #
#  the group and field in the file #
#  'g_ini_file_name'. And then     #
#  setting the data to the value   #
#  of the field. If the target     #
#  does not be found, the function #
#  will return 0. Otherwise, it    #
#  will return 1.                  #
#==================================#
function set_data_to_ini_file() {
  local _isSet=false
  if [[ ! "${1}" = "" ]] && [[ ! "${2}" = "" ]]
  then
    local _os_type="`uname -s`"
    local _group="${1}"
    local _field="${2}"
    local _data="${3}"
    local _gFound=false
    local _mFound=false
    local _mIndex=-1
    local _index=1

    while read line num
    do
      if ${_gFound}
      then
        if [[ "${line}" = "["*"]" ]]
        then
          _mFound=false
          break
        elif [[ "`echo ${line} | awk -F '=' '{print $1}'`" = "${_field}" ]]
        then
          _mIndex=${_index}
          _mFound=true
          break
        fi
      elif [[ "[${_group}]" = "${line}" ]]
      then
        _gFound=true
      fi
      _index=$((_index+1))
    done < ${g_ini_file_name}

    if ${_mFound}
    then
      case "${_os_type}" in
        "Linux"*)
          _isSet=true
          sed -i "${_mIndex}s/.*/${_field}=${_data}/g" ${g_ini_file_name}
          ;;
        "Darwin"*)
          _isSet=true
          sed -i '' "${_mIndex}s/.*/${_field}=${_data}/g" ${g_ini_file_name}
          ;;
        *)
          _isSet=false
          ;;
      esac
    fi

  fi
  ${_isSet} && return 1 || return 0
}

