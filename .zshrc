# =============================================================================
# ZSH CONFIGURATION FOR POWERLEVEL10K
# =============================================================================
# CachyOS + Hyperland + Kitty + Zsh workflow
# DevOps/Infrastructure focus: Kubernetes, Docker, Terraform, Git

# =============================================================================
# INSTANT PROMPT (POWERLEVEL10K) — должен быть в начале
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================
export EDITOR=nano
export KUBE_EDITOR=nano
export LANG=en_US.UTF-8
typeset -U PATH path

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export HIST_IGNORE="(&|ls|q|t|c|exit|history|clear|)"

# History options
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt NOTIFY

# =============================================================================
# ZSH OPTIONS
# =============================================================================
setopt AUTO_CD
setopt GLOBDOTS
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# =============================================================================
# ZSH KEYBINDINGS
# =============================================================================
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word

# =============================================================================
# COMPLETION SYSTEM
# =============================================================================
if [[ -o interactive ]]; then
  autoload -U bashcompinit && bashcompinit
  autoload -Uz compinit
  zmodload zsh/complist
  mkdir -p ~/.zsh/cache

  if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
      compinit
  else
      compinit -C
  fi

  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*' rehash true
  zstyle ':completion:*' accept-exact '*(N)'
  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path ~/.zsh/cache

  # KUBERNETES COMPLETIONS
  if command -v kubectl > /dev/null 2>&1; then
      source <(kubectl completion zsh)
  fi

  if command -v helm > /dev/null 2>&1; then
      source <(helm completion zsh)
  fi
fi

# =============================================================================
# ALIASES
# =============================================================================

# System aliases
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias c='code .'
alias t='trae .'
alias o='xdg-open .'
alias q='exit'
alias kt='kubetail'
alias kl='kubectl logs'
alias klf='kubectl logs -f'

alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply --auto-approve'

# Kubernetes aliases
if command -v kubectl > /dev/null 2>&1; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kdel='kubectl delete'
    alias kaf='kubectl apply -f'
    alias kex='kubectl exec'
    alias kexi='kubectl exec -ti'
    alias ktp='kubectl top pod'
    alias ktn='kubectl top node'
    
    # GET
    alias kgp='kubectl get pods -o wide'
    alias kgsvc='kubectl get services'
    alias kgsts='kubectl get statefulsets'
    alias kgd='kubectl get deployments'
    alias kgrs='kubectl get replicasets'
    alias kgi='kubectl get ingress'
    alias kgn='kubectl get nodes -o wide'
    alias kgns='kubectl get namespaces'
    alias kgpv='kubectl get pv'
    alias kgpvc='kubectl get pvc'
    alias kgcm='kubectl get configmaps'
    alias kgsec='kubectl get secrets'
    alias kgsa='kubectl get sa'
    alias kgcert='kubectl get certificates'
    alias kgj='kubectl get jobs'
    alias kgcj='kubectl get cronjobs'
    
    # DESCRIBE
    alias kdp='kubectl describe pods'
    alias kdsvc='kubectl describe services'
    alias kdsts='kubectl describe statefulsets'
    alias kdd='kubectl describe deployments'
    alias kdrs='kubectl describe replicasets'
    alias kdi='kubectl describe ingress'
    alias kdn='kubectl describe nodes'
    alias kdpv='kubectl describe pv'
    alias kdpvc='kubectl describe pvc'
    alias kdcm='kubectl describe configmaps'
    alias kdcert='kubectl describe certificates'
    alias kdj='kubectl describe jobs'
    alias kdcj='kubectl describe cronjobs'
    
    # EDIT
    alias kecm='kubectl edit configmap'
    alias kesec='kubectl edit secret'
    alias ked='kubectl edit deployment'
    alias kei='kubectl edit ingress'
    alias kecert='kubectl edit certificates'
    alias kepv='kubectl edit pv'
    alias kepvc='kubectl edit pvc'
    alias kesvc='kubectl edit service'
    alias kests='kubectl edit statefulset'
    alias keditj='kubectl edit job'
    alias keditcj='kubectl edit cronjob'
    
    # DELETE
    alias kdelp='kubectl delete pod'
    alias kdelsvc='kubectl delete service'
    alias kdeld='kubectl delete deployment'
    alias kdelrs='kubectl delete replicasets'
    alias kdeli='kubectl delete ingress'
    alias kdelpv='kubectl delete pv'
    alias kdelpvc='kubectl delete pvc'
    alias kdelcm='kubectl delete configmaps'
    alias kdelj='kubectl delete job'
    alias kdelcj='kubectl delete cronjob'
    alias kdelcert='kubectl delete certificates'
    alias kdelsec='kubectl delete secrets'
    alias kdelns='kubectl delete namespace'
fi

# KUBECONFIG setup
[[ -f "$HOME/.kube/config" ]] && export KUBECONFIG="$HOME/.kube/config"

# Context aliases
[[ -f "$HOME/.kube/config" ]] && alias khome="export KUBECONFIG=$HOME/.kube/config"
[[ -f "$HOME/.kube/config" ]] && alias kh="export KUBECONFIG=$HOME/.kube/config"
[[ -f "$HOME/.kube/lux-capsule.config" ]] && alias klux="export KUBECONFIG=$HOME/.kube/lux-capsule.config"
[[ -f "$HOME/.kube/ams-web-capsule.config" ]] && alias kams="export KUBECONFIG=$HOME/.kube/ams-web-capsule.config"

# =============================================================================
# PATH CONFIGURATION
# =============================================================================

path_append() { [[ ":$PATH:" != *":$1:"* ]] && export PATH="$PATH:$1"; }
path_prepend() { [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"; }

export BUN_INSTALL="$HOME/.bun"
[[ -d "$HOME/.local/bin" ]] && path_prepend "$HOME/.local/bin"
[[ -d "$HOME/bin" ]] && path_prepend "$HOME/bin"
[[ -d "$BUN_INSTALL/bin" ]] && path_prepend "$BUN_INSTALL/bin"
[[ -d "${KREW_ROOT:-$HOME/.krew}/bin" ]] && path_append "${KREW_ROOT:-$HOME/.krew}/bin"

# =============================================================================
# EXTERNAL TOOLS CONFIGURATION
# =============================================================================

if [[ -o interactive ]]; then
  # ZSH Autosuggestions
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

  # ZSH Syntax Highlighting
  [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # ZSH History Substring Search
  [[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # FZF configuration
  if command -v fzf > /dev/null 2>&1; then
    source <(fzf --zsh)
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
    if command -v fd > /dev/null 2>&1; then
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
  fi

  # Zoxide - smarter cd
  command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"

  # Additional completions
  [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
fi

# =============================================================================
# POWERLEVEL10K THEME — загружаем ПОСЛЕ всех плагинов
# =============================================================================

# Выберите нужное в зависимости от метода установки:
[[ -r ~/powerlevel10k/powerlevel10k.zsh-theme ]] && \
  source ~/powerlevel10k/powerlevel10k.zsh-theme

# Загрузить конфигурацию p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# SENSITIVE CONFIGURATION
# =============================================================================

[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

export VAULT_ADDR='https://vault.vaka.work'

if command -v vault > /dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$(which vault)" vault
fi
