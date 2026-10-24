local sq              = require "lsqlite3"
local print_help_page = require "help_page"
local db_funcs        = require "db_funcs"

if #arg < 1 then
    print_help_page()
    os.exit(1)
end

if arg[1] == "add" then
    if #arg ~= 5 then
        print_help_page()
        os.exit(1)
    end

    local db = sq.open(arg[2])

    db_funcs.add_entry(db, arg)
end

if arg[1] == "init" then

    if #arg ~= 2 then
        print_help_page()
        os.exit(1)
    end

    local db = sq.open(arg[2])

    db_funcs.init_db(db)

elseif arg[1] == "show" then

    if #arg ~= 2 then
        print_help_page()
        os.exit(1)
    end

    local db = sq.open(arg[2])
    db_funcs.print_todos(db)

else
    print_help_page()
    os.exit(1)
end

