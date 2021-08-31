os_type=`uname`
if [[ $os_type == "Darwin" ]] ; then
  bash scripts/darwin_setup.sh
elif [[ $os_type == "Linux" ]] ; then
  bash scripts/linux_setup.sh
fi
