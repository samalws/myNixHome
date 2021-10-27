export PATH=$PATH:~/heaven/bin
export EDITOR=vim
export _JAVA_AWT_WM_NONREPARENTING=1
if [ "$DISPLAY" == "" ]
then
startx
else
eval "$(direnv hook bash)"
fi
