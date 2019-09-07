UI = {
    { 'TextView{记得换好队伍哦！}' },
    { 'DropList{通用|狂兰|阿塔}', 'dashou', '选择打手以识别：' },
    { 'DropList{擦汗|午餐}', 'mc', '礼装选择：' },
    { 'DropList{孔明|cba|梅林}', 'sp', '助战选择：' },
    { 'InputBox{2}',             'times',    '打本次数：' },
    { 'DropList{手动|狂兰|阿塔}', 'skill_mode', '选择技能模式：' },
    { 'TextView{ }' },
    { 'TextView{手动模式请填写以下信息}' },
    { 'TextView{释放的技能：从者1-9，御主10-}' },
    { 'TextView{12，对象为abc，空格隔开。}' },
    { 'TextView{示例：9 8 7b 1}' },
    { 'InputBox{}',             'skill_serial_1',    '1t技能：' },
    { 'InputBox{}',             'skill_serial_2',    '2t技能：' },
    { 'InputBox{}',             'skill_serial_3',    '3t技能：' },
    { 'TextView{选择释放的宝具}' },
    { 'DropList{1|2|3}', 'np_index_1','1t宝具：'},
    { 'DropList{1|2|3}', 'np_index_2','2t宝具：'},
    { 'DropList{1|2|3}', 'np_index_3','3t宝具：'},
    { 'DropList{1|2|3}', 'big_enemy', '三面高血量敌人序号(1-3)：' },
    { 'DropList{绿卡|红卡}', 'mode_', '队伍性质：' },
    { 'DropList{否|是|}', 'shuffle_cloth', '是否洗牌衣服：' },
    { 'TextView{记得换好队伍哦！}' }
    
    
    
    
}
dofile("/var/touchelf/scripts/lib_fgo.lua")




function main()
    --[[
    dashou="通用"
    skill_mode="手动"

    ]]--

    init()

    if dashou=="狂兰" then
        color_points={ 0x181830, 6, -5, 0x504477, 13, -11, 0xFD0051, 25, -13, 0x444477, 20, -22, 0xF9004C }
    elseif dashou=="阿塔" then
        color_points={ 0xFEEDCB, -2, 10, 0xFEECD5, 8, 4, 0x339D00, 19, -1, 0xE3D9B7, 20, 17, 0x1F7A5D }

    end

    if skill_mode=="狂兰" then
        init_ber()
    elseif skill_mode=="阿塔" then
        init_ata()
    else
        --[[
        
        skill_serial_1="1 7"--9 8 7b 1
        skill_serial_2="2 8"--2
        skill_serial_3="4 5 6 9b 11b"--4 5
        np_index_1="1"
        np_index_2="1"
        np_index_3="2"
        big_enemy="2"
        mode_="红卡"
        shuffled_="否"
        ]]--

    end
    init_m()



    is_debug=false
    need_skip=false


    --init2()

    --
    times=tonumber(times)
    for ii=1,times do
        enter_mission()

        --1t 2t
        buff(is_debug,need_skip)

        --3t
        buff_3t(is_debug)

        --4t...
        buff_4t(is_debug)


        if not is_debug then
            quit_battle()
            notifyMessage("制作：面包")
        end  
        wait_exit_mission()
    end
end