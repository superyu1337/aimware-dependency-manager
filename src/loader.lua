local fWrite = file.Write;
local fRead = file.Read;
local httpGet = http.Get;

file.Read = function(path)
    fRead(path)
end

return function(dependency_name, version, verbose)
    local path = '.cache/dependencies/' .. dependency_name .. '/' .. version .. '/load.lua';
    local link = 'https://raw.githubusercontent.com/superyu1337/aw-scripts/main/files/' .. dependency_name .. '/' .. version .. '/load.lua';

    if not pcall(file.Read, path) then
        local content = httpGet(link);
        if content == '404: Not Found' then
            error('Unrecoverable Error - Could not find dependency "' .. dependency_name .. '" with version "' .. version .. '" on the server!')
        else
            if verbose then print('Downloaded and cached dependency "' .. dependency_name .. '" with version "' .. version .. '".') end
            local c = file.Open(path, 'r'):Read();
            return loadstring(c)();
        end
    else
        if verbose then print('Found cached dependency "' .. dependency_name .. '" with version "' .. version .. '".') end
        local c = file.Open(path, 'r'):Read();
        return loadstring(c)();
    end
end