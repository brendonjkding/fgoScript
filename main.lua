UI = {
    { 'DropList{狂兰|阿塔}', 'dashou', '选择打手' }
}
dofile("/var/touchelf/scripts/lib_fgo.lua")




function main()
    if dashou=="狂兰" then
        dofile("/var/touchelf/scripts/lib_ber.lua")
    elseif dashou=="阿塔" then
        dofile("/var/touchelf/scripts/lib_ata.lua")
    end
    
    is_debug=false
    need_skip=false

    init()
    init2()

    shuffled=false

    --1t 2t
    buff(is_debug,need_skip)

    --3t
    buff_3t(delay_1,is_debug)---等待时间

    --4t...
    buff_4t(delay_2,is_debug)


    if not is_debug then
        quit_battle()
        notifyMessage("制作：面包")
    end  

end