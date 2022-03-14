alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lha'
alias l='ls'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ping='ping -i 0,2'
alias pcat='pygmentize -g' # apt install python3-pygments
alias vpn='sudo openfortivpn --config="$HOME/.openfortivpn.config"'
alias rdesktop='rdesktop -g 1280x960'
alias bfg='java -jar ~/workspace/bfg/bfg-1.13.0.jar'
alias bastion='ssh -D 6666 bruno.oliveira@bastion'
alias kubectl='microk8s.kubectl'

# GIT
function git-archive-branch() {
    BRANCH=$1
    # tag
    git tag "archive/$BRANCH" "$BRANCH"
    git branch -D "$BRANCH"
    git push origin ":$BRANCH"
    git push --tags

    # Para restaurar o branch:
    # git checkout -b <branchname> archive/<branchname>
}

alias git-prune-branches-not-on-remote="git remote prune origin"

# NETWORK
function tp() {
    IP=$1
    PORT=$2
    </dev/tcp/$IP/$PORT && echo Port open. || echo Port closed.
}

function tpu() {
    IP=$1
    PORT=$2
    </dev/udp/$IP/$PORT && echo Port open. || echo Port closed.
}

function telnet_https() {
    HOST=$1
    PORT=$2
    openssl s_client -connect $HOST:$PORT
}

function cmcpw() {
    gpg -d "$1" | less
}

function get_next_uidNumber()
{
  last_uidNumber=$(ldapsearch -x "(objectClass=posixAccount)" uidNumber | grep "uidNumber: " | sed "s|uidNumber: ||" | uniq | sort -n | grep -v "65..." | tail -n 1)
  echo $((last_uidNumber + 1))
}

function get_next_gidNumber()
{
  last_gidNumber=$(ldapsearch -x "(objectClass=posixGroup)" gidNumber | grep "gidNumber: " | sed "s|gidNumber: ||" | uniq | sort -n | grep -v "65..." | tail -n 1)
  echo $((last_gidNumber + 1))
}

function cmccontab() {
	rdesktop -u contab -r disk:home=/home/bruno.oliveira 10.0.0.39
}

function cmcimp() {
	rdesktop -u admsuporte -r disk:Docs=/home/bruno.oliveira 10.0.0.7
}

function buriti() {
	rdesktop -u admsuporte -r disk:home=/home/bruno.oliveira 10.0.0.35
}

function copaiba() {
	rdesktop -d CMCWIN -u Administrator -r disk:home=/home/bruno.oliveira 10.0.0.15
}

function cmcwinapl() {
	rdesktop -d CMCWIN -u admsuporte -r disk:Docs=/home/bruno.oliveira 10.0.0.36
}

function cmcrds() {
	rdesktop -d CMCWIN -u rdsadmin -r disk:home=/home/bruno.oliveira 10.0.0.40
}

function cmcrds-ext() {
	rdesktop -d CMCWIN -u rdsadmin -r disk:home=/home/bruno.oliveira 177.69.44.66:13389
}

