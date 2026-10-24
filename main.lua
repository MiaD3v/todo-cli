local sq = require("lsqlite3")
local print_help_page = require("help_page")

g_db = sq.open("todos.db")

if #arg < 1 then
    print_help_page()
else
    if arg[1] == "init" then
        if #arg ~= 2 then
            print_help_page()
        end
    else
        print_help_page()
    end
end

