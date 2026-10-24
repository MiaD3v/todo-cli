local sq = require "lsqlite3"
local ret = {}

function init_db(db)
    local success = db:exec[[
    CREATE TABLE todos(
        id INT PRIMARY KEY,
        desc TEXT,
        _when TEXT,
        priority INT
    );
    ]]
    if success ~= sq.OK then
        error("failed to create db")
    end
end
ret.init_db = init_db

return ret
