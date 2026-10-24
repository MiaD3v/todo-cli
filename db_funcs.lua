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

function add_entry(db, arg)
    local prep = db:prepare([[
    INSERT INTO todos(desc, _when, priority) 
    VALUES (?,?,?);]])
    prep:bind_values(arg[3],arg[4],arg[5])
    prep:step()
    local success = prep:finalize()
    if success ~= sq.OK then
        error("Failed to add entry! " .. success)
    end
end
ret.add_entry = add_entry

function print_todos(db)
    local todos = _get_todos(db);
    for _, td in pairs(_get_todos(db)) do
        print("id: " .. td.id ..
              " description: \"" .. td.desc ..
              "\" when: \"" .. td.when ..
              "\" priority: ", td.priority)
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
