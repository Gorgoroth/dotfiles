PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PERL_LOCAL_LIB_ROOT="/home/vk/perl5";
export PERL_MB_OPT="--install_base /home/vk/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/vk/perl5";
export PERL5LIB="/home/vk/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:/home/vk/perl5/lib/perl5";
export PATH="/home/vk/perl5/bin:$PATH";

#export TERM='xterm-256color'

export LS_COLORS='no=37:di=01;37:fi=37:ln=96:pi=37:so=37:bd=37:cd=37:or=37:mi=37:ex=95:*.deb=36'

#PROMPT_COMMAND='history -a;echo -en "\033[m\033[38;5;2m"$(( `sed -nu "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -nu "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB""'
#export PS1="\033[01;30m\][\u@\h:\w]$ \033[00;37m\]"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
