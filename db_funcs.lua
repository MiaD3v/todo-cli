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
    local longest_id_len = string.len("ID")
    local longest_desc_len = string.len("Description")
    local longest_when_len = string.len("When")
    local longest_priority_len = string.len("Priority")

    for _, td in pairs(todos) do
        local id_str = tostring(td.id)
        if #id_str > longest_id_len then longest_id_len = #id_str end
        local desc_str = td.desc
        if string.len(desc_str) > longest_desc_len then longest_desc_len = string.len(desc_str) end
        local when_str = td.when
        if when_str:len() > longest_when_len then longest_when_len = when_str:len() end
        local priority_str = tostring(td.priority)
        if #priority_str > longest_priority_len then longest_priority_len = #priority_str end
    end

    local header_len = 1 + longest_id_len + 1 + longest_desc_len + 1 + longest_when_len + 1 + longest_priority_len + 1

    local header_str = _padstr("", header_len, "-")
    header_str = header_str .. "\n|" ..
    _padstr("ID", longest_id_len, " ") .. "|" ..
    _padstr("Description", longest_desc_len, " ") .. "|" ..
    _padstr("When", longest_when_len, " ") .. "|" ..
    _padstr("Priority", longest_priority_len, " ") .. "|\n" ..
    _padstr("", header_len, "-") .. "\n"

    for _, td in pairs(todos) do

        header_str = header_str .. "|" ..
        _padstr(tostring(td.id), longest_id_len, " ") .. "|" ..
        _padstr(td.desc, longest_desc_len, " ") .. "|" ..
        _padstr(td.when, longest_when_len, " ") .. "|" ..
        _padstr(tostring(td.priority), longest_priority_len, " ") .. "|" .. "\n"

    end
    print(longest_when_len)

    print(header_str)

end
ret.print_todos = print_todos

<<<<<<< HEAD

function _get_sorted_todos(db)
=======
function _padstr(str, len, char)

    assert(string.len(char) == 1)

    if string.len(str) > len then return strsub(str, 1, len) end

    if string.len(str) == len then return str end

    for i=string.len(str),len do
        str = str .. char
    end

    return str
end

function _get_todos(db)
>>>>>>> ec89480 (formatting... kind of (not really))
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
    local prep = db:prepare "DELETE FROM todos WHERE id = ?NNN;"
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
