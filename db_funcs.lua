local sq = require "lsqlite3"
local ret = {}

function init_db(db)
    local success = db:exec[[
    CREATE TABLE todos(
        id INTEGER PRIMARY KEY,
        desc TEXT,
        _when TEXT,
        priority INT
    );
    ]]
    if success ~= sq.OK then
        error("Failed to create db!")
    end
end
ret.init_db = init_db

function print_todos(db)
    for _, td in pairs(_get_todos(db)) do
        print(td.id)
        print(td.desc)
        print(td.when)
        print(td.priority)
    end
end
ret.print_todos = print_todos

function _get_todos(db)
    local out = {}
    for id, desc, when, priority in
        db:urows("SELECT id, desc, _when, priority FROM todos;") do
        table.insert(out, {
            id = id,
            desc = desc,
            when = when,
            priority = priority,
        })
    end
    return out
end

return ret
