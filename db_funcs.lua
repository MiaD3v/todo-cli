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
    local todos = _get_sorted_todos(db);
    for _, td in pairs(_get_sorted_todos(db)) do
        print("id: " .. td.id ..
              " description: \"" .. td.desc ..
              "\" when: \"" .. td.when ..
              "\" priority: ", td.priority)
    end
end
ret.print_todos = print_todos


function _get_sorted_todos(db)
    local out = {}
    for id, desc, when, priority in
        db:urows("SELECT id, desc, _when, priority FROM todos ORDER BY priority DESC;") do
        table.insert(out,
        {
            id = id,
            desc = desc,
            when = when,
            priority = priority,
        })
    end
    return out
end

function remove_todo(db, id)
    local prep = db:prepare "DELETE FROM todos WHERE id = ?;"
    local success = true;
    if not pcall(function()
        prep:bind_values(id)
        prep:step()
    end) then
        success = false
    end
    if prep:finalize() ~= sq.OK then
        success = false
    end

    if not success then
        error("Failed to delete todo from from the database!")
    end

end
ret.remove_todo = remove_todo

return ret
