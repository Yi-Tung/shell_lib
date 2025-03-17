#!/bin/sh

[[ ! "${__SH_NUMBERLIB__}" = "" ]] && exit
readonly __SH_NUMBERLIB__="enable_numberLib_sh"

#================================#
# Function: is_positive_number   #
# Parameter: data                #
# Output: "true" or "false"      #
# Return: 0 or 1                 #
# Description: The function will #
#  check the parameter whether   #
#  is a positive number. If it   #
#  is, print "true" and return   #
#  1. Otherwise, print "false"   #
#  and return 0.                 #
#================================#
function is_positive_number() {
  local _isCheck=false
  if [ -z ${1} ]
  then
    _isCheck=false
  else
    _isCheck=true
    if [[ ${1} =~ ^[0-9]+$ ]] || [[ ${1} =~ ^[+][0-9]+$ ]]
    then
      echo 'true'
    else
      echo 'false'
    fi
  fi
  ${_isCheck} && return 1 || return 0
}

#================================#
# Function: is_negative_number   #
# Parameter: data                #
# Output: "true" or "false"      #
# Return: 0 or 1                 #
# Description: The function will #
#  check the parameter whether   #
#  is a negative number. If it   #
#  is, print "true" and return   #
#  1. Otherwise, print "false"   #
#  and return 0.                 #
#================================#
function is_negative_number() {
  local _isCheck=false
  if [ -z ${1} ]
  then
    _isCheck=false
  else
    _isCheck=true
    if [[ ${1} =~ ^-[0-9]+$ ]]
    then
      echo 'true'
    else
      echo 'false'
    fi
  fi
  ${_isCheck} && return 1 || return 0
}

#================================#
# Function: _reverse_string      #
# Parameter: data                #
# Output: reverse data           #
# Return: 0 or 1                 #
# Description: The function will #
#  reverse the data and print    #
#  out the result. If the data   #
#  is empty, return 0.           #
#  Otherwise, reutrn 1.          #
#================================#
function _reverse_string() {
  local _isConvert=false
  if [ -z ${1} ]
  then
    _isConvert=false
  else
    local _para="${1}"
    local _ret=""

    for _index in `seq ${#_para} 0`
    do
      _ret="${_ret}${_para:_index:1}"
    done

    echo ${_ret}
    _isConvert=true
  fi
  ${_isConvert} && return 1 || return 0
}

#================================#
# Function: HexToBinary          #
# Parameter: data                #
# Output: binary value           #
# Return: 0 or 1                 #
# Description: The function will #
#  try to convert the data which #
#  is hexadeciamal number to the #
#  binary value. But if the      #
#  value is greater than 255 #
#  or is nothing, the function   #
#  will print nothing and return #
#  0. Otherwise, the function    #
#  will print the result and     #
#  return 1.                     #
#================================#
function HexToBinary() {
  local _isConvert=false
  if [ -z ${1} ]
  then
    _isConvert=false
  else
    local _hex_val=${1}
    local _dec_val=`printf "%d" 0x${_hex_val} 2>&1`

    if [ ${_dec_val} -gt 255 ]
    then
      _isConvert=false
    else
      local _ret=""
      local _bit=0

      for _index in `seq 0 7`
      do
        _bit=$((_dec_val % 2))
        _ret="${_ret}${_bit}"
        _dec_val=$((_dec_val / 2))
      done

      echo "`_reverse_string ${_ret}`"
      _isConvert=true
    fi
  fi
  ${_isConvert} && return 1 || return 0
}

#================================#
# Function: BinaryToHex          #
# Parameter: data                #
# Output: hexadecimal value      #
# Return: 0 or 1                 #
# Description: The function will #
#  try to convert the data which #
#  is binary number  to          #
#  hexadecimal value. But if any #
#  bit of the value is not 0 or  #
#  1, the function will print    #
#  nothing and return 0.         #
#  Otherwise, the function will  #
#  print the result and return   #
#  1.                            #
#================================#
function BinaryToHex() {
  local _isConvert=false
  if [ -z ${1} ]
  then
    _isConvert=false
  else
    local _bin_val="${1}"

    if [ ${#_bin_val} -ne 8 ]
    then
      _isConvert=false
    else
      local _ret=""
      local _hex_val=0
      local _carry=1
      local _bit=0

      _isConvert=true
      for _index in `seq 7 0`
      do
        _bit=${_bin_val:_index:1}
        if [[ ! "${_bit}" = "0" ]] && [[ ! "${_bit}" = "1" ]]
        then
          _isConvert=false
          break
        else
          _hex_val=$((_hex_val + _bit * _carry))
          _carry=$((_carry * 2))
        fi
      done
      _ret=${_hex_val}

      $_isConvert && echo `printf "%.2x" ${_ret}`
    fi
  fi
  ${_isConvert} && return 1 || return 0
}

