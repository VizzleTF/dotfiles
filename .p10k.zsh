# Powerlevel10k config - converted from starship.toml
# Layout: OS  user host  path  git  -  kube  - time
#         ❯ (command input here)

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # === PROMPT ELEMENTS ===
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context
    dir
    vcs
    kubecontext
    time
    newline
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # === GENERAL ===
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%240F╭─'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%240F├─'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%240F╰─'
  # === SEPARATORS ===
  # Rounded style:  at start,  between and at end

  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B4'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B4'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B4'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B4'
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'

  # prompt_char should not have segment decorations
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=

  # === CONTEXT (user@hostname) ===
  # starship: user + space + hostname, bg:#5e5e5e, fg:#eeeeee
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=255
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=240
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=220
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=240

  # Always show (not just SSH) - use content expansion for full control
  typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_CONTENT_EXPANSION='%n %m'
  typeset -g POWERLEVEL9K_CONTEXT_SUDO_CONTENT_EXPANSION='%n %m'
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_CONTENT_EXPANSION='%n %m'
  typeset -g POWERLEVEL9K_CONTEXT_REMOTE_CONTENT_EXPANSION='%n %m'
  typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_CONTENT_EXPANSION='%n %m'

  # No icon for context
  typeset -g POWERLEVEL9K_CONTEXT_VISUAL_IDENTIFIER_EXPANSION=''
  typeset -g POWERLEVEL9K_CONTEXT_PREFIX=''

  # === DIRECTORY ===
  # starship: bg:#555555, fg:#dddddd, 3 levels, …/
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=253
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=239
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='…/'
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=0

  # Same colors for all dir types
  local dir_fg=253 dir_bg=239
  typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND=$dir_fg
  typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND=$dir_bg
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$dir_fg
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$dir_bg
  typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$dir_fg
  typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$dir_bg
  typeset -g POWERLEVEL9K_DIR_ETC_FOREGROUND=$dir_fg
  typeset -g POWERLEVEL9K_DIR_ETC_BACKGROUND=$dir_bg

  # === VCS / GIT ===
  # starship: bg:#4a4a4a, fg:#cccccc
  local vcs_bg=238 vcs_fg=252
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$vcs_bg
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$vcs_fg
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$vcs_bg
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$vcs_fg
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$vcs_bg
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$vcs_fg
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=$vcs_bg
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=$vcs_fg
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=$vcs_bg
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$vcs_fg

  # === KUBECONTEXT ===
  # starship: bg:#3f3f3f, fg:#bbbbbb, icon 󱃾
  # Always show kubernetes context
  typeset -g POWERLEVEL9K_KUBECONTEXT_BACKGROUND=237
  typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND=250
  # Don't hide based on command - always show
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_DEFAULT=true

  # Custom kubeconfig names like starship
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
    '*ams-web-capsule*'     AMS_WEB
    '*ams-svc-capsule*'     AMS_SVC
    '*lux-capsule*'         LUX
    '*'                     DEFAULT
  )

  # Show config:namespace, hide if namespace is default or empty
  typeset -g POWERLEVEL9K_KUBECONTEXT_AMS_WEB_CONTENT_EXPANSION='ams-web${${P9K_KUBECONTEXT_NAMESPACE:+:$P9K_KUBECONTEXT_NAMESPACE}:#:default}'
  typeset -g POWERLEVEL9K_KUBECONTEXT_AMS_SVC_CONTENT_EXPANSION='ams-svc${${P9K_KUBECONTEXT_NAMESPACE:+:$P9K_KUBECONTEXT_NAMESPACE}:#:default}'
  typeset -g POWERLEVEL9K_KUBECONTEXT_LUX_CONTENT_EXPANSION='lux${${P9K_KUBECONTEXT_NAMESPACE:+:$P9K_KUBECONTEXT_NAMESPACE}:#:default}'
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION='${P9K_KUBECONTEXT_NAME}${${P9K_KUBECONTEXT_NAMESPACE:+:$P9K_KUBECONTEXT_NAMESPACE}:#:default}'

  # === TIME ===
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION='-'
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=250
  typeset -g POWERLEVEL9K_TIME_LEFT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_TIME_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=


  # If p10k is already loaded, reload configuration.
  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
