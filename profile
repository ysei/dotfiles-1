# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/perl5/bin" ] ; then
    PATH="$HOME/perl5/bin:$PATH"
fi

export DOIT_SERVER=7XVDCX1
export EDITOR='vim'
export FIGNORE=.svn
export GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
export GREP_OPTIONS='--color'
export HISTCONTROL='erasedups'
export PERL5LIB="$HOME/perl5/lib/perl5"
export PERLDB_OPTS="windowSize=40"
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PROMPT_DIRTRIM='2'
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nnoremap q ZQ' -c 'nnoremap <Space> <PageDown>' -\""
export PAGER="~/bin/vimpager"
# export PERLDOC_PAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nnoremap q ZQ' -c 'nnoremap <Space> <PageDown>' -\" < "

if [ ! -e /usr/share/terminfo/x/xterm-256color ] ; then
    TERM=xterm-color
    if [ ! -e /usr/share/terminfo/x/xterm-color ] ; then
        TERM=xterm
    fi
fi

