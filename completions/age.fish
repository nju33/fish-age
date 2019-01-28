# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

complete -c age -l major -d 'print next major version'
complete -c age -l minor -d 'print next minor version'
complete -c age -l patch -d 'print next patch version'