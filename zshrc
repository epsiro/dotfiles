###############################################################################
# ~/.zshrc by Bendik S. Soevegjarto 2009 - 2014 - Version 0.5.7
#

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
EDITOR='vim'
PAGER='less'

setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_space
set histdup='all'
unsetopt beep

# It's not nice to kill your children
setopt nohup

# Use my own color file for ls colors
eval `dircolors -b ~/.dir_colors`

# Paranoid umask
umask 027


# Sort capital letters first
export LC_COLLATE=C

export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-linux


###############################################################################
# Completion
#

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd


###############################################################################
# Host specific setup
#

autoload -U colors
colors

for COL in RED GREEN YELLOW BLUE MAGENTA WHITE BLACK; do
    eval PR_$COL='%{$fg_no_bold[${(L)COL}]%}'
    eval PR_BOLD_$COL='%{$fg_bold[${(L)COL}]%}'
done

HOST=exec hostname > /dev/null
COLOR=$PR_WHITE

if [[ $HOST == "lazarus.ifi.uio.no" ]]; then
    COLOR=$PR_YELLOW
    alias ls="ls --color"
    export LC_CTYPE=en_GB.UTF-8 

else
    # The following lines were added by compinstall
    zstyle :compinstall filename '~/.zshrc'

    autoload -Uz compinit
    compinit
    # End of lines added by compinstall

    # Aliases
    alias ls='ls -h --group-directories-first --color'
    alias suio='ssh bendikss@login.ifi.uio.no'
    alias suix='ssh -X bendikss@login.ifi.uio.no'
    alias uiscreen='ssh -t bendikss@ben.ifi.uio.no screen -dR'
    alias getsmart='clear; cd ~/Dropbox/getSmart; ls'
fi

case $HOST in
    tablet )
        autoload -U zmv
        COLOR=$PR_BLUE;;

        # Map Caps Lock to ESC
#        ~/.xmod

        # Keychain
#        /usr/bin/keychain -Q -q --nogui ~/.ssh/id_rsa
#        [[ -f $HOME/.keychain/$HOSTNAME-sh ]] &&
#            source $HOME/.keychain/$HOSTNAME-sh

#        export JAVA_HOME=/usr/lib/jvm/java-6-sun
#        export _JAVA_AWT_WM_NONREPARENTING=1
#        export PATH=$PATH:/opt/altera/quartus/bin
#        export TERM='xterm-256color'
#        alias pjsua='pjsua --config-file ~/.pjsuarc'
#        alias di.fm='php ~/Dropbox/config/scripts/mplayerinfo.php | tail -n 1'
#        alias vim='vim --servername vimtex'
#        alias spnd='gnome-power-cmd suspend'
#        alias hibr='gnome-power-cmd hibernate';;

    mediahead )
        COLOR=$PR_MAGENTA;;

        # Keychain
#        /usr/bin/keychain -Q -q --nogui ~/.ssh/id_dsa
#        [[ -f $HOME/.keychain/$HOST-sh ]] &&
#            source $HOME/.keychain/$HOST-sh

#        alias 16:9='xrandr --output VGA1 --mode 1360x768; eval `cat ~/.fehbg`'
#        alias  4:3='xrandr --output VGA1 --mode 1024x768; eval `cat ~/.fehbg`'
#        alias exp='export DISPLAY=:0'
#        alias spotify='wine ~/.wine/drive_c/Program\ Files/Spotify/spotify.exe\
#            > /dev/null &';;

    blackbox )
        COLOR=$PR_GREEN;;

#    rosa )
#        export PATH=$PATH:/home/bendikss/jdk1.6.0_18/bin;;

    imac.local )
        COLOR=$PR_RED
        source /usr/local/Cellar/coreutils/8.7/aliases;;
esac

###############################################################################
# Key Bindings
#

# Vi-mode
bindkey -v

# Make 'hh' equal Esc
bindkey 'hh' vi-cmd-mode

# Make 'g' in vi-cmd-mode clear the screen
bindkey -M vicmd 'g' clear-screen

# Easy history search
bindkey '^R'    history-beginning-search-backward
bindkey '^N'    history-beginning-search-forward

# TODO: Make 'ZZ' exit zsh
#bindkey -M vicmd 'ZZ'

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[6~' end-of-history
bindkey '^[[5~' beginning-of-history
bindkey '^[^I'  reverse-menu-complete
bindkey '^[OA'  up-line-or-history
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[OB'  down-line-or-history
bindkey '^[OD'  backward-char
bindkey '^[OC'  forward-char
bindkey '^P'    history-beginning-search-backward
bindkey '^N'    history-beginning-search-forward
bindkey '^[[[A' run-help
bindkey '^[[[B' which-command
bindkey '^[[[C' where-is
bindkey '^D'    list-choices


###############################################################################
# Show me which mode I'm in
#

VIMODE='-- INSERT --'
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ -- NORMAL --}/(main|viins)/ -- INSERT --}"
    zle reset-prompt
}
zle -N zle-keymap-select

function accept_line {
    VIMODE=' -- INSERT --'
    builtin zle .accept-line
}
zle -N accept_line
bindkey -M vicmd "^M" accept_line


###############################################################################
# Fancy <Ctrl+Z>
#

fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        bg
        zle redisplay
    else
        zle push-input
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


###############################################################################
# Show git info in prompt
#

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git

###############################################################################
# Set prompt and title
#

case $TERM in
    rxvt-unicode*)
        precmd () {
            print -Pn "\e]0;%n@%m: %~\a"

            if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
                zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{white}]'
            } else {
                zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}●%F{white}]'
            }

            vcs_info
        };;
esac

setopt prompt_subst
setprompt () {
    RPROMPT='${PR_BOLD_WHITE}${VIMODE}%{${reset_color}%}'
    PROMPT='%*%s %w [%B%4~%b]${vcs_info_msg_0_} %n %B:%b ${COLOR}%m
%{${reset_color}%}$ '
}

setprompt

###############################################################################
# Functions
#

cmdfu() {
    curl "http://www.commandlinefu.com/commands/matching/$@/\
$(echo -n $@ | openssl base64)/plaintext";
}

tl() {
    wget -qO- "http://ajax.googleapis.com/ajax/services/\
language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | \
    sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/';
}

define() {
    local y="$@";curl -sA"Opera" "http://www.google.com/search?q=define:\
${y// /+}" | grep -Eo '<li>[^<]+'| sed 's/<li>//g' | nl | \
    perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null;
}

download_pdf() {
    wget --recursive --accept=pdf --no-parent --level=1 --no-directories $1 && rm robots.txt
}

xkcd() {
    local xkcdsrc;
    local xkcdurl;

    if [[ $1 == "random" ]];
        then xkcdurl="http://dynamic.xkcd.com/comic/random/";
        else xkcdurl="http://xkcd.com/${1// /+}";
    fi;

    xkcdsrc=$(wget -qO- ${xkcdurl});
    echo $xkcdsrc | \grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}' | xargs feh;
    echo $xkcdsrc | sed -n 's/\<h3\>/&/p' | head -n1; # | sed -n 's/<[^>]*>//g;/</N;//b';
    echo $xkcdsrc | \grep -Po '(?<=(\w{3})" title=").*(?=" alt)';
}

yt() mplayer -fs -quiet $(youtube-dl -g "$1")

yt2() mplayer -fs -quiet -cache-min 90 $(youtube-dl -g "$1")

yttv() local cmd=`ssh elfreak@mediahead "export DISPLAY=:0 && youtube-dl -g '$1' \
| xargs mplayer -fs -quiet"` echo "$cmd"

googl () {
    curl -s -d "url=${1}" http://goo.gl/api/url | \
    sed -n "s/.*:\"\([^\"]*\).*/\1\n/p" ;
}

shout() {
    curl -s "http://shoutkey.com/new?url=${1}" | \
    sed -n "/<h1>/s/.*href=\"\([^\"]*\)\".*/\1/p";
}

wiki() { dig +short txt "$*".wp.dg.cx | fold -s ;}

ytplay() {
    args="$*";
    mplayer -fs $(youtube-dl -g "http://www.youtube.com$(lynx --source "http://www.youtube.com/results?search_query=${args// /+}&aq=f" | \
        grep -m1 '<a id=.*watch?v=.*title'|cut -d\" -f4)");
}

songplay() {
    args="$*";
    mplayer -fs -vo null -really-quiet $(youtube-dl -g "http://www.youtube.com$(lynx --source "http://www.youtube.com/results?search_query=${args// /+}&aq=f" | \
        grep -m1 '<a id=.*watch?v=.*title'|cut -d\" -f4)");
}

atb() {
    l=$(tar tf $1)
    if [ $(echo "$l" | wc -l) -eq $(echo "$l" | grep $(echo "$l" | head -n1) | wc -l) ]
    then
        tar xf $1
    else
        mkdir ${1%.t(ar.gz||ar.bz2||gz||bz||ar)} && \
        tar xf $1 -C ${1%.t(ar.gz||ar.bz2||gz||bz||ar)}
    fi;
}

webshare() {
    local SSHHOST=exeen.net
    python -m SimpleHTTPServer &
    echo http://$SSHHOST:8000 | xclip
    echo Press enter to stop sharing, http://$SSHHOST:8000 copied to clipboard
    /usr/bin/ssh -p 443 -R 8000:127.0.0.1:8000 $SSHHOST 'read'
    kill $(jobs -p | head)
}

image_cc() {
    convert -size 720x60 xc:none -pointsize 30 -gravity center -stroke black \
    -strokewidth 3 -annotate 0 'Bendik S. Søvegjarto 2010 CC-License BY-NC-SA' \
    -background none -shadow 300x3+0+0 +repage -stroke none -fill white \
    -annotate 0 'Bendik S. Søvegjarto 2010 CC-License BY-NC-SA' \
    $1  +swap -gravity southeast -geometry +0-3 \
    -composite $1
}

texpdf() { pdflatex $1 && xpdf ${1%.tex}.pdf ;}

cpdf() { pdftohtml -i -stdout $1 | w3m -T text/html ;}

sun() {
    w3m -no-cookie "google.com/search?q=sun${1-rise}:${2-Oslo}" | sed -r '1,/^\s*1\./d;/^\s*2\./,$d;/^$/d;s/\[weat\]//;s/^ *//;0,/\ /s//\n/'
}

play_flash() {
    mplayer -zoom $(youtube-dl -g "$1")
}

# Return longest line
lline() { awk '(length>t) {t=length} END {print t}' $1 ;}

ccon() { w3m -no-cookie "google.com/search?q=${1-1usd}%20in%20${2-nok}" | sed -r '1,/^\s*1\./d; /^\s*2\./,$d; /^$/d' ;}

readfuse() { od -d $1 | head -n1 | sed -e 's/0000000 *//' | xargs -i perl -e '$str= unpack("B32", pack("N",{})); $str =~ s/.*([01]{4})([01]{4})$/$1 $2/; print "$str\n";' }

datefuture() { python -c 'import datetime as dt; import sys; print dt.date.today() + dt.timedelta(days=int(sys.argv[1]))' $1 }

# From mastensg
i() {
    (which apt-get >/dev/null 2>&1 && sudo apt-get install $*) ||
    (which yaourt >/dev/null 2>&1 && yaourt -S $*) ||
    (which pacman >/dev/null 2>&1 && sudo pacman -S $*)
}

s() {
    (which apt-cache >/dev/null 2>&1 && apt-cache search $*) ||
    (which yaourt >/dev/null 2>&1 && yaourt -Ss $*) ||
    (which pacman >/dev/null 2>&1 && pacman -Ss $*)
}

monitor() {
    while true; do clear; $*; read; done
}

imonitor() {
    f="$1"
    shift 1
    while true; do clear; bash -c "$*"; inotifywait -q $f; done
}

#gha () {
#    git remote add origin git@github.com:mastensg/$(basename $(pwd)).git
#    git push -u origin master
#}

# End from mastensg

###############################################################################
# Aliases
#

### Change directory ###
alias ...="cd ../.."
alias ..="cd .."
alias cheat='clear; cd ~/Dropbox/uio/www_docs/pub/cheat_sheets; ls'
alias config='clear; cd ~/Dropbox/config; ls -a'
alias docs='clear; cd ~/Documents; ls'
alias down='cd ~/downloads'
alias drop='clear; cd ~/Dropbox; ls'
alias epsiro='clear; cd ~/Dropbox/epsiro_accounting; ls'
alias proj='clear; cd ~/Dropbox/projects; ls'
alias tmp='cd /tmp'
alias uio='clear; cd ~/Dropbox/uio/2012a; ls'

### Redefine ###
alias df="df -Ph"
alias diff=colordiff
alias du="du -h"
alias exit="clear && exit"
alias grep="grep --color=auto"
alias head='head -n $((${LINES:-12}-4))'
alias ls="ls --color"
alias tail='tail -n $((${LINES:-12}-4))'
alias vim="vim -p"
alias vlc='vlc -I ncurses'

### New ###
alias 'ps?'='ps ax | grep '
alias bmp2png='for file in *.bmp; do convert "$file" "$(basename $file .bmp).png"; done'
alias busy='my_file=$(find /usr/include -type f | sort -R | head -n 1); my_len=$(wc -l $my_file | awk "{print $1}"); let "r = $RANDOM % $my_len" 2>/dev/null; vim +$r $my_file'
alias cx='chmod +x'
alias ds="while true; do clear; dropbox status; sleep 2; done"
alias el='elinks'
alias exeen='ssh -p 443 elfreak@exeen.net'
alias exscreen='ssh -p 443 -t elfreak@exeen.net screen -rd'
alias exxeen='ssh -X -p 443 elfreak@exeen.net'
alias fs_created="df / | awk ' /dev/ {print \$1}' | sudo su -c 'xargs tune2fs -l' | grep create"
alias fxchange="lftp sftp://sator:27022 -c 'login fxchange'"
alias ipaddr='ifconfig | sed -n "s/.*inet [^ ]*:\([^ ]*\) .*/\1/p"'
alias keylay='setxkbmap -layout us,no -variant dvp, -option compose:102,lv3:ralt_switch,grp:shift_toggle,grp_led:caps,ctrl:escape,terminate:ctrl_alt_bksp'
alias la="ls --color=always -lha"
alias learn='\ls /usr/bin | xargs whatis | grep -v nothing | less'
alias ll="ls --color=always -lh"
alias lld="ls --color=always -ld */"
alias lvim="vim -c \"normal '0\""
alias mh='ssh bendikss@mediahead'
alias mp='mplayer -fs -quiet'
alias minecraft='cd && java -Xmx1024M -Xms512M -cp minecraft.jar net.minecraft.LauncherFrame'
alias p2k='ssh bimbo -t p2k4'
alias s='screen -X screen'
alias scanip='nmap -sP $(nm-tool | grep " Address" | cut -d " " -f14-34 | cut -d "." -f1-3).0/24'
alias solve='zsh -c '\''echo "scale=4;$0 $@" | bc -l '\'''
alias sp='cat ~/Dropbox/uio/study_plan'
alias su="sudo su"
alias sz="du -skL * 2> /dev/null | sort -nr | cut -f2 | xargs -d '\n' du -shL 2> /dev/null | head"
alias tp='cat ~/Dropbox/uio/2011s/schedule'
alias tpm='cat ~/Dropbox/B+M/tpm'
alias tv='ssh elfreak@mediahead "./Dropbox/config/scripts/playtv.sh"'
alias zshrc='vim ~/.zshrc && source ~/.zshrc'

###############################################################################
# Notes
#
#     PROMPT='%*%s %w [%B%4~%b]${vcs_info_msg_0_} %n %B:%b %y %Bon%b ${COLOR}%m
#     %{${reset_color}%}$ '
#
# printf "%d\n" 0xBA
# alias sz="du -sh *"
# sun | sed q | xargs date +%R -d
#sun(){ w3m -no-cookie "google.com/search?q=sun${1-rise}:${2-Oslo}" | sed -r '1,/^\s*1\./d; /^\s*2\./,$d; /^$/d' ;}
