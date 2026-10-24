local sq              = require "lsqlite3"

local print_help_page = require "help_page"
local db_funcs        = require "db_funcs"

if #arg < 1 then
    print_help_page()
    os.exit(1)
end

if arg[1] == "init" then
    if #arg ~= 2 then
        print_help_page()
        os.exit(1)
    end

    local db = sq.open(arg[2])

    db_funcs.init_db(db)

else
    print_help_page()
    os.exit(1)
end

