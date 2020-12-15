--[[
    -------------------------------------------------------------------
    初始化数据类函数
    -------------------------------------------------------------------
]]--
function init(d)
    init_arg()
    init_points()
    init_ob()
    init_input_info()

    --Debug
    current_round=1
    logDebug("------------------------------------------------------------")
    is_debug=d

    check_miss_operate(message)

    save_conf()
    if is_debug and ios then
        local oc = require "liboc"
        NSLog=oc.NSLog
    else
        NSLog=function ()end
    end
end
function init_arg()
    VERSION=153
    -- 适用屏幕参数
    SCREEN_RESOLUTION="750x1334";
    SCREEN_COLOR_BITS=32;
    rotateScreen(0);
    

    kernelVersion=io.popen("uname -s")
    kernelVersion=kernelVersion:read("*all")
    if kernelVersion=="Darwin\n" then ios=true
    else ios=false end
    
    if ios then
        path="/var/touchelf/scripts/"
    else
        path="/mnt/sdcard/touchelf/scripts/"
        if not toast then toast=notifyMessage end
    end

end
function getNumVersion(version)
    return tonumber(string.sub(version, 1, 1)..string.sub(version, 3,3)..string.sub(version, 5,5))
end

function init_conf()
    file=io.open(path..conf_name..".lua","r")
    io.input(file)
    text=io.read("*a")
    if text=="" then
        notifyMessage("文件名有误",3000)
        os.exit()
    end
    dofile(path..conf_name..".lua")
    io.close(file)
    line=Split(text,'\n')
    for i=1,#line do
        if string.sub(line[i],1,1)=='-' then
            conf_name=string.sub(line[i],3)
            break
        end
    end
end
function save_conf()
    if is_debug then return end

    t=[[sp_mode="%s"--助战
mc="%s"--礼装
sp="%s"--从者
skill_serial_1="%s"--1t技能
skill_serial_2="%s"--2t技能
skill_serial_3="%s"--3t技能
np_index_1="%s"--1t宝具
np_index_2="%s"--2t宝具
np_index_3="%s"--3t宝具

big_enemy_1="%s"--一面大怪
big_enemy_mode_1="%s"

big_enemy_2="%s"--二面大怪
big_enemy_mode_2="%s"

big_enemy_3="%s"--三面大怪
mode="%s"--队伍
shuffle_cloth="%s"--洗牌服
round_2_shuffle="%s"--二面是否洗牌
party_index="%s"--队伍序号
sp_class_index="%s"--助战职介
after_failed="%s"--如失败
always_np="%s"--
conf_name="%s"--文件名
skill_mode="自定义"--队伍信息
--%s

UI = {
    { 'InputBox{1}',             'times',    '打本次数：' },
    { 'DropList{不吃|金|银|铜|彩}',             'apple',    '吃苹果：' },
    { 'DropList{否|是}',             'sleep_button',    '完成后锁屏(需安装activator)' }
}
dofile("%slib_fgo.lua")

function main()
    init()
    
    for i=1,times do
        start_one_mission(i)
    end
    
    if sleep_button=="是" then
        os.execute("activator send libactivator.system.sleepbutton")
        return
    end
    
    
    notifyMessage("感谢使用")
    notifyVibrate(3000)
end
]]


    t=string.format(t,sp_mode,mc,sp,
        skill_serial_1,skill_serial_2,skill_serial_3,
        np_index_1,np_index_2,np_index_3,
        big_enemy_1,big_enemy_mode_1,
        big_enemy_2,big_enemy_mode_2,big_enemy_3,
        mode,shuffle_cloth,round_2_shuffle,
        party_index,sp_class_index,after_failed,always_np,
        conf_name,conf_name,path)

    file=io.open(path..conf_name..".lua","w")
    io.output(file)
    io.write(t)
    io.close(file)

end
function init_input_info()
    if dashou=="狂兰" then color_points={ 0x181830, 6, -5, 0x504477, 13, -11, 0xFD0051, 25, -13, 0x444477, 20, -22, 0xF9004C }
    elseif dashou=="阿塔" then color_points={ 0xFEEDCB, -2, 10, 0xFEECD5, 8, 4, 0x339D00, 19, -1, 0xE3D9B7, 20, 17, 0x1F7A5D }
    else dashou="通用" end
    if mode=="XJBD" then mode="红卡" end

    --初始化队伍信息
    local _=skill_mode=="从文件导入" and init_conf()



    mode=(mode_ and {mode_} or {mode})[1]

    --输入信息处理
    skills={}
    skills[1]=Split(skill_serial_1," ")
    skills[2]=Split(skill_serial_2," ")
    skills[3]=Split(skill_serial_3," ")
    np_indexs={}
    np_indexs[1]=tonumber(np_index_1)+5
    np_indexs[2]=tonumber(np_index_2)+5
    if np_index_3~="2+1" then
        np_indexs[3]=tonumber(np_index_3)+5 
    end
    

    big_enemy={big_enemy_1,big_enemy_2,big_enemy_3}
    big_enemy_mode={big_enemy_mode_1,big_enemy_mode_2,"后补刀"}

    times=tonumber(times)
    party_index=party_index or "当前"
    sp_class_index=sp_class_index or "当前"
    after_failed=after_failed or "停止"
    round_2_shuffle=round_2_shuffle or "否"
    always_np=always_np or "否"
    after_drop_mc=after_drop_mc or "继续"
    conf_name=(conf_name=="" and {"默认"} or {conf_name})[1]
    shuffled=(shuffle_cloth=="是" and {false} or {true})[1]
    check_miss_operate_points=(sp_mode=="手动" and {{attack_points}} or {menu_points})[1]
    message=(sp_mode=="手动" and {"请进入副本再启动"} or {"请把关卡放在第一个再启动"})[1]
end

--卡对象
function init_ob()
    Card={index=0,priority=0,used=false,is_dashou=true,counter=false,weak=false,color=false,priority_bak=false,test=1}
    Card.__index=Card 
    Card.__lt=function(a,b)return a.priority>b.priority end
    function Card:new(i,p)
        local self={}
        setmetatable(self, Card)
        self.index=i
        self.priority=p
        return self
    end
end
function init_points()
    --一、开始战斗
    menu_points={}
    menu_points[1]={{ 0xE8C17B, 18, 0, 0xFBF8F4, 17, -6, 0xF5E9DC, 17, 8, 0xF7E7D3, 26, 8, 0xF0EDA0, 27, 1005, 0xD6D6D8, 29, 1129, 0xD0D2D3 }, 90, 9, 166, 38, 1301}
    menu_points[2]={{ 0xD6D6D6, 0, -18, 0x10172D, -1, -25, 0xAEB6C3, -1, -29, 0x192245, -1, -34, 0xAEB6C7, -1, -47, 0xCFD2D6, 19, -1029, 0xD4D5D5 }, 90, 36, 257, 56, 1286}
    menu_points[3]={{ 0xD0D4D4, -7, -116, 0xDADBDB, 30, -64, 0x40AEE7, -5, -1139, 0xE8DBA2, -12, -1132, 0xF2F1E6, -22, -1134, 0xD0A36A, -20, -1126, 0xEFDA93 }, 90, 16, 159, 68, 1298}

    mission_entry={563,999}
    apple_x={["彩"]=574,["金"]=418,["银"]=290}
    apple_y=700
    apple_scroll_slot_end={174,1058}
    apple_window_points={{ 0xF3F4F7, -34, 0, 0xEFF2F6, -70, 0, 0xE8ECEF, -133, -6, 0xEAEFEF, -166, -6, 0xE6E9EF, -217, 2, 0xDFE5ED, -259, 2, 0xE8ECF4, -325, 2, 0xEDF3FB, -518, -305, 0xD5D6D9, -513, -341, 0xD2D2D2 }, 90, 95, 717, 613, 1060}
    close_apple_button={100,678}
    affirm_apple_button={165,863}

    start_mission_button={39,1240}
    start_mission_points={{ 0x08BBE8, -23, -9, 0x007AD5, -20, -52, 0x05387C, -2, -188, 0x0F99C0, -9, -111, 0xD2D9DE }, 90, 2, 1139, 25, 1327}

    --助战
    sp_interface_points={{ 0x00609A, -23, -4, 0x3E70B1, -17, 6, 0xEEF1FB, -16, 12, 0x133B6A, -16, 26, 0x0066F2 }, 90, 609, 14, 632, 44}

    sp_class_button_x=616
    sp_class_button_y={["全"]=94,["剑"]=164,["弓"]=234,["枪"]=304,["骑"]=374,
        ["术"]=444,["杀"]=514,["狂"]=584,["EXT"]=654,["MIX"]=724}

    refresh_button={612,881}
    refresh_confirm_button={162,870}
    scroll_bar_arrived_end_points={{ 0xF5E4C3 }, 90, 14, 1291, 14, 1291}
    scroll_bar_slot_points={{ 0x56656D }, 80, 11, 1292, 17, 1292}
    refresh_too_fast_warning={{ 0xEDEEEA, 43, -2, 0xEFEFEF }, 90, 138, 666, 181, 668}
    refresh_warning_close_button={171,673}
    refresh_button={612,881}
    refresh_confirm_button={162,870}
    support_slot={{452,137}}

    --助战礼装特征
    mc_points={}
    mc_points["午餐"]={ 0x67B180, -27, 4, 0xEFEBE2, -7, 64, 0xF3C8BC, -23, 98, 0x493438, 3, 138, 0x67AF82, -6, 131, 0xA0D898, -24, 138, 0xFBFC84, -32, 137, 0xB1F3D5, -26, 141, 0xF5F9BB }
    mc_points["擦汗"]={ 0x7EA75B, 20, -7, 0xF2ECCF, 29, 24, 0xF5D9D8, 22, 61, 0x9A6ACB, 27, 77, 0xCDA49A, 30, 109, 0x597027, 2, 120, 0xA2C24F, 3, 124, 0xEBF1B2, 7, 120, 0xF9FA44 }
    mc_points["qp"]={ 0xBF8E69, 21, 10, 0x435DCB, 2, 44, 0x283B56, 10, 69, 0xF9D9A1, 9, 94, 0x1A1F2B, 3, 131, 0xFDFB5C, -1, 132, 0xB8D55E, 22, 115, 0xD3EEFA }
    mc_points["所长"]={ 0x5F362F, 5, 18, 0xD9A879, 7, 32, 0x63132D, 11, 43, 0x906F5F, 11, 69, 0xF9DEB7, -3, 97, 0xFBCCC5, 18, 125, 0x4E110E, 18, 142, 0xEBAD59, 7, 138, 0xF9F824 }
    mc_points["新所长"]={ 0x372F2F, -19, 12, 0xF1ECE2, -26, 51, 0x89381B, -11, 50, 0x92C37E, -5, 77, 0xFEEEE3, 9, 105, 0x2A2B58, 9, 142, 0x1D3B29, -13, 137, 0xFAFA54, -18, 137, 0xA2C262 }
    --闪闪祭
    mc_points["无限池"]={ 0xF09C9F, 9, 41, 0xFFEBD5, 14, 51, 0x685D96, 14, 78, 0xD7957D, 18, 109, 0x998C8C, 18, 118, 0xB82A2F }
    mc_points["无限池(满破)"]={ 0xF09C9F, 9, 41, 0xFFEBD5, 14, 51, 0x685D96, 14, 78, 0xD7957D, 18, 109, 0x998C8C, 18, 118, 0xB82A2F, -5, 120, 0xFBFC77, -8, 120, 0xC7DA7E, -12, 120, 0xA6E2BA }
    mc_points["新午餐"]={ 0x3888BB, -21, 0, 0xF5F6F4, -5, 13, 0xFBD2D6, 4, 47, 0xFEF3E8, -7, 47, 0xA8749D, -18, 71, 0xFFF2EA, -26, 71, 0xE2B4AD, 1, 85, 0xB9639B, -23, 118, 0xFCFB66, -31, 118, 0xADE1B5 }
    mc_points["新qp"]={ 0x183851, 2, 32, 0xF9FDFD, -13, 51, 0x49343C, -4, 63, 0x698C9F, -19, 74, 0xFBCFBD, 8, 70, 0x8C6A5F, -24, 102, 0x302C26, -12, 114, 0xE8FCFD, 9, 134, 0x928B96, -18, 137, 0xFDFE80, -20, 137, 0xE5F491, -24, 138, 0x94C393 }
    --助战从者特征
    support_points={}
    support_points["孔明"]={ 0xFAF4D6, -6, 4, 0x716256, -3, 15, 0xFBF5D5, -31, 11, 0xDEC4A2, -33, -59, 0xBFEFD6, 36, -15, 0x4C5D59 }
    support_points["梅林"]={ 0x739EE3, 43, 47, 0x6D4B7C, 46, 66, 0xF3D6D9, 54, 81, 0x1D1B68, 41, 104, 0xAEAAE2, 47, 141, 0xFFF0EF }
    support_points["cba"]={ 0xD099F5, 44, -4, 0xDEC9F4, 45, 26, 0x793561, 45, 41, 0xAF0E19, 28, 51, 0xFEFFE1, 45, 86, 0xB10B12 }
    support_points["310cba"]=support_points["cba"]
    support_points["狐狸"]={ 0xB18B34, 2, 26, 0xE28875, 8, 49, 0xF7C268, 8, 70, 0xF6E4C4, 13, 98, 0xF9CD76, 13, 111, 0xD07765, 13, 152, 0xFEFFF2 }
    support_points["花嫁"]={ 0xF4E1A9, 4, 28, 0x171304, -4, 32, 0x83B132, -4, 53, 0xFCF3DB, 12, 74, 0xAFD85A, 18, 74, 0x10170D, 18, 93, 0xF6DC93, 18, 119, 0x957B49, 18, 126, 0xDEE0D7 }
    
    mc_start_x={288,4}
    mc_start_y={23,32}
    mc_end_x={588,292}
    mc_end_y={232,236}

    sp_start_x=4
    sp_start_y=23
    sp_end_x=588
    sp_end_y=232

    sp_start_dx=0
    sp_start_dy=-60
    sp_end_dx=174
    sp_end_dy=155
    cba_skill_points={ 0xFEFFFE, -1, 2, 0xFEFFFE, -9, 3, 0xFEFFFE, -11, 15, 0xFEFFFE, -5, 11, 0xFEFFFE, -3, 19, 0xFEFFFE, 3, 15, 0xFEFFFE }
    cba_skill_start_dx=-70
    cba_skill_start_y=1021
    cba_skill_end_dx=-36
    cba_skill_end_y=1082
    cba_310skill_points={ 0xFFFFFF, 4, 0, 0xFFFFFF, 10, 0, 0xFFFFFF, 9, -2, 0xFFFFFF, 5, 9, 0xFFFFFF, -2, 12, 0xFFFFFF, 5, 16, 0xFFFFFF, 12, 13, 0xFFFFFF, 9, 79, 0xFFFFFF, 9, 81, 0xFFFFFF, 5, 81, 0xFFFFFF, 0, 81, 0xFFFFFF, -1, 94, 0xFFFFFF, 5, 89, 0xFFFFFF, 5, 98, 0xFFFFFF, 12, 93, 0xFFFFFF, 9, 160, 0xFFFFFF, 9, 162, 0xFFFFFF, 5, 162, 0xFFFFFF, 0, 162, 0xFFFFFF, -1, 174, 0xFFFFFF, 5, 170, 0xFFFFFF, 11, 174, 0xFFFFFF, 6, 178, 0xFFFFFF }
    cba_310skill_start_y=858
    cba_310skill_end_y=cba_skill_end_y

    party_x=698
    party_y={549}
    for i=2,10 do
        party_y[i]=party_y[i-1]+26
    end

    previous_button={716, 100}
    small_previous_button={716,46}

    --二、战斗中
    --卡色判断区域
    color_start_x=54
    color_start_y={7}
    color_end_x=265
    color_end_y={284}

    --卡打手信息区域
    feature_start_x=171
    feature_start_y={24}
    feature_end_x=459
    feature_end_y={280}
    feature_extract_x=260
    feature_extract_y={123}
    for i=2,5 do
        color_start_y[i]=color_start_y[i-1]+268
        color_end_y[i]=color_end_y[i-1]+268
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
        feature_extract_y[i]=feature_extract_y[i-1]+268
    end
    --卡信息
    -- blue_color_points={ 0x357FFE, -2, 48, 0x56AFFE, 23, 20, 0xB0834A, 52, 13, 0xFEF9CA, 75, -31, 0x075CFE, 61, 69, 0x55C7FE }
    blue_color_points={ 0x4CA2FD, 1, -63, 0x2576FC, 96, -105, 0x004CE2, 109, 4, 0x0F69FD, 84, -18, 0x4DC9FF, 92, 53, 0x0047DE, 24, 57, 0x0D4EE4 }
    red_color_points={ 0xFE5612, -7, 33, 0xFD6F1A, 2, 71, 0xFF3A1E, 68, 11, 0xFEE13A, 76, 67, 0xFE6B1F }
    --cba、孔明、梅林

    cba_points={0xFEFEE6, -1, -16, 0x985598, -6, -28, 0xFEFEED, -5, -35, 0xDE1616, -10, -42, 0xFEFEED } 
    zhuge_points={ 0xFFCC77, 24, -3, 0x445555, 18, -17, 0xFFEEDD, 15, -26, 0xD5CCBB, 11, -29, 0xFFEEDD }
    merlin_points={ 0xFEFEFE, -12, 11, 0xFEEDDC, -20, 8, 0xE09CA9, -26, 17, 0x32339D, -31, 17, 0xA955CB, -36, 17, 0xFEEDDC, -51, 17, 0xC7B2B2 }
    --nero_bride_points={ 0xDDAA55, -1, 18, 0xFFEEDD, 10, 24, 0xC5E45F, 43, 24, 0xFDE9A8, 49, 22, 0xA2F22A, 57, 10, 0x88DD22, 66, 5, 0xFFEEAA }
    tamamo_points={ 0xA49483, 7, -3, 0xFFEEDD, 18, -1, 0xFFD077, 27, -6, 0x000000, 39, -9, 0xFFFBDC, 44, -24, 0xFE9988, 21, 26, 0xFFCC66 }
    merlin2_points={ 0xEEFDFF, -21, 19, 0xA550C7, -28, 19, 0xFFEEDD, -42, 19, 0xBBAAA2, -45, 19, 0xFFEEDD, -46, 45, 0xBBCCFF, -48, 55, 0xFFC7DD, -41, 64, 0x8888CC, -32, 66, 0xFFEEFF }
    guai_points={cba_points,zhuge_points,merlin_points,tamamo_points,merlin2_points}


    counter_points={ 0xE01E1E, 0, 8, 0xA10000, 0, 20, 0x910000, 5, 18, 0xD80000, 5, 9, 0xE90000, 10, 13, 0xFE5220, 13, 13, 0xFCDD7E }
--    weak_points={ 0x91F0FD, -1, 0, 0x46D4FC, -2, 0, 0x3CC7FA, -3, 0, 0x33B9F8, -4, 0, 0x29AAF5, -5, 0, 0x1F9BF2, -6, 0, 0x168CEF, -7, 0, 0x0D7FEC }
    weak_points={0x62EAFF, 1, 6, 0xA7FAFF, 1, 21, 0x9BF5FF, -2, 23, 0x23A2F5, -1, 15, 0x3AC5FB, -6, 14, 0x0D7DED, -10, 14, 0x0150D4, -12, 13, 0x0141C3}

    --切换敌人坐标
    enemy_x=526
    enemy_y={155,318,483}
    
    enemy_brand_x=707
    enemy_brand_y={40,300,550}
    
    --指令卡选择坐标
    card_x={222,222,222,222,222,542,542,542}--1,2,3,4,5,np
    card_y={150,400,680,940,1200,454,689,951}--266
    --技能坐标
    skill_x={ 150,150,150,
        150,150,150,
        150,150,150,
        425,425,425 }
    skill_y={ 70,170,270,
        400,500,600,
        735,835,935,
        943,1038,1134}
    master_skill_button={418,1251}
    --技能目标坐标
    servant_x=281
    servant_y={a=344,b=671,c=1011}
    --换人技能目标坐标
    change_x=388
    change_y={m=139,n=359,o=579,p=799,q=1019,r=1239}
    --按钮
    back_points={{ 0x00B7E6, 1, 4, 0x00B2E0, 0, 87, 0x009FD6, 1, 94, 0x00B7E2 }, 90, 37, 1200, 38, 1294}
    back_button={35,1253}
--    attack_points={{ 0xFEDF6A, 0, 25, 0xEAEAEA, 39, 103, 0x0061C1, 30, 112, 0x998974, 23, 121, 0x0E49A3 }, 90, 3, 980, 180 , 1213}
    attack_points={{ 0x00E8F9, 1, -34, 0x00DAF5, -94, -4, 0x0067CB, -87, -38, 0x007ED4, -115, 47, 0xAA9980, -138, -26, 0xC0AE94, -140, -185, 0xFC9B27, -129, -190, 0xF8CB59 }, 90, 26, 1011, 167, 1248}
    attack_button={88,1164}
    switch_confirm_button={100,664}

    --面
    round_cn_points={}
    round_cn_points[1]={{ 0xE1E1E1, 2, 3, 0xF9F9F8, 3, 5, 0xFEFFFE, -1, 5, 0xEFEFEF, -6, 5, 0xEFEFEF, -11, 5, 0xEFEFEF }, 90, 716, 908, 730, 913}
    round_cn_points[2]={{ 0xE9E9E9, 1, 5, 0xF5F5F5, 1, 8, 0xF3F3F3, -3, 10, 0xF8F8F7, -8, 6, 0xFDFEFD, -15, 0, 0xF7F7F7, -16, 7, 0xE6E6E6 }, 90, 714, 905, 731, 915}
    round_cn_points[3]={{ 0xEFEFEF, 1, 5, 0xF4F4F4, -1, 9, 0xF8F8F7, -7, 4, 0xE8E8E8, -12, 10, 0xF9FAF9, -16, 4, 0xE9E9E9, -14, 0, 0xD7D7D7 }, 90, 714, 905, 731, 915}
    round_tw_points={}
    round_tw_points[1]={{ 0xDDDDDD, 4, 0, 0xDDDDDD, 11, 0, 0xDDDDDD, 13, 0, 0xDBDBDB, 13, -3, 0x818181 }, 90, 717, 907, 730, 910}
    round_tw_points[2]={{ 0xCCCCCC, 0, -7, 0xCDCDCD, 5, -4, 0x888888, 13, 2, 0xEAEAEA, 16, 0, 0xE5E5E5, 12, -6, 0xEFEFEF, 16, -6, 0x878787 }, 90, 715, 905, 731, 914}
    round_tw_points[3]={{ 0xE2E2E2, -4, 3, 0x959595, 1, 8, 0xF2F2F2, 6, 3, 0x636363, 6, 6, 0xEAEAEA, 10, 7, 0xD5D5D5, 11, -1, 0xCECECE }, 90, 714, 905, 729, 914}

    --三、结束战斗
    kizuna_points={{ 0x48A9C3, -16, 0, 0x0209AF, -15, 35, 0x006402, -2, 33, 0x50E35B, -2, 39, 0x6BE670 }, 90, 291, 595, 307, 634}
    kizuna_points2={{ 0x110F14, 1, 14, 0xE4B41F, -10, 22, 0x161314, 2, 34, 0xE8BA21, 5, 55, 0xD3A522 }, 90, 542, 75, 557, 130}
    kizuna_upgraded_points={{ 0x7642E0, 6, 3, 0x2E7AEE, 16, 10, 0x6FE29D, 17, -7, 0xF2AC9E }, 90, 223, 702, 240, 719}
    kizuna_upgraded_points2={{ 0xEEBF28, -2, 20, 0xEABB25, 7, 78, 0xDFB627, -2, 114, 0xEFBD25, -3, 136, 0xEABB25, -10, 183, 0xE0A413, -8, 213, 0xEAAC1B }, 90, 340, 694, 420, 907}
    failed_points={{ 0x7632D8, 19, 9, 0x77E890, 26, 3, 0xF9EAC0, 15, -7, 0xE171A0, 13, 3, 0xF1F9F9 }, 90, 602, 963, 628, 979}
    disconnect_points={{ 0xD4D5D7, 0, -37, 0x000000, 0, -43, 0xD8D8D4, 0, -47, 0x000000, 0, -53, 0xD0D0D0, 0, -58, 0x000000, 0, -66, 0xDCDBDC, 3, -73, 0x000000 }, 90, 158, 866, 161, 939}
    reconnect_button={165, 859}
    battle_ended_points={kizuna_points,kizuna_points2,kizuna_upgraded_points,failed_points,kizuna_upgraded_points2}
    drop_mc_points={{ 0x452C0E, 0, 1, 0x654115, 0, 3, 0x7D6E2A, 0, 4, 0x6C7A41, 0, 5, 0x5D7854, 0, 6, 0x4E7466, 0, 10, 0x552F63 }, 90, 724, 981, 724, 991}
    drop_mc_interface_points={{ 0xF5F5F4, -44, 0, 0xDBDEDF, -284, -40, 0x084D9C, -272, -35, 0xF7F7FB, -274, -26, 0x0849AD, -270, -18, 0xD3E2F4 }, 90, 445, 9, 729, 49}
    
    rennzoku_syutugeki_points={{ 0xD4D6D9, 3, 168, 0xD4D4D7, 3, 392, 0xD2D3D3, 5, 601, 0xCFCFD1, 249, 722, 0x244990, 286, 706, 0x2A52AA, 314, 653, 0x2E5FAB }, 90, 153, 381, 467, 1103}
    rennzoku_syutugeki_cancel_button={166,475}
    retreat_button={}
    retreat_button[1]={416,338}
    retreat_button[2]={378,914}
    retreat_button[3]={165,667}
    lr_corner={42,1143}
    apply_interface_points={}
    apply_interface_points[1]={{ 0xD3D3D4, 18, 207, 0xE2E2E5, 538, -172, 0x92CB40, 542, -51, 0x0C2341, 566, 114, 0x005EA8 }, 90, 105, 69, 671, 448}
    apply_interface_points[2]={{0xD2D2D1, -4, -181, 0xD3D3D3, 563, -58, 0x005EBB, 521, -59, 0x80A2D6, 536, -52, 0xF0F3FB, 536, -46, 0x123B68, 536, -40, 0xE2ECF2}, 90, 107, 234, 674, 415}
    not_apply_button={106,340}

    blank_region={680,900}
end
--[[
    -------------------------------------------------------------------
    获取卡信息相关函数
    -------------------------------------------------------------------
]]--

--判断第i张卡的颜色
function get_color(i)
    x, y = findMultiColorInRegionFuzzy(blue_color_points,80, color_start_x, color_start_y[i], color_end_x, color_end_y[i]) 
    if x ~= -1 and y ~= -1 then
        return "blue"
    end
    x, y = findMultiColorInRegionFuzzy(red_color_points,80, color_start_x, color_start_y[i], color_end_x, color_end_y[i])
    if x ~= -1 and y ~= -1 then
        return "red"
    end
    return "green"
end
--卡信息变量初始化
function init_info()
    --卡对象
    cards={Card:new(1,10),Card:new(2,10),Card:new(3,10),Card:new(4,10),Card:new(5,10)}
    --本轮打手各色色卡
    q_card={}
    a_card={}
    b_card={}
    --本轮打手各色色卡的数量
    q_num=0
    a_num=0
    b_num=0
    --打手卡数
    count=0
    --是否有拐红卡
    has_sup_b=false
end
--提取卡信息
function get_card_info()
    if dashou=="通用" then
        for i=1,5 do
            cards[i].color=get_color(i)
            for j=1,#guai_points do
                x, y = findMultiColorInRegionFuzzy(guai_points[j],90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
                if x ~= -1 and y ~= -1 then  
                    cards[i].is_dashou=false
                    if cards[i].color=="red" then
                        has_sup_b=true
                    end
                    break
                end
            end
            x, y = findMultiColorInRegionFuzzy(counter_points,90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cards[i].counter=true
            end
            x, y = findMultiColorInRegionFuzzy(weak_points,90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cards[i].weak=true
            end
        end
    else
        for i=1,5 do
            cards[i].color=get_color(i)
            x, y = findMultiColorInRegionFuzzy(color_points, 80, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cards[i].is_dashou=true   
            else
                cards[i].is_dashou=false
            end
        end
    end
end

--计算卡优先级
function calculate_priority()
    --色卡权重
    p={["green"]={2,1,3},["blue"]={2,3,1},["red"]={3,2,1}}--baq
    if mode=="绿卡" and current_round<=3 then
        m="green"
    elseif mode=="蓝卡" then
        m="blue"
    else
        m="red"
    end

    for i=1,5 do
        --柱子
        if ((current_round==2 or current_round==3) and (mode=="绿卡" or mode=="红卡")) or (np_indexs[2]==5 and np_indexs[3]==5) then
            --克制打手200 打手100 克制拐20 拐10 被克打手5 被克拐1
            if cards[i].is_dashou then
                if not cards[i].weak then
                    cards[i].priority=100
                else
                    cards[i].priority=5
                end
            else
                if cards[i].weak then
                    cards[i].priority=1
                end

            end
            --克制 为两倍
            if cards[i].counter then
                cards[i].priority=cards[i].priority*2
            end
        else
            --克制打手200 克制拐100 打手20 拐10 被克打手5 被克拐1
            if cards[i].counter then
                if cards[i].is_dashou then
                    cards[i].priority=200
                else
                    cards[i].priority=100
                end
            elseif cards[i].weak then
                if cards[i].is_dashou then
                    cards[i].priority=5
                else
                    cards[i].priority=1
                end
            else
                if cards[i].is_dashou then
                    cards[i].priority=20
                else
                    cards[i].priority=10
                end
            end

        end


        --颜色权重，顺便统计打手卡信息
        if cards[i].color=="green" then
            if cards[i].is_dashou then
                q_num=q_num+1
                table.insert(q_card,cards[i])
                count=count+1
                cards[i].priority=cards[i].priority+p[m][3]
            else
                cards[i].priority=cards[i].priority+p["red"][3]
            end

        elseif cards[i].color=="blue" then
            if cards[i].is_dashou then
                a_num=a_num+1
                table.insert(a_card,cards[i])
                count=count+1
                cards[i].priority=cards[i].priority+p[m][2]
            else
                cards[i].priority=cards[i].priority+p["red"][2]
            end

        elseif cards[i].color=="red" then
            if cards[i].is_dashou then
                b_num=b_num+1
                table.insert(b_card,cards[i])
                count=count+1
                cards[i].priority=cards[i].priority+p[m][1]
            else
                cards[i].priority=cards[i].priority+p["red"][1]
            end
        else
            logDebug("error calculate")

        end

    end

end
function get_info()
    keepScreen(true)
    init_info()
    get_card_info()
    calculate_priority()
    keepScreen(false)
    logDebug(string.format("\n打手:%s %s %s %s %s, \n颜色:%s %s %s %s %s, \n克制:%s %s %s %s %s,\n被克制:%s %s %s %s %s,\n优先:%d %d %d %d %d     \nb:%d a:%d q:%d count:%d  has_sup_b:%s    ",
            cards[1].is_dashou,cards[2].is_dashou,cards[3].is_dashou,cards[4].is_dashou,cards[5].is_dashou, 
            cards[1].color,cards[2].color,cards[3].color,cards[4].color,cards[5].color,  
            cards[1].counter,cards[2].counter,cards[3].counter,cards[4].counter,cards[5].counter,    
            cards[1].weak,cards[2].weak,cards[3].weak,cards[4].weak,cards[5].weak,  
            cards[1].priority,cards[2].priority,cards[3].priority,cards[4].priority,cards[5].priority,
            b_num,a_num,q_num,count,has_sup_b))

end

--[[
    -------------------------------------------------------------------
    选卡逻辑相关函数
    -------------------------------------------------------------------
]]--

--没决定第一张卡时考虑首红
function choose_first()
    if selected_card[1].index~=0 then
        return
    end

    local x=1
    for i=1,5 do
        if not cards[i].used and cards[i].color=="red" and not cards[i].is_dashou then
            select_card(x,cards[i])
            return
        end
    end
    for i=1,5 do
        if not cards[i].used and cards[i].color=="red" then
            select_card(x,cards[i])
            return
        end
    end

end
--按优先级选第x张卡
function choose_card_priority(x)
    if selected_card[x].index~=0 then
        return 
    end

    for i=1,5 do
        if not cards[i].used then
            select_card(x,cards[i])
            return
        end
    end
end
function select_card(pos,card)
    selected_card[pos]=card
    card.used=true
    return card
end


--带宝具选第t面卡
function select_np(t)
    get_info()
    np_card=Card:new(np_indexs[t],0)
    --平a
    if np_card.index==5 then
        select_normal()
        return
    end
    
    --二面没打手
    if t==2 and round_2_shuffle=="是" and count==0 and not shuffled then
        shuffle()
        select_np(t)
        return
    end


    selected_card={Card:new(0,0),Card:new(0,0),Card:new(0,0)}
    
    --垫刀
    if t==2 and big_enemy_mode[t]~="后补刀" then
        if mode=="绿卡" then
            --假定打手绿卡会打死
            if count-q_num==0 and not shuffled then
                shuffle()
                select_np(t)
                return
            end
            --降低绿卡优先级
            for i=1,q_num do
                q_card[i].priority_bak=q_card[i].priority
                q_card[i].priority=0
            end
            table.sort(cards)
            --根据设定
            if (big_enemy_mode[t]=="垫一刀" and count-q_num>0)then--垫1张
                select_card(2,np_card)
                --没打手非绿就两张拐
            else
                select_card(3,np_card)--垫2张
            end
            choose_card_priority(2)
            choose_card_priority(1)
            --还原绿卡
            for i=1,q_num do
                q_card[i].priority=q_card[i].priority_bak
            end  
            table.sort(cards)
        else
            select_card(3,np_card)
        end
    else
        --首红与宝具
        if count>=2 then
            --主要是绿卡可优化下
            if b_num>=1 and mode=="绿卡" and t>=3 then--有红               
                table.sort(b_card)
                --忘了这是什么意思
                for i=1,5 do
                    if cards[i].color~="red" and cards[i]<b_card[1] then
                        card=b_card[1]
                        break
                    else
                        card=b_card[b_num]
                    end
                end
                b_num=b_num-1
                select_card(2,np_card)
                select_card(1,card)
            else
                select_card(1,np_card)
            end
        elseif count==1 then--1张打手
            if b_num==1 then
                if not has_sup_b and mode=="绿卡" and t>=3 then--有红没拐红
                    card=b_card[b_num]
                    b_num=b_num-1
                    select_card(2,np_card)
                    select_card(1,card)
                else
                    select_card(1,np_card)
                end
            else
                if has_sup_b and mode=="绿卡" and t>=3 then
                    select_card(2,np_card)
                else
                    select_card(1,np_card)
                end
            end
        else--0打手
            select_card(1,np_card)
            --绿卡队3t需洗牌
            if sp=="cba" and t==3 and not shuffled then
                if is_debug then
                    return false
                end
                shuffle()
                select_np(t)
                return
            end
        end
    end

    table.sort(cards)
    
    if t==3 and np_index_3=="2+1" then
        selected_card={Card:new(7,0),Card:new(6,0),Card:new(0,0)}
    end
    
    if count<2 then
        choose_first()
    end


    for i=3,1,-1 do
        choose_card_priority(i)
    end

    logDebug(string.format("select_np: %d %d %d\n",selected_card[1].index,selected_card[2].index,selected_card[3].index))

    if is_debug then
        NSLog("test")
        os.exit(0)
    end
    click_card(selected_card[1].index,selected_card[2].index,selected_card[3].index)

    if is_select_fail() then
        click_card(selected_card[1].index,selected_card[2].index,selected_card[3].index)
        -- click_enemy(big_enemy[t])
        select_normal(t)
    end

    return false
end
--不带宝具选第t面卡
function select_normal(t)
    get_info()
    selected_card={Card:new(0,0),Card:new(0,0),Card:new(0,0)}
    --一面平a
    if t==1 and np_indexs[t]==5 then
        for i=1,5 do
            if cards[i].is_dashou then
                cards[i].priority_bak=cards[i].priority
                cards[i].priority=0
            end
        end
        table.sort(cards)
        choose_card_priority(2)
        for i=1,5 do
            if cards[i].is_dashou then
                cards[i].priority=cards[i].priority_bak
            end
        end
        table.sort(cards)
        if b_num>0 then
            select_card(1,b_card[1])
        end

    else
        --优先选打手首红
        if count>=3 and b_num>0 then
            if b_num==1 then--有红
                select_card(1,b_card[b_num])

            elseif b_num>=2 then
                temp_card=b_card[1]

                for i=2,b_num do
                    if b_card[i]>temp_card then--多打手情况不克制优先
                        temp_card=b_card[i]
                    end
                end
                select_card(1,temp_card)
            end
            b_num=b_num-1
        elseif count>=1 then--1 2
            if b_num==1 and not has_sup_b then--有红没拐红
                select_card(1,b_card[b_num])
                b_num=b_num-1
            end
        else
            if sp=="cba" and t==4 and not shuffled then
                shuffle()
                select_normal(t)
                return
            end

        end
    end
    --打手三连不首拐红，首红在上方解决 
    if (count<3 and t~=1) then
        choose_first()
    end

    table.sort(cards)
    for i=3,1,-1 do
        choose_card_priority(i)
    end
    logDebug(string.format("select_normal: %d %d %d\n",selected_card[1].index,selected_card[2].index,selected_card[3].index))
    if is_debug then
        os.exit(0)
    end
    if always_np=="是" then
        --仅3面后尝试放宝具
        if t>=3 then
            click_card(6,7,8)
        else
            click_card(big_enemy[t])
        end
        click_enemy(big_enemy[(t<=3 and {t} or {3})[1]],true)
    end
    
    click_card(selected_card[1].index,selected_card[2].index,selected_card[3].index)
    return false
end
--猝死等原因导致预设宝具放不了
function is_select_fail()
    mSleep(800)
    x, y = findMultiColorInRegionFuzzy(table.unpack(back_points));
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        logDebug("select_np fail")
        return true
    end
    return false
end
--1t 2t
function turn_1_2()
    for i=1,2 do
        repeat
            if get_current_round()>current_round then
                break
            end

            logDebug(string.format("current_round:%d",current_round))
            --点技能
            click_enemy(big_enemy[i])  
            select_skill(i)
            click_attack()
            select_np(i)
            if is_battle_ended() then
                return
            end

            while get_current_round() ==i do
                click_attack()
                if always_np=="是" then
                    select_np(i)
                else
                    select_normal(i)
                end

                if is_battle_ended() then
                    return
                end
            end
        until true
        current_round=current_round+1
    end

end
--3面第一次操作
function turn_3()
    logDebug(string.format("current_round:%d",current_round))
    click_enemy(big_enemy[3])
    select_skill(3)
    click_attack()

    --选卡
    select_np(3)
    current_round=current_round+1
end
--3面之后操作
function turn_4()
    while not is_battle_ended() do
        logDebug(string.format("current_round:%d",current_round))
        click_attack()
        select_normal(4)
        current_round=current_round+1
    end
end
--提取某一回合的技能
function select_skill(t)
    for _,v in pairs(skills[t]) do
        local index=get_skill_index(v)
        local target=get_skill_target(v)
        if index==nil then
            break
        end
        --logDebug(index)
        if target~="" then
            --logDebug(target[1])
            if string.len(target)==1 then
                click_skill(index,target)
            else
                click_skill(index,string.sub(target,1,1),string.sub(target,2,2))
            end

        else
            click_skill(index)
        end
        wait_skill_casted()
    end
end
function wait_skill_casted()
    mSleep(1500)
    wait_battle_start(2000)
end
--[[
    -------------------------------------------------------------------
    点击类函数
    -------------------------------------------------------------------
]]--
--点index号技能
function click_skill(index,target,target_2)
    --选目标间隔
    local delay_t=400
    --按御主技能
    if index>=10 then
        click(table.unpack(master_skill_button))
        mSleep(delay_t)
    end

    --按技能
    click(skill_x[index],skill_y[index],700)

    if not target then
        return
    end

    --1.普通目标
    if not target_2 then
        b_x=servant_x
        b_y=servant_y[target]
        click(b_x,b_y,0)
        return
    end

    --2.换人衣服
    b_x=change_x
    b_y=change_y[target]
    click(b_x,b_y,delay_t)

    b_x=change_x
    b_y=change_y[target_2]
    click(b_x,b_y,delay_t)

    click(table.unpack(switch_confirm_button))
end

--素质三连
function click_card(a,b,c)
    local d=400

    click(card_x[a],card_y[a],d)
    click(card_x[b],card_y[b],d)
    click(card_x[c],card_y[c],d)

    mSleep(d)
end

--(返回) 洗牌 (attack)
function shuffle()
    logDebug("shuffled")
    --返回、点、attack
    click(table.unpack(back_button))
    click_skill(12)
    wait_skill_casted()
    click_attack()

    shuffled=true
end

--点击attack进入选卡界面
function click_attack()
    click(table.unpack(attack_button))
    mSleep(1000);
end

--选择敌人
function click_enemy(index,is_brand)
    index=tonumber(index)  
    if not is_brand then
        click(enemy_x, enemy_y[index])
    else
        click(enemy_brand_x,enemy_brand_y[index])
    end
    
end
--点坐标
function click(x,y,d,h)
    d=d or 1700
    h=h or 50
    touchDown(3, x, y)
    mSleep(h);
    touchUp(3)
    mSleep(d);
end


--[[
    -------------------------------------------------------------------
    输入信息处理相关函数
    -------------------------------------------------------------------
]]--
function Split(szFullString, szSeparator)  
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
    local nSplitArray = {}  
    while true do  
        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
        if not nFindLastIndex then  
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
            break  
        end  
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
        nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
        nSplitIndex = nSplitIndex + 1  
    end  
    return nSplitArray  
end
function get_skill_index(s)
    local index=string.gsub(s, "%D","")  
    return tonumber(index)
end

function get_skill_target(s)
    local target=string.gsub(s,"%A","")
    return target
end
--[[
    -------------------------------------------------------------------
    流程控制
    -------------------------------------------------------------------
]]--
--当前回合(面) 1-3
function get_current_round()
    while true do
        keepScreen(true)
        for i=1,3 do
            x, y = findMultiColorInRegionFuzzy(table.unpack(round_cn_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                keepScreen(false)
                return i
            end
        end

        for i=1,3 do
            x, y = findMultiColorInRegionFuzzy(table.unpack(round_tw_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                keepScreen(false)
                return i
            end
        end
        keepScreen(false)
        mSleep(8000)
    end
    logDebug("error get_current_round")
end
--启动前检查防止误启动
function check_miss_operate(m)
    if is_debug then return end
    toast("启动中...")
    mSleep(2500)
    for i=1,#check_miss_operate_points do
        x, y = findMultiColorInRegionFuzzy(table.unpack(check_miss_operate_points[i]));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            return
        end
    end
    toast(m,3000)
    os.exit()
end


function check_disconnected()
    keepScreen(false)
    x, y = findMultiColorInRegionFuzzy(table.unpack(disconnect_points));
    if x ~= -1 and y ~= -1 then  -- 掉线
        click(table.unpack(reconnect_button))
        keepScreen(false)
    else
        return
    end
end

--进本
function enter_mission()
    if sp_mode=="自动" or sp_mode=="图片" then
        click(table.unpack(mission_entry))
        logDebug("检查苹果")
        if need_apple() then
            if apple=="不吃" then
                logDebug("不吃苹果")
                click(table.unpack(close_apple_button))
                notifyVibrate(1500)
                if sleep_button=="是" then
                    os.execute("activator send libactivator.system.sleepbutton")
                end
                os.exit()
            end
            if apple=="铜" then
                click(table.unpack(apple_scroll_slot_end))
                click(apple_x["银"],apple_y)
            else
                click(apple_x[apple],apple_y)
            end
            click(table.unpack(affirm_apple_button))
        end
        logDebug("检查助战界面")
        check_sp_interface()

        select_support()
        keepScreen(false)
        if party_index~="当前" then
            logDebug("选择队伍")
            click(party_x,party_y[tonumber(party_index)%10+1])
            click(party_x,party_y[tonumber(party_index)])
        end

        mSleep(2000)
        click(table.unpack(start_mission_button))
    end
    logDebug("等待进入关卡")
    wait_battle_start()
end
--等待进入一面
function wait_battle_start(t)
    t=t or 5000
    local c=0
    while true do
        x, y = findMultiColorInRegionFuzzy(table.unpack(attack_points));
        if x ~= -1 and y ~= -1 then  -- attack
            return 
        end
        if t~=5000 then -- is waiting skill cast
        else-- is waiting battle start
            if sp_mode=="手动" then
                toast("请选择助战并进入关卡",3000)
                if c%5==0 then
                    notifyVibrate(1000)
                end
            else
                if c%3==0 then
                    logDebug("click start_mission_button")
                    click(table.unpack(start_mission_button))
                end
            end
            c=c+1
        end

        mSleep(t)
    end
end
--战斗是否结束
function is_battle_ended()
    local count=0
    while true do
        count=count+1
        if count>=10 then
            notifyVibrate(1500)
        end

        keepScreen(true)
        x, y = findMultiColorInRegionFuzzy(table.unpack(attack_points));
        if x ~= -1 and y ~= -1 then  -- 出现attack没结束
            keepScreen(false)
            return false
        end

        for i=1,#battle_ended_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(battle_ended_points[i]));
            if x ~= -1 and y ~= -1 then  -- 
                x, y = findMultiColorInRegionFuzzy(table.unpack(drop_mc_points));
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    notifyVibrate(5000)
                    if after_drop_mc=="停止" then
                        os.exit(0)
                    end
                end
                keepScreen(false)
                return true
            end
        end

        check_disconnected()
        keepScreen(false)
        mSleep(4000)
    end
end
--退出战斗
function quit_mission()
    x, y = findMultiColorInRegionFuzzy(table.unpack(failed_points));
    if x ~= -1 and y ~= -1 then  -- 撤退
        notifyVibrate(3000)
        for i=1,#retreat_button do
            click(table.unpack(retreat_button[i]))
        end
        if after_failed=="停止" then
            if sleep_button=="是" then
                os.execute("activator send libactivator.system.sleepbutton")
            end
            os.exit()
        end
        return
    end
    mSleep(2000)
    --连点三下右下角、下一步
    for _=1,4 do
        click(table.unpack(lr_corner))
    end
    
    mSleep(1000)
    x, y = findMultiColorInRegionFuzzy(table.unpack(rennzoku_syutugeki_points));
    if x ~= -1 and y ~= -1 then
        click(table.unpack(rennzoku_syutugeki_cancel_button))
    end
    
    if times>=2 and sp_mode~="手动" then
        wait_quit_mission()
    end
end

--等待出本
function wait_quit_mission()
    while true do
        for i=1,#menu_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(menu_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                return
            end
        end

        x, y = findMultiColorInRegionFuzzy(table.unpack(drop_mc_interface_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            click(table.unpack(small_previous_button))
            for _=1,2 do
                click(table.unpack(lr_corner))
            end
        end
        x, y = findMultiColorInRegionFuzzy(table.unpack(rennzoku_syutugeki_points));
        if x ~= -1 and y ~= -1 then
            click(table.unpack(rennzoku_syutugeki_cancel_button))
        end
        for i=1,#apply_interface_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(apply_interface_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                click(table.unpack(not_apply_button))
                break
            end
        end
        click(table.unpack(blank_region))
        mSleep(5000)
    end
end
--
function start_one_mission(t)
    logDebug(string.format("times:%d",t))
    local notify=string.format("当前文件: %s 剩余次数: %d",conf_name,times-t)
    toast(notify,3000)

    current_round=1
    enter_mission()

    turn_1_2()
    if not is_battle_ended() then
        turn_3()
        turn_4()
    end

    quit_mission()
end

--
function check_sp_interface()
    mSleep(3000)
    x, y = findMultiColorInRegionFuzzy(table.unpack(sp_interface_points));
    logDebug("未识别到助战界面")
    local c=0
    while x == -1 and y == -1 do  -- attack
        c=c+1
        if c>5 then
            os.exit(0)
        end
        check_disconnected()
        mSleep(3000)
        x, y = findMultiColorInRegionFuzzy(table.unpack(sp_interface_points));
    end


end

--(is_find, new_start_x)找助战
function find_support(new_start_x)
    --logDebug(new_start_x)
    --找礼装
    x, y = findMultiColorInRegionFuzzy(mc_points[mc], 80, new_start_x, sp_start_y, sp_end_x, sp_end_y);
    if (x ~= -1 and y ~= -1) or mc=="任意" then  -- 如果找到了礼装

        if sp=="任意" then --任意从者
            if mc=="任意" then
                click(table.unpack(support_slot[1]))
            else
                click(x,y)
            end
            return true
        end
        if mc=="任意" then --找英灵
            x, y = findMultiColorInRegionFuzzy(support_points[sp], 90, new_start_x, sp_start_y, sp_end_x, sp_end_y);
        else
            x, y = findMultiColorInRegionFuzzy(support_points[sp], 90, x+sp_start_dx, y+sp_start_dy , x+sp_end_dx, y+sp_end_dy);
        end

        if x ~= -1 and y ~= -1 then  -- 如果找到了英灵
            if sp=="cba" then --cba技能是否满了
                xx, yy = findMultiColorInRegionFuzzy(cba_skill_points, 90, x+cba_skill_start_dx, cba_skill_start_y, x+cba_skill_end_dx, cba_skill_end_y);
                if xx~=-1 and yy~=-1 then  -- 如果找到了
                    click(x,y)
                    return true
                end
            elseif sp=="310cba" then
                xx, yy = findMultiColorInRegionFuzzy(cba_310skill_points, 90, x+cba_skill_start_dx, cba_310skill_start_y, x+cba_skill_end_dx, cba_310skill_end_y);
                if xx~=-1 and yy~=-1 then  -- 如果找到了
                    click(x,y)
                    return true
                end
            else--其它直接选
                click(x,y)
                return true
            end

        end
    end
    if x~=-1 and y ~= -1 then
        return false,x+10 --继续找
    else
        return false --上滑
    end

end

--自动选助战
function select_support()
    logDebug("选择助战")
    mSleep(2000)
    if sp_class_index and sp_class_index~="当前" then
        click(sp_class_button_x,sp_class_button_y[sp_class_index])
    end

    if mc=="任意" and sp=="任意" then
        click(table.unpack(support_slot[1]))
        return
    end

    while true do
        keepScreen(true)
        if sp_mode=="图片" then
            x, y = findImageFuzzy(path.."sp.bmp",60); -- 
            if x ~= -1 and y ~= -1 then            -- 如果找到了
                click(x,y)
                return
            end
        else
            new_start_x=sp_start_x
            is_find, new_start_x=find_support(new_start_x)
            while (not is_find) and new_start_x do
                is_find, new_start_x=find_support(new_start_x)
            end
            if is_find then
                logDebug("找到助战")
                return
            end
        end
        x, y = findMultiColorInRegionFuzzy(table.unpack(scroll_bar_slot_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            x, y = findMultiColorInRegionFuzzy(table.unpack(scroll_bar_arrived_end_points));
            if x ~= -1 and y ~= -1 then  -- 如果到底了
                refresh_support()
            end
            move_upward(6)
        else
            refresh_support()
        end

        keepScreen(false)

    end
end

--上滑
function move_upward(t,x,y)
    x=x or 100 
    y=y or 770
    touchDown(5, x, y)
    mSleep(34);
    local dx=15
    for _=1,t do
        touchMove(5, x+dx, y)
        mSleep(20);
        dx=dx+15
    end
    touchUp(5)

    mSleep(500);
end
--刷新助战
function refresh_support()
    keepScreen(false)
    click(table.unpack(refresh_button))
    x, y = findMultiColorInRegionFuzzy(table.unpack(refresh_too_fast_warning));
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        --解决奇怪的bug
        x, y = findMultiColorInRegionFuzzy(table.unpack(start_mission_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            click(table.unpack(previous_button))
            return
        end
        mSleep(8000)
        click(table.unpack(refresh_warning_close_button))
        refresh_support()
        return
    end
    click(table.unpack(refresh_confirm_button))
end

--需要吃苹果
function need_apple()
    x, y = findMultiColorInRegionFuzzy(table.unpack(sp_interface_points));
    logDebug("未识别到助战界面")
    local c=0
    if x == -1 and y == -1 then 
        return true
    end
    return false
    
end

--[[
    -------------------------------------------------------------------
    自动更新
    -------------------------------------------------------------------
]]--

function check_version()
    data = httpGet('https://raw.githubusercontent.com/brendonjkding/fgoScript/master/UPDATE.md')
    if data=="" then
        return
    end
    local latest_version=Split(data,'\n')[2]
    latest_version=string.sub(latest_version,5,9)
    latest_version=getNumVersion(latest_version)
    if latest_version<=VERSION then
        return
    end
    notifyMessage("存在新版本,准备更新,请勿中止运行",3000)
    update()
    notifyMessage("更新完毕,请重新设置再运行",3000)
    os.exit(0)
end

function update()
    data=httpGet("https://raw.githubusercontent.com/brendonjkding/fgoScript/master/autoupdate.lua")
    if data~="" then
        file=io.open(path.."autoupdate.lua","w")
        io.output(file)
        io.write(data)
        io.close(file)

        dofile(path.."autoupdate.lua")
        autoupdate()
        os.remove(path.."autoupdate.lua");
    else
        os.exit()
    end
end

function main()
    toast("lib_fgo")
end

