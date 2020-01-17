function autoupdate()
    local path="https://raw.githubusercontent.com/brendonjkding/fgo_lua_test/master/scripts/"
    data = httpGet(path.."lib_fgo.lua")
    file=io.open("/var/touchelf/scripts/lib_fgo.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
    
    data = httpGet(path.."main.lua")
    file=io.open("/var/touchelf/scripts/main.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
    
    data = httpGet(path.."maru.lua")
    file=io.open("/var/touchelf/scripts/maru.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
end




