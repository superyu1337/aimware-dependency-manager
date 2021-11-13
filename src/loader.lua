local fWrite = file.Write;
local fRead = file.Read;
local httpGet = http.Get;

return function(dependency_name, version, verbose)
    local path = '.cache/adm/' .. dependency_name .. '/' .. version .. '/load.lua';
    local link = 'https://raw.githubusercontent.com/superyu1337/aimware-dependency-manager/main/files/' .. dependency_name .. '/' .. version .. '/load.lua';

    if not pcall(fRead, path) then
        local content = httpGet(link);
        if content == '404: Not Found' then
            error('Unrecoverable Error - Could not find dependency "' .. dependency_name .. '" with version "' .. version .. '" on the server!')
        else
            if verbose then print('Downloaded and cached dependency "' .. dependency_name .. '" with version "' .. version .. '".') end
            fWrite(path, content);
            return load(content, dependency_name .. " v" .. version)();
        end
    else
        if verbose then print('Found cached dependency "' .. dependency_name .. '" with version "' .. version .. '".') end
        local content = fRead(path);
        return load(content, dependency_name .. " v" .. version)();
    end
end