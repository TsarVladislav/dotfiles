if status is-interactive
    set -U fish_greeting
    set -g fish_prompt_pwd_dir_length 3
end

function fish_prompt
    echo -n [
    set_color green; echo -n "$USER "
    set_color cyan; echo -n (prompt_pwd)
    set_color normal; echo -n "]\$ "
end
