function __fd2_define_subcommand -d "create a command prefix impl"
    set -l command_name ''
    set -l function_name ''
    set -l prefix ''
    set -l desc ''

    getopts $argv | while read -l key value
        switch $key
            case p prefix
                set prefix_name $value
            case c command_name
                set command_name $value
            case f function_name
                set function_name $value
            case d desc
                set summary $value
        end
    end

    if test -z $prefix_name
      error "prefix must be set (use the -p option)" >&2
      return 1
    end

    if test -z $summary
      error "description must be set (use the -d option)" >&2
      return 1
    end

    if test -z $function_name
      error "function name must be set (use the -f option)" >&2
      return 1
    end

    if test -z $command_name
      error "command name must be set (use the -c option)" >&2
      return 1
    end

    # erase definitions for event and summary
    eval "set -e _subcommand_function_"$prefix_name"_"$command_name
    eval "set -e _subcommand_summary_"$prefix_name"_"$command_name

    set -l x "_subcommand_names_$prefix_name"
    eval "set -U $x \$$x $command_name"
    eval "set -U _subcommand_function_"$prefix_name"_"$command_name" '$function_name'"
    eval "set -U _subcommand_summary_"$prefix_name"_"$command_name" '$summary'"
end
