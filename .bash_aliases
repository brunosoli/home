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
alias curitiba='curl http://wttr.in/curitiba'
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
	rdesktop -u Administrator -r disk:home=/home/bruno.oliveira 10.0.0.15
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

# JSON e YAML
function json2yaml {
  python -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))'
}

function yaml2json {
  python -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin.read())))'
}

# Logs

# Uso:
# find-logins <usuario>
#
# Encontra registros de log
#
# Estrutura de diretórios recomendada:
# .
# ├── g10a
# │   ├── auth.log
# │   ├── auth.log.1
# └── g10b
#     ├── auth.log
#     └── auth.log.1
#
function find-logins() {
    usuario=$1
    log=$2

    out="$usuario.log"

    if [[ -f "$out" ]]; then
        echo "O arquivo \"$out\" será sobrescrito. Deseja continuar? [sN]: "
        read OP
        if [ "$OP" != "s" ]; then
            return
        fi
        >"$out"
    fi
    
    for d in $(ls -d */); do
        for f in $(ls -t $d"auth".log*); do
            year=$(ls -l --time-style="+%Y" "$f" | awk '{print $6}')
            if [[ $f == *.gz ]]; then
                logins=$(zgrep -a -E "lightdm.+session opened.+$usuario" "$f")
            else
                logins=$(grep -a -E "lightdm.+session opened.+$usuario" "$f")
            fi

            if [[ ! -z "$logins" ]]; then
                echo "$logins" | while read line; do
                    echo "$year $line" | tee -a "$out"
                done
            fi
        done
    done

    if [[ -f "$out" ]]; then
        sort "$out" >"$usuario-sorted.log"
    else
        echo "Nenhum login encontrado."
    fi
}
