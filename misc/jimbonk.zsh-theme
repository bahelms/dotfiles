PROMPT='$FG[010]%t %W $FG[006]%n:$(get_pwd) $FG[111]$(git_prompt_info)
$reset_color> '

ZSH_THEME_GIT_PROMPT_PREFIX="-- git:("

function get_pwd() { echo "${PWD/$HOME/~}" }
