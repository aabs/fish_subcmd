function __fd2_define_command_completion -a prefix description
    set -l prefix ''
    set -l description ''

    echo fd2_define_command $prefix >&2

    getopts $argv | while read -l key value
        switch $key
            case p prefix
                set prefix $value
            case d desc
                set description $value
        end
    end
    if test -z $prefix
      echo "prefix must be set (use the -p option)" >&2
      return 1
    end
    if test -z $description
      echo "description must be set (use the -d option)" >&2
      return 1
    end

    complete -x -c "$prefix" -d "$description"
end
