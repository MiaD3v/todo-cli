return function()
    help = [[
    todo-cli v0.0.1 - Lightwieght to-do List CLI 
    COMMANDS
        init    initializes a to-do list database
        add     adds a to-do list item to the given database
        show    prints the given database sorted by priortiy
    USAGE
        init DATABASE_NAME
        add DATABASE_NAME DESCRIPTION WHEN PRIORITY
        show DATABASE_NAME
    ]]
    print(help)
end

