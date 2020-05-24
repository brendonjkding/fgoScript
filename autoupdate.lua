function autoupdate()
    if ios then path="/var/touchelf/scripts/"
    else path="/mnt/sdcard/touchelf/scripts/" end
    local path_r="https://raw.githubusercontent.com/brendonjkding/fgoScript/master/scripts/"
    filenames={"lib_fgo.lua","main.lua","maru.lua"}

    for i=1,#filenames do
        data = httpGet(path_r..filenames[i])
        file=io.open(path..filenames[i],"w")
        io.output(file)
        io.write(data)
        io.close(file)
    end

end




