UI = {
    { 'DropList{狂兰|阿塔|手动}', 'dashou', '选择打手' },
    { 'TextView{填写释放的技能：从者1-9，御主10-}' },
    { 'TextView{12，对象为abc，空格隔开。}' },
    { 'TextView{示例：9 8 7b 1}' },
    { 'InputBox{}',             'skill_serial_1',    '1t技能：' },
    { 'InputBox{}',             'skill_serial_2',    '2t技能：' },
    { 'InputBox{}',             'skill_serial_3',    '3t技能：' },
    { 'TextView{填写释放的宝具，范围1-3。示例：1}' },
    { 'InputBox{}', 'np_index_1','1t宝具'},
    { 'InputBox{}', 'np_index_2','2t宝具'},
    { 'InputBox{}', 'np_index_3','3t宝具'},
    { 'DropList{1|2|3}', 'big_enemy', '三面高血量敌人序号(1-3)' },
}
dofile("/var/touchelf/scripts/lib_fgo.lua")




function main()
    --[[
    skill_serial_1="9 8 7b 1"
    skill_serial_2="2"
    skill_serial_3="4 5"
    np_index_1="1"
    np_index_2="1"
    np_index_3="2"
    big_enemy="1"
    
    dashou="狂兰"
    ]]--
    
    init()
    
    if dashou=="狂兰" then
        dofile("/var/touchelf/scripts/lib_ber.lua")
    elseif dashou=="阿塔" then
        dofile("/var/touchelf/scripts/lib_ata.lua")
    else
        init_m()
        buff_manual()
        return
    end
    
    is_debug=false
    need_skip=false

    
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