# Permanent aliases

# List aliases
alias ll="ls -l --color=auto"
alias la="ll -a"

# Shortcuts for ease of use
alias vim="nvim"
alias s="sudo shutdown now"
alias uni="ssh wi21139@login.dhbw-stuttgart.de"
alias c="clear"
alias rwlan="sudo systemctl restart NetworkManager"
alias taskManager="htop"

# Directory aliases
alias home="cd ~"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Go to old Directory
alias bd='cd -'

# Xampp Shortcuts
alias xamppControl="sudo /opt/lampp/lampp"
alias xamppManage="cd /opt/lampp; sudo ./manager-linux-x64.run; cd"
alias xamppLogs="cat /opt/lampp/logs/php_error_log"

# Show command line history
alias h="history | grep"

# Some git functions
gcom() {
	git add .
	git commit -m "$1"
	}
lazyg() {
	git add .
	git commit -m "$1"
	git push
}
