function autoupdate()
    data = httpGet("https://raw.githubusercontent.com/brendonjkding/fgo_lua_test/master/lib_fgo.lua")
    file=io.open("/var/touchelf/scripts/lib_fgo.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
    
    data = httpGet("https://raw.githubusercontent.com/brendonjkding/fgo_lua_test/master/main.lua")
    file=io.open("/var/touchelf/scripts/main.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
    
    data = httpGet("https://raw.githubusercontent.com/brendonjkding/fgo_lua_test/master/UPDATE.md")
    file=io.open("/var/touchelf/scripts/更新内容.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
    
    data = httpGet("https://raw.githubusercontent.com/brendonjkding/fgo_lua_test/master/maru.lua")
    file=io.open("/var/touchelf/scripts/maru.lua","w")
    io.output(file)
    io.write(data)
    io.close(file)
end




