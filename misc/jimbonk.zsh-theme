PROMPT='$FG[010]%t %W $FG[006]%n:%B$(get_pwd)%b $FG[111]$(git_prompt_info)
$reset_color> '

ZSH_THEME_GIT_PROMPT_PREFIX="-- branch: %B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b$FG[111]"

function get_pwd() { echo "${PWD/$HOME/~}" }
