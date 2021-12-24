--[[
    -------------------------------------------------------------------
    初始化数据类函数
    -------------------------------------------------------------------
]]--
function init(is_debug, skip_loading_liboc)
    init_basic_variables()
    init_points()
    init_object()
    init_configuration()

    --Debug
    current_battle=1
    logDebug("------------------------------------------------------------")
    _is_debug=is_debug

    check_misoperation(message)

    save_configuration()
    if _is_debug and is_ios and not skip_loading_liboc then
        local oc = require "liboc"
        NSLog=oc.NSLog
    else
        NSLog=function ()end
    end
end
function init_basic_variables()
    VERSION=178
    -- 适用屏幕参数
    SCREEN_RESOLUTION="750x1334";
    SCREEN_COLOR_BITS=32;
    rotateScreen(0);
    

    kernelVersion=io.popen("uname -s")
    kernelVersion=kernelVersion:read("*all")
    if kernelVersion=="Darwin\n" then is_ios=true
    else is_ios=false end
    
    if is_ios then
        path="/var/touchelf/scripts/"
    else
        path="/mnt/sdcard/touchelf/scripts/"
        if not toast then toast=notifyMessage end
    end

end
function getNumVersion(version)
    return tonumber(string.sub(version, 1, 1)..string.sub(version, 3,3)..string.sub(version, 5,5))
end
function myDofile(file_path)
    local file=io.open(file_path,"r")
    io.input(file)
    local chunk=io.read("*a")
    io.close(file)
    local f=load(chunk)
    f()
end

function read_configuration_from_file_(file_name)
    conf_file_name=file_name
    init_basic_variables()
    file=io.open(path..conf_file_name..".lua","r")
    io.input(file)
    text=io.read("*a")
    if text=="" then
        notifyMessage("文件名有误",3000)
        os.exit()
    end
    myDofile(path..conf_file_name..".lua")
    io.close(file)
    line=Split(text,'\n')
    for i=1,#line do
        if string.sub(line[i],1,1)=='-' then
            conf_file_name=string.sub(line[i],3)
            break
        end
    end
end
function save_configuration()
    if _is_debug then return end

    t=[[sp_mode="%s"--助战
ce="%s"--礼装
sp="%s"--从者
require_support_from_friends="%s"--310
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
battle_2_shuffle="%s"--二面是否洗牌
party_index="%s"--队伍序号
sp_class_index="%s"--助战职介
after_failed="%s"--如失败
after_dropped_ce="%s"--如掉礼装
always_np="%s"--始终尝试放宝具
conf_file_name="%s"--文件名
--%s

UI = {
    { 'InputBox{1}',             'times',    '打本次数：' },
    { 'DropList{不吃|金|银|铜|彩}',             'fruit',    '吃苹果：' },
    { 'DropList{否|是}',             'lock_screen_after_finished',    '完成后锁屏(需安装activator)' }
}
_file=io.open("%slib_fgo.lua","r");io.input(_file);_chunk=io.read("*a");io.close(_file);_f=load(_chunk);_f();

function main()
    init()
    
    for i=1,times do
        start_one_quest(i)
    end
    
    dealloc()
end
]]


    t=string.format(t, sp_mode, ce, sp, require_support_from_friends,
        skill_serial_1, skill_serial_2, skill_serial_3,
        np_index_1, np_index_2, np_index_3,
        big_enemy_1, big_enemy_mode_1,
        big_enemy_2, big_enemy_mode_2, big_enemy_3,
        mode, shuffle_cloth, battle_2_shuffle,
        party_index, sp_class_index, after_failed, after_dropped_ce, always_np,
        conf_file_name, conf_file_name, path)

    file=io.open(path..conf_file_name..".lua","w")
    io.output(file)
    io.write(t)
    io.close(file)

end
function init_configuration()
    --deprecated configuration
    if mode=="XJBD" then mode="红卡" end
    mode=(mode_ and {mode_} or {mode})[1]
    ce=(mc and {mc} or {ce})[1]
    battle_2_shuffle=(round_2_shuffle and {round_2_shuffle} or {battle_2_shuffle})[1]
    fruit=(apple and {apple} or {fruit})[1]
    conf_file_name=(conf_name and {conf_name} or {conf_file_name})[1]
    lock_screen_after_finished=(sleep_button and {sleep_button} or {lock_screen_after_finished})[1]
    

    big_enemy={big_enemy_1,big_enemy_2,big_enemy_3}
    big_enemy_mode={big_enemy_mode_1,big_enemy_mode_2,"后补刀"}


    skill_serial_1=skill_serial_1 or ""
    skill_serial_2=skill_serial_2 or ""
    skill_serial_3=skill_serial_3 or ""
    np_index_1=np_index_1 or "1"
    np_index_2=np_index_2 or "1"
    np_index_3=np_index_3 or "1"

    times=times or "1"
    fruit=fruit or "不吃"
    lock_screen_after_finished=lock_screen_after_finished or "否"

    times=tonumber(times)
    require_support_from_friends=require_support_from_friends or "否"
    party_index=party_index or "当前"
    sp_class_index=sp_class_index or "当前"
    after_failed=after_failed or "停止"
    battle_2_shuffle=battle_2_shuffle or "否"
    always_np=always_np or "否"
    after_dropped_ce=after_dropped_ce or "继续"
    conf_file_name=(conf_file_name=="" and {"默认"} or {conf_file_name})[1]
    shuffled=(shuffle_cloth=="是" and {false} or {true})[1]
    check_misoperation_points=(sp_mode=="手动" and {{attack_points}} or {possible_menu_points})[1]
    message=(sp_mode=="手动" and {"请进入副本再启动"} or {"请把关卡放在第一个再启动"})[1]

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
end

--卡对象
function init_object()
    Card={index=0,priority=0,is_used=false,is_dashou=true,effective=false,resist=false,color=false,priority_bak=false,test=1}
    Card.__index=Card 
    Card.__lt=function(a,b)return a.priority>b.priority end
    function Card:new(index, priority)
        local self={}
        setmetatable(self, Card)
        self.index=index
        self.priority=priority
        return self
    end
end
function init_points()
    --一、开始战斗
    possible_menu_points={}
    possible_menu_points[1]={{ 0xFAD186, 17, 0, 0xFDF6EC, 34, 0, 0xFCFAD2, 44, 0, 0x29231A, 49, 0, 0xFCED1C, 121, 69, 0x774AE3 }, 80, 9, 172, 130, 241}
    possible_menu_points[2]={{ 0xFAD186, 40, 77, 0xD4D6D8, 47, 248, 0xD1D2D1, 45, 148, 0x101334, 45, 191, 0x05050A, 45, 202, 0xD3D3D4 }, 80, 9, 172, 56, 420}
    possible_menu_points[3]={{ 0xE0E2E2, -4, -114, 0xDADCDB, -72, -1119, 0xEBC681, -38, -1119, 0xE9ECCB, -23, -1119, 0xA3937C, 19, -1078, 0x857B68 }, 80, 9, 172, 100, 1291}
    possible_menu_points[4]={{ 0xD5D9D7, 4, -114, 0xE2E2E1, -21, -870, 0xD0D0D0, -18, -1032, 0xD7D7D7, -70, -1117, 0xEDCB86 }, 80, 7, 172, 81, 1289}

    quest_button={563,999}
    fruit_x={["彩"]=574,["金"]=418,["银"]=290}
    fruit_y=700
    fruit_scroll_bar_slot_bottom={174,1058}
    restore_ap_close_button={100,678}
    use_fruit_ok_button={165,863}

    start_quest_button={39,1240}

    --助战
    support_selection_interface_points={{ 0x136C9F, -7, 8, 0xEFF7FE, -7, 14, 0x093055, -7, 29, 0x0066F4, -22, 75, 0xFEFEFE, -23, 82, 0x686F72 }, 90, 600, 15, 623, 97}

    support_selection_class_button_x=616
    support_selection_class_button_y={["全"]=94,["剑"]=164,["弓"]=234,["枪"]=304,["骑"]=374,
        ["术"]=444,["杀"]=514,["狂"]=584,["EXT"]=654,["MIX"]=724}

    support_update_list_button={612,881}
    support_update_list_yes_button={162,870}
    support_scroll_bar_arrived_bottom_points={{ 0xF7FCF4 }, 90, 19, 1308, 19, 1308}
    support_scroll_bar_slot_points={{ 0x55636B }, 80, 11, 1308, 17, 1308}
    support_updating_in_succession_warning={{ 0xEDEEEA, 43, -2, 0xEFEFEF }, 90, 138, 666, 181, 668}
    support_updating_in_succession_warning_close_button={171,673}
    support_first_slot={452,137}

    --助战礼装特征
    ce_points={}
    ce_points["午餐"]={ 0x67B180, -27, 4, 0xEFEBE2, -7, 64, 0xF3C8BC, -23, 98, 0x493438, 3, 138, 0x67AF82, -6, 131, 0xA0D898, -24, 138, 0xFBFC84, -32, 137, 0xB1F3D5, -26, 141, 0xF5F9BB }
    ce_points["擦汗"]={ 0x7EA75B, 20, -7, 0xF2ECCF, 29, 24, 0xF5D9D8, 22, 61, 0x9A6ACB, 27, 77, 0xCDA49A, 30, 109, 0x597027, 2, 120, 0xA2C24F, 3, 124, 0xEBF1B2, 7, 120, 0xF9FA44 }
    ce_points["qp"]={ 0xBF8E69, 21, 10, 0x435DCB, 2, 44, 0x283B56, 10, 69, 0xF9D9A1, 9, 94, 0x1A1F2B, 3, 131, 0xFDFB5C, -1, 132, 0xB8D55E, 22, 115, 0xD3EEFA }
    ce_points["所长"]={ 0x5F362F, 5, 18, 0xD9A879, 7, 32, 0x63132D, 11, 43, 0x906F5F, 11, 69, 0xF9DEB7, -3, 97, 0xFBCCC5, 18, 125, 0x4E110E, 18, 142, 0xEBAD59, 7, 138, 0xF9F824 }
    ce_points["新所长"]={ 0x372F2F, -19, 12, 0xF1ECE2, -26, 51, 0x89381B, -11, 50, 0x92C37E, -5, 77, 0xFEEEE3, 9, 105, 0x2A2B58, 9, 142, 0x1D3B29, -13, 137, 0xFAFA54, -18, 137, 0xA2C262 }
    --闪闪祭
    ce_points["无限池"]={ 0xF09C9F, 9, 41, 0xFFEBD5, 14, 51, 0x685D96, 14, 78, 0xD7957D, 18, 109, 0x998C8C, 18, 118, 0xB82A2F }
    ce_points["无限池(满破)"]={ 0xF09C9F, 9, 41, 0xFFEBD5, 14, 51, 0x685D96, 14, 78, 0xD7957D, 18, 109, 0x998C8C, 18, 118, 0xB82A2F, -5, 120, 0xFBFC77, -8, 120, 0xC7DA7E, -12, 120, 0xA6E2BA }
    ce_points["新午餐"]={ 0x3888BB, -21, 0, 0xF5F6F4, -5, 13, 0xFBD2D6, 4, 47, 0xFEF3E8, -7, 47, 0xA8749D, -18, 71, 0xFFF2EA, -26, 71, 0xE2B4AD, 1, 85, 0xB9639B, -23, 118, 0xFCFB66, -31, 118, 0xADE1B5 }
    ce_points["新qp"]={ 0x183851, 2, 32, 0xF9FDFD, -13, 51, 0x49343C, -4, 63, 0x698C9F, -19, 74, 0xFBCFBD, 8, 70, 0x8C6A5F, -24, 102, 0x302C26, -12, 114, 0xE8FCFD, 9, 134, 0x928B96, -18, 137, 0xFDFE80, -20, 137, 0xE5F491, -24, 138, 0x94C393 }
    ce_points["满破宝石"]={0x020202, -24, 0, 0xD0D2EB, -2, 17, 0x866760, -20, 41, 0xF2CA6F, -26, 51, 0xEFC05F, -35, 65, 0x231514, -2, 75, 0xF0C72A, -16, 90, 0x0B0B0E, 0, 125, 0x0F1014, -9, 133, 0xE4D064, -33, 129, 0xAED992}

    --助战从者特征
    support_servant_points={}
    support_servant_points["孔明"]={ 0xFAF4D6, -6, 4, 0x716256, -3, 15, 0xFBF5D5, -31, 11, 0xDEC4A2, -33, -59, 0xBFEFD6, 36, -15, 0x4C5D59 }
    support_servant_points["梅林"]={ 0x739EE3, 43, 47, 0x6D4B7C, 46, 66, 0xF3D6D9, 54, 81, 0x1D1B68, 41, 104, 0xAEAAE2, 47, 141, 0xFFF0EF }
    support_servant_points["cba"]={ 0xD099F5, 44, -4, 0xDEC9F4, 45, 26, 0x793561, 45, 41, 0xAF0E19, 28, 51, 0xFEFFE1, 45, 86, 0xB10B12 }
    support_servant_points["310cba"]=support_servant_points["cba"]
    support_servant_points["狐狸"]={ 0xB18B34, 2, 26, 0xE28875, 8, 49, 0xF7C268, 8, 70, 0xF6E4C4, 13, 98, 0xF9CD76, 13, 111, 0xD07765, 13, 152, 0xFEFFF2 }
    support_servant_points["花嫁"]={ 0xF4E1A9, 4, 28, 0x171304, -4, 32, 0x83B132, -4, 53, 0xFCF3DB, 12, 74, 0xAFD85A, 18, 74, 0x10170D, 18, 93, 0xF6DC93, 18, 119, 0x957B49, 18, 126, 0xDEE0D7 }
    support_servant_points["C呆"]={ 0xFDFFFB, -16, 0, 0xAF4451, -29, -7, 0xFCFC53, -38, -7, 0xAAF7D1, -45, -13, 0xFBFCF1, -7, -36, 0x65403B, -3, -56, 0xFEF6EC, -33, -57, 0xE1C3B5, 2, -78, 0xE2EEB3, 8, -78, 0x88403F }

    sp_icon_start_x=4
    sp_icon_start_y=23
    sp_icon_end_x=588
    sp_icon_end_y=232

    sp_icon_start_dx=0
    sp_icon_start_dy=-60
    sp_icon_end_dx=174
    sp_icon_end_dy=155

    sp_friend_icon_start_dx=-150
    sp_friend_icon_start_y=1160
    sp_friend_icon_end_dx=30
    sp_friend_icon_end_y=1240
    sp_friend_icon_points={ 0xAD8444, -2, 28, 0xBF9857, -1, 17, 0xBFF880, 29, 37, 0xF4E28E, 29, 26, 0xCCFD8E, 29, 2, 0x8BDD4F, 29, -8, 0xF1EEA4, 35, 15, 0xFCEE9B, 21, 15, 0x83A84C }

    formation_party_selection_button_x=698
    formation_party_selection_button_y={549}
    for i=2,10 do
        formation_party_selection_button_y[i]=formation_party_selection_button_y[i-1]+26
    end

    return_button={716, 100}
    ce_detail_close_button={716,46}

    --二、战斗中
    --卡色判断区域
    card_color_feature_start_x=54
    card_color_feature_start_y={7}
    card_color_feature_end_x=265
    card_color_feature_end_y={284}

    --卡打手信息区域
    card_servant_feature_start_x=171
    card_servant_feature_start_y={24}
    card_servant_feature_end_x=459
    card_servant_feature_end_y={280}
    for i=2,5 do
        card_color_feature_start_y[i]=card_color_feature_start_y[i-1]+268
        card_color_feature_end_y[i]=card_color_feature_end_y[i-1]+268
        card_servant_feature_start_y[i]=card_servant_feature_start_y[i-1]+268
        card_servant_feature_end_y[i]=card_servant_feature_end_y[i-1]+268
    end
    --卡信息
    card_blue_points={ 0x4CA2FD, 1, -63, 0x2576FC, 96, -105, 0x004CE2, 109, 4, 0x0F69FD, 84, -18, 0x4DC9FF, 92, 53, 0x0047DE, 24, 57, 0x0D4EE4 }
    card_red_points={ 0xCA0101, 1, 14, 0xFF1200, 65, -2, 0xBD0101, 41, 28, 0xFF1801, 53, 60, 0xFB4F05, 39, 65, 0xFFB214, 58, 114, 0xFF300C, 51, 143, 0xF6150D, 33, 187, 0xC20402, -3, 179, 0xC80E0B, 2, 163, 0xE61D14, 25, 163, 0xD01209 }

    --cba、孔明、梅林
    cba_points={ 0x442255, 4, -8, 0x44224D, -25, -18, 0x442255, -11, -21, 0xFFFEEC, 19, -41, 0x9955A7, -35, -42, 0x874F8C, -25, -49, 0xFFFFEE, -44, -60, 0xFFFFEE, -27, -68, 0xFFFFEE, -17, -58, 0xEC0505, 13, -55, 0xA259A2, 8, -73, 0xC470C5, -24, -81, 0x442255, -37, -81, 0x442255 }
    zhuge_points={ 0xCC8844, -1, -5, 0xCC8844, 0, -18, 0xFFCC77, 1, -32, 0xFFCC77, 3, -42, 0x445555, 3, -54, 0x445555, 3, -64, 0xFFEEDD, 4, -80, 0xFFEEDD, 15, -92, 0x243535, 32, -78, 0xFFEEDD, 41, -66, 0x445553, 37, -29, 0x3F5050 }
    merlin_points={ 0xFFDAEE, -15, 1, 0xFFB0D2, -12, -5, 0xFFEFFF, -20, -6, 0x8888CC, -30, -16, 0xFFBBDD, -26, -23, 0xBBCCFF, 2, -18, 0xAAAAEE, 4, -30, 0xDDCCEE, -30, -51, 0xFFEEDD, -1, -42, 0xFFEEDD, -15, -62, 0xFFEEDD, -1, -52, 0x8E49A8, 22, -70, 0xF4F8FF, 3, -77, 0xDFCAFC }
    caber_points={ 0xFFFFFF, 10, -1, 0xCCBBDD, 3, -6, 0x080808, 0, -10, 0x060606, -3, -11, 0x0E0E0E, 9, -24, 0xFFEECC, 1, -33, 0x110D0A, 1, -41, 0xCCBFDD, 7, -44, 0xFFEEDD, 14, -59, 0xCCAA66, 14, -65, 0xFFEEC9, 35, -43, 0x70B58B, 58, -53, 0xFFEECC, 52, -45, 0xFFF1DE, 62, -40, 0xFFEECC, 40, -4, 0xFFF6DF, 64, -7, 0xFFEECC }
    caber_stage2_points={ 0xFFEECC, -12, -2, 0xFFEECC, -29, -12, 0xEEBB99, -33, -26, 0x660022, -33, -39, 0x871032, -22, -50, 0xFFEECC, -4, -54, 0xFFEDCA, -25, -32, 0xFFEEDD, -2, -19, 0xFFEEDD, -9, -41, 0xFFEEDD, 1, -28, 0xC3E5D2, 23, -47, 0xFFEECC, 25, -20, 0xFFEECC }
    guai_points={cba_points, zhuge_points, merlin_points, caber_points, caber_stage2_points}


    card_effective_points={ 0xE01E1E, 0, 8, 0xA10000, 0, 20, 0x910000, 5, 18, 0xD80000, 5, 9, 0xE90000, 10, 13, 0xFE5220, 13, 13, 0xFCDD7E }
    card_resist_points={0x62EAFF, 1, 6, 0xA7FAFF, 1, 21, 0x9BF5FF, -2, 23, 0x23A2F5, -1, 15, 0x3AC5FB, -6, 14, 0x0D7DED, -10, 14, 0x0150D4, -12, 13, 0x0141C3}

    --切换敌人坐标
    enemy_x=526
    enemy_y={155,318,483}
    
    enemy_class_x=707
    enemy_class_y={40,300,550}
    
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
    skill_target_servant_x=281
    skill_target_servant_y={a=344,b=671,c=1011}
    --换人技能目标坐标
    skill_order_change_target_servant_x=388
    skill_order_change_target_servant_y={m=139,n=359,o=579,p=799,q=1019,r=1239}
    skill_order_change_replace_button={100,664}
    --按钮
    card_selection_back_points={{ 0x00B7E6, 1, 4, 0x00B2E0, 0, 87, 0x009FD6, 1, 94, 0x00B7E2 }, 90, 37, 1200, 38, 1294}
    card_selection_back_button={35,1253}
    attack_points={{ 0x00E8F9, 1, -34, 0x00DAF5, -94, -4, 0x0067CB, -87, -38, 0x007ED4, -115, 47, 0xAA9980, -138, -26, 0xC0AE94, -140, -185, 0xFC9B27, -129, -190, 0xF8CB59 }, 80, 26, 1011, 167, 1248}
    attack_button={88,1164}

    --面
    battle_cn_points={}
    battle_cn_points[1]={{ 0xC1C1C1, 1, 2, 0xDFDFDF, 2, 4, 0xFEFEFE, 3, 6, 0xFDFDFD, 0, 6, 0xFBFBFB, -6, 6, 0xFBFBFB, -10, 6, 0xFBFBFB }, 80, 717, 926, 730, 932}
    battle_cn_points[2]={{ 0xE7E7E7, 2, 2, 0xEBEBEB, 3, 5, 0xDADADA, 2, 9, 0xE6E6E6, -2, 10, 0xFFFFFF, -7, 5, 0xE6E6E6, -9, 3, 0xEDEDED, -10, 2, 0xECECEC, -11, 1, 0xF1F1F1, -14, -1, 0xFCFCFC }, 70, 714, 922, 731, 933}
    battle_cn_points[3]={{ 0xDEDEDE, 1, 2, 0xEFEFEF, 1, 4, 0xE7E7E7, -2, 9, 0xF6F6F6, -7, 4, 0xE8E8E8, -7, 6, 0xF3F3F3, -12, 10, 0xFEFEFE, -15, 6, 0xF3F3F3, -15, 2, 0xECECEC }, 75, 715, 923, 731, 933}

    --三、结束战斗
    bond_points={{ 0x48A9C3, -16, 0, 0x0209AF, -15, 35, 0x006402, -2, 33, 0x50E35B, -2, 39, 0x6BE670 }, 90, 291, 595, 307, 634}
    bond_points2={{ 0x110F14, 1, 14, 0xE4B41F, -10, 22, 0x161314, 2, 34, 0xE8BA21, 5, 55, 0xD3A522 }, 90, 542, 75, 557, 130}
    bond_upgraded_points={{ 0x7642E0, 6, 3, 0x2E7AEE, 16, 10, 0x6FE29D, 17, -7, 0xF2AC9E }, 90, 223, 702, 240, 719}
    bond_upgraded_points2={{ 0xEEBF28, -2, 20, 0xEABB25, 7, 78, 0xDFB627, -2, 114, 0xEFBD25, -3, 136, 0xEABB25, -10, 183, 0xE0A413, -8, 213, 0xEAAC1B }, 90, 340, 694, 420, 907}
    all_servants_incapacitated_points={{ 0x7632D8, 19, 9, 0x77E890, 26, 3, 0xF9EAC0, 15, -7, 0xE171A0, 13, 3, 0xF1F9F9 }, 90, 602, 963, 628, 979}
    lost_connection_points={{ 0xD4D5D7, 0, -37, 0x000000, 0, -43, 0xD8D8D4, 0, -47, 0x000000, 0, -53, 0xD0D0D0, 0, -58, 0x000000, 0, -66, 0xDCDBDC, 3, -73, 0x000000 }, 90, 158, 866, 161, 939}
    connection_retry_button={165, 859}
    battle_finished_points={bond_points,bond_points2,bond_upgraded_points,all_servants_incapacitated_points,bond_upgraded_points2}
    rainbow_trophy_points={{ 0x67431B, 2, 1, 0x7A5E24, 2, 2, 0x736333, 3, 3, 0x577254, 5, 3, 0x4A7265, 8, 4, 0x4A616E, 8, 5, 0x5B4871 }, 90, 712, 1003, 720, 1008}
    ce_detail_points={{ 0xF5F5F4, -44, 0, 0xDBDEDF, -284, -40, 0x084D9C, -272, -35, 0xF7F7FB, -274, -26, 0x0849AD, -270, -18, 0xD3E2F4 }, 90, 445, 9, 729, 49}
    
    repeat_quest_points={{ 0xDADADA, -6, -203, 0xD1D2D2, -8, -432, 0xD4D4D4, -2, -594, 0xD6D6D7 }, 90, 159, 379, 167, 973}
    repeat_quest_close_button={166,475}
    withdraw_actions={}
    withdraw_actions[1]={416,338}
    withdraw_actions[2]={378,914}
    withdraw_actions[3]={165,667}
    bottom_right={42,1143}

    friend_request_interface_points={}
    friend_request_interface_points[1]={{ 0xD3D3D4, 18, 207, 0xE2E2E5, 538, -172, 0x92CB40, 542, -51, 0x0C2341, 566, 114, 0x005EA8 }, 90, 105, 69, 671, 448}
    friend_request_interface_points[2]={{0xD2D2D1, -4, -181, 0xD3D3D3, 563, -58, 0x005EBB, 521, -59, 0x80A2D6, 536, -52, 0xF0F3FB, 536, -46, 0x123B68, 536, -40, 0xE2ECF2}, 90, 107, 234, 674, 415}
    friend_request_close_button={106,340}

    blank_area={680,900}
end
function dealloc()
    lock_screen_if_necessary()

    notifyMessage("感谢使用")
    notifyVibrate(3000)
end

--[[
    -------------------------------------------------------------------
    获取卡信息相关函数
    -------------------------------------------------------------------
]]--

--判断第i张卡的颜色
function get_card_color_of_index_(i)
    x, y = findMultiColorInRegionFuzzy(card_blue_points,80, card_color_feature_start_x, card_color_feature_start_y[i], card_color_feature_end_x, card_color_feature_end_y[i])
    if x ~= -1 and y ~= -1 then
        return "blue"
    end
    x, y = findMultiColorInRegionFuzzy(card_red_points,80, card_color_feature_start_x, card_color_feature_start_y[i], card_color_feature_end_x, card_color_feature_end_y[i])
    if x ~= -1 and y ~= -1 then
        return "red"
    end
    return "green"
end
--卡信息变量初始化
function reset_card_objects()
    --卡对象
    cards={Card:new(1,10),Card:new(2,10),Card:new(3,10),Card:new(4,10),Card:new(5,10)}
    --本轮打手各色色卡
    dashou_q_card={}
    dashou_a_card={}
    dashou_b_card={}
    --本轮打手各色色卡的数量
    dashou_q_card_count=0
    dashou_a_card_count=0
    dashou_b_card_count=0
    --打手卡数
    dashou_card_count=0
    --是否有拐红卡
    card_has_guai_buster=false
end
--提取卡信息
function get_card_intrinsic_attributes()
    for i=1,5 do
        cards[i].color=get_card_color_of_index_(i)
        for j=1,#guai_points do
            x, y = findMultiColorInRegionFuzzy(guai_points[j],75, card_servant_feature_start_x, card_servant_feature_start_y[i], card_servant_feature_end_x, card_servant_feature_end_y[i]);
            if x ~= -1 and y ~= -1 then
                cards[i].is_dashou=false
                if cards[i].color=="red" then
                    card_has_guai_buster=true
                end
                break
            end
        end
        x, y = findMultiColorInRegionFuzzy(card_effective_points,90, card_servant_feature_start_x, card_servant_feature_start_y[i], card_servant_feature_end_x, card_servant_feature_end_y[i]);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cards[i].effective=true
        end
        x, y = findMultiColorInRegionFuzzy(card_resist_points,90, card_servant_feature_start_x, card_servant_feature_start_y[i], card_servant_feature_end_x, card_servant_feature_end_y[i]);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cards[i].resist=true
        end
    end
end

--计算卡优先级
function calculate_card_priority()
    --色卡权重
    p={["green"]={2,1,3},["blue"]={2,3,1},["red"]={3,2,1}}--baq
    if mode=="绿卡" and current_battle<=3 then
        m="green"
    elseif mode=="蓝卡" then
        m="blue"
    else
        m="red"
    end

    for i=1,5 do
        --柱子
        if ((current_battle==2 or current_battle==3) and (mode=="绿卡" or mode=="红卡")) or (np_indexs[2]==5 and np_indexs[3]==5) then
            --克制打手200 打手100 克制拐20 拐10 被克打手5 被克拐1
            if cards[i].is_dashou then
                if not cards[i].resist then
                    cards[i].priority=100
                else
                    cards[i].priority=5
                end
            else
                if cards[i].resist then
                    cards[i].priority=1
                end

            end
            --克制 为两倍
            if cards[i].effective then
                cards[i].priority=cards[i].priority*2
            end
        else
            --克制打手200 克制拐100 打手20 拐10 被克打手5 被克拐1
            if cards[i].effective then
                if cards[i].is_dashou then
                    cards[i].priority=200
                else
                    cards[i].priority=100
                end
            elseif cards[i].resist then
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
                dashou_q_card_count=dashou_q_card_count+1
                table.insert(dashou_q_card,cards[i])
                dashou_card_count=dashou_card_count+1
                cards[i].priority=cards[i].priority+p[m][3]
            else
                cards[i].priority=cards[i].priority+p["red"][3]
            end

        elseif cards[i].color=="blue" then
            if cards[i].is_dashou then
                dashou_a_card_count=dashou_a_card_count+1
                table.insert(dashou_a_card,cards[i])
                dashou_card_count=dashou_card_count+1
                cards[i].priority=cards[i].priority+p[m][2]
            else
                cards[i].priority=cards[i].priority+p["red"][2]
            end

        elseif cards[i].color=="red" then
            if cards[i].is_dashou then
                dashou_b_card_count=dashou_b_card_count+1
                table.insert(dashou_b_card,cards[i])
                dashou_card_count=dashou_card_count+1
                cards[i].priority=cards[i].priority+p[m][1]
            else
                cards[i].priority=cards[i].priority+p["red"][1]
            end
        else
            logDebug("error calculate")

        end

    end

end
function get_card_info()
    keepScreen(true)
    reset_card_objects()
    get_card_intrinsic_attributes()
    calculate_card_priority()
    keepScreen(false)
    logDebug(string.format("\n打手:%s %s %s %s %s, \n颜色:%s %s %s %s %s, \n克制:%s %s %s %s %s,\n被克制:%s %s %s %s %s,\n优先:%d %d %d %d %d     \nb:%d a:%d q:%d dashou_card_count:%d  card_has_guai_buster:%s    ",
            cards[1].is_dashou,cards[2].is_dashou,cards[3].is_dashou,cards[4].is_dashou,cards[5].is_dashou, 
            cards[1].color,cards[2].color,cards[3].color,cards[4].color,cards[5].color,  
            cards[1].effective,cards[2].effective,cards[3].effective,cards[4].effective,cards[5].effective,
            cards[1].resist,cards[2].resist,cards[3].resist,cards[4].resist,cards[5].resist,
            cards[1].priority,cards[2].priority,cards[3].priority,cards[4].priority,cards[5].priority,
            dashou_b_card_count,dashou_a_card_count,dashou_q_card_count,dashou_card_count,card_has_guai_buster))

end

--[[
    -------------------------------------------------------------------
    选卡逻辑相关函数(这一段过于混乱，修改不如重写)
    -------------------------------------------------------------------
]]--

--没决定第一张卡时考虑首红
function choose_buster_card_if_needed()
    if card_to_be_selected[1].index~=0 then
        return
    end

    for i=1,5 do
        if not cards[i].is_used and cards[i].color=="red" and not cards[i].is_dashou then
            determine_card_in_position_(1,cards[i])
            return
        end
    end
    for i=1,5 do
        if not cards[i].is_used and cards[i].color=="red" then
            determine_card_in_position_(1,cards[i])
            return
        end
    end

end
--按优先级选第x张卡
function choose_card_of_index_(x)
    if card_to_be_selected[x].index~=0 then
        return 
    end

    for i=1,5 do
        if not cards[i].is_used then
            determine_card_in_position_(x,cards[i])
            return
        end
    end
end
function determine_card_in_position_(pos, card)
    card_to_be_selected[pos]=card
    card.is_used=true
    return card
end


--带宝具选第t面卡
function select_card_with_np_in_turn_(t)
    get_card_info()
    np_card=Card:new(np_indexs[t],0)
    --平a
    if np_card.index==5 then
        select_card_without_np_in_turn_()
        return
    end
    
    --二面没打手
    if t==2 and battle_2_shuffle=="是" and dashou_card_count==0 and not shuffled then
        shuffle()
        select_card_with_np_in_turn_(t)
        return
    end


    card_to_be_selected={Card:new(0,0),Card:new(0,0),Card:new(0,0)}
    
    --垫刀
    if t==2 and big_enemy_mode[t]~="后补刀" then
        if mode=="绿卡" then
            --假定打手绿卡会打死
            if dashou_card_count-dashou_q_card_count==0 and not shuffled then
                shuffle()
                select_card_with_np_in_turn_(t)
                return
            end
            --降低绿卡优先级
            for i=1,dashou_q_card_count do
                dashou_q_card[i].priority_bak=dashou_q_card[i].priority
                dashou_q_card[i].priority=0
            end
            table.sort(cards)
            --根据设定
            if (big_enemy_mode[t]=="垫一刀" and dashou_card_count-dashou_q_card_count>0)then--垫1张
                determine_card_in_position_(2,np_card)
                --没打手非绿就两张拐
            else
                determine_card_in_position_(3,np_card)--垫2张
            end
            choose_card_of_index_(2)
            choose_card_of_index_(1)
            --还原绿卡
            for i=1,dashou_q_card_count do
                dashou_q_card[i].priority=dashou_q_card[i].priority_bak
            end  
            table.sort(cards)
        else
            determine_card_in_position_(3,np_card)
        end
    else
        --首红与宝具
        if dashou_card_count>=2 then
            --主要是绿卡可优化下
            if dashou_b_card_count>=1 and mode=="绿卡" and t>=3 then--有红
                table.sort(dashou_b_card)
                --忘了这是什么意思
                for i=1,5 do
                    if cards[i].color~="red" and cards[i]<dashou_b_card[1] then
                        card=dashou_b_card[1]
                        break
                    else
                        card=dashou_b_card[dashou_b_card_count]
                    end
                end
                dashou_b_card_count=dashou_b_card_count-1
                determine_card_in_position_(2,np_card)
                determine_card_in_position_(1,card)
            else
                determine_card_in_position_(1,np_card)
            end
        elseif dashou_card_count==1 then--1张打手
            if dashou_b_card_count==1 then
                if not card_has_guai_buster and mode=="绿卡" and t>=3 then--有红没拐红
                    card=dashou_b_card[dashou_b_card_count]
                    dashou_b_card_count=dashou_b_card_count-1
                    determine_card_in_position_(2,np_card)
                    determine_card_in_position_(1,card)
                else
                    determine_card_in_position_(1,np_card)
                end
            else
                if card_has_guai_buster and mode=="绿卡" and t>=3 then
                    determine_card_in_position_(2,np_card)
                else
                    determine_card_in_position_(1,np_card)
                end
            end
        else--0打手
            determine_card_in_position_(1,np_card)
            --绿卡队3t需洗牌
            if sp=="cba" and t==3 and not shuffled then
                if _is_debug then
                    return false
                end
                shuffle()
                select_card_with_np_in_turn_(t)
                return
            end
        end
    end

    table.sort(cards)
    
    if t==3 and np_index_3=="2+1" then
        card_to_be_selected={Card:new(7,0),Card:new(6,0),Card:new(0,0)}
    end
    
    if dashou_card_count<2 then
        choose_buster_card_if_needed()
    end


    for i=3,1,-1 do
        choose_card_of_index_(i)
    end

    logDebug(string.format("select_card_with_np_in_turn_: %d %d %d\n",card_to_be_selected[1].index,card_to_be_selected[2].index,card_to_be_selected[3].index))

    if _is_debug then
        NSLog("test")
        os.exit(0)
    end
    tap_card(card_to_be_selected[1].index,card_to_be_selected[2].index,card_to_be_selected[3].index)

    if is_card_selection_failed() then
        tap_card(card_to_be_selected[1].index,card_to_be_selected[2].index,card_to_be_selected[3].index)
        -- tap_enemy_of_index(big_enemy[t])
        select_card_without_np_in_turn_(t)
    end

    return false
end
--不带宝具选第t面卡
function select_card_without_np_in_turn_(t)
    get_card_info()
    card_to_be_selected={Card:new(0,0),Card:new(0,0),Card:new(0,0)}
    --一面平a
    if t==1 and np_indexs[t]==5 then
        for i=1,5 do
            if cards[i].is_dashou then
                cards[i].priority_bak=cards[i].priority
                cards[i].priority=0
            end
        end
        table.sort(cards)
        choose_card_of_index_(2)
        for i=1,5 do
            if cards[i].is_dashou then
                cards[i].priority=cards[i].priority_bak
            end
        end
        table.sort(cards)
        if dashou_b_card_count>0 then
            determine_card_in_position_(1,dashou_b_card[1])
        end

    else
        --优先选打手首红
        if dashou_card_count>=3 and dashou_b_card_count>0 then
            if dashou_b_card_count==1 then--有红
                determine_card_in_position_(1,dashou_b_card[dashou_b_card_count])

            elseif dashou_b_card_count>=2 then
                temp_card=dashou_b_card[1]

                for i=2,dashou_b_card_count do
                    if dashou_b_card[i]>temp_card then--多打手情况不克制优先
                        temp_card=dashou_b_card[i]
                    end
                end
                determine_card_in_position_(1,temp_card)
            end
            dashou_b_card_count=dashou_b_card_count-1
        elseif dashou_card_count>=1 then--1 2
            if dashou_b_card_count==1 and not card_has_guai_buster then--有红没拐红
                determine_card_in_position_(1,dashou_b_card[dashou_b_card_count])
                dashou_b_card_count=dashou_b_card_count-1
            end
        else
            if sp=="cba" and t==4 and not shuffled then
                shuffle()
                select_card_without_np_in_turn_(t)
                return
            end

        end
    end
    --打手三连不首拐红，首红在上方解决 
    if (dashou_card_count<3 and t~=1) then
        choose_buster_card_if_needed()
    end

    table.sort(cards)
    for i=3,1,-1 do
        choose_card_of_index_(i)
    end
    logDebug(string.format("select_card_without_np_in_turn_: %d %d %d\n",card_to_be_selected[1].index,card_to_be_selected[2].index,card_to_be_selected[3].index))
    if _is_debug then
        os.exit(0)
    end
    if always_np=="是" then
        --仅3面后尝试放宝具
        if t>=3 then
            tap_card(6,7,8)
        else
            tap_card(big_enemy[t])
        end
        tap_enemy_of_index(big_enemy[(t<=3 and {t} or {3})[1]],true)
    end
    
    tap_card(card_to_be_selected[1].index,card_to_be_selected[2].index,card_to_be_selected[3].index)
    return false
end
--猝死等原因导致预设宝具放不了
function is_card_selection_failed()
    mSleep(800)
    x, y = findMultiColorInRegionFuzzy(table.unpack(card_selection_back_points));
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        logDebug("select_card_with_np_in_turn_ fail")
        return true
    end
    return false
end
--1t 2t
function turn_1_2()
    for i=1,2 do
        if get_current_battle()>current_battle then
            goto con_turn_1_2
        end

        logDebug(string.format("current_battle:%d",current_battle))
        --点技能
        tap_enemy_of_index(big_enemy[i])
        use_skill_in_battle_(i)
        tap_attack()
        select_card_with_np_in_turn_(i)
        if is_battle_finished() then
            return
        end

        while get_current_battle()==i do
            tap_attack()
            if always_np=="是" then
                select_card_with_np_in_turn_(i)
            else
                select_card_without_np_in_turn_(i)
            end

            if is_battle_finished() then
                return
            end
        end
        ::con_turn_1_2::
        current_battle=current_battle+1
    end

end
--3面第一次操作
function turn_3()
    logDebug(string.format("current_battle:%d",current_battle))
    tap_enemy_of_index(big_enemy[3])
    use_skill_in_battle_(3)
    tap_attack()

    --选卡
    select_card_with_np_in_turn_(3)
    current_battle=current_battle+1
end
--3面之后操作
function turn_4()
    while not is_battle_finished() do
        logDebug(string.format("current_battle:%d",current_battle))
        tap_attack()
        select_card_without_np_in_turn_(4)
        current_battle=current_battle+1
    end
end
--释放某一回合的技能
function use_skill_in_battle_(battle)
    for _,v in pairs(skills[battle]) do
        local index=get_skill_index_from_string(v)
        local target=get_skill_target_from_string(v)
        if index==nil then
            break
        end
        --logDebug(index)
        if target~="" then
            --logDebug(target[1])
            if string.len(target)==1 then
                use_skill(index,target)
            else
                use_skill(index,string.sub(target,1,1),string.sub(target,2,2))
            end

        else
            use_skill(index)
        end
        wait_skill_finished()
    end
end
function wait_skill_finished()
    mSleep(1500)
    wait_battle_began(2000)
end
--[[
    -------------------------------------------------------------------
    点击类函数
    -------------------------------------------------------------------
]]--
--点index号技能
function use_skill(index,target,target_2)
    --选目标间隔
    local delay_t=400
    --按御主技能
    if index>=10 then
        tap(table.unpack(master_skill_button))
        mSleep(delay_t)
    end

    --按技能
    tap(skill_x[index],skill_y[index],700)

    if not target then
        return
    end

    --1.普通目标
    if not target_2 then
        b_x=skill_target_servant_x
        b_y=skill_target_servant_y[target]
        tap(b_x,b_y,0)
        return
    end

    --2.换人衣服
    b_x=skill_order_change_target_servant_x
    b_y=skill_order_change_target_servant_y[target]
    tap(b_x,b_y,delay_t)

    b_x=skill_order_change_target_servant_x
    b_y=skill_order_change_target_servant_y[target_2]
    tap(b_x,b_y,delay_t)

    tap(table.unpack(skill_order_change_replace_button))
end

--素质三连
function tap_card(a,b,c)
    local waiting_delay=400

    tap(card_x[a],card_y[a],waiting_delay)
    tap(card_x[b],card_y[b],waiting_delay)
    tap(card_x[c],card_y[c],waiting_delay)

    mSleep(waiting_delay)
end

--(返回) 洗牌 (attack)
function shuffle()
    logDebug("shuffled")
    --返回、点、attack
    tap(table.unpack(card_selection_back_button))
    use_skill(12)
    wait_skill_finished()
    tap_attack()

    shuffled=true
end

--点击attack进入选卡界面
function tap_attack()
    tap(table.unpack(attack_button))
    mSleep(1000);
end

--选择敌人
function tap_enemy_of_index(index,is_class)
    index=tonumber(index)  
    if not is_class then
        tap(enemy_x, enemy_y[index])
    else
        tap(enemy_class_x,enemy_class_y[index])
    end
    
end
--点坐标
function tap(x, y, waiting_delay, holding_delay)
    waiting_delay=waiting_delay or 1700
    holding_delay=holding_delay or 50
    touchDown(3, x, y)
    mSleep(holding_delay);
    touchUp(3)
    mSleep(waiting_delay);
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
function get_skill_index_from_string(str)
    local index=string.gsub(str, "%D","")
    return tonumber(index)
end

function get_skill_target_from_string(str)
    local target=string.gsub(str,"%A","")
    return target
end
--[[
    -------------------------------------------------------------------
    流程控制
    -------------------------------------------------------------------
]]--
--当前面数 1-3
function get_current_battle()
    keepScreen(true)
    for i=1,3 do
        x, y = findMultiColorInRegionFuzzy(table.unpack(battle_cn_points[i]));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return i
        end
    end

    keepScreen(false)
    logDebug("error get_current_battle")
    while true do
        if is_battle_finished() then
            return current_battle+1
        end
        toast("无法识别回合数")
        mSleep(5000)
    end
end
--启动前检查防止误启动
function check_misoperation(message)
    if _is_debug then return end
    toast("启动中...")
    mSleep(2500)
    for i=1,#check_misoperation_points do
        x, y = findMultiColorInRegionFuzzy(table.unpack(check_misoperation_points[i]));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            return
        end
    end
    toast(message,3000)
    os.exit()
end


function retry_connection_if_needed()
    keepScreen(false)
    x, y = findMultiColorInRegionFuzzy(table.unpack(lost_connection_points));
    if x ~= -1 and y ~= -1 then  -- 掉线
        tap(table.unpack(connection_retry_button))
        keepScreen(false)
    else
        return
    end
end

--进本
function enter_quest()
    if sp_mode=="自动" or sp_mode=="图片" then
        tap(table.unpack(quest_button))
        logDebug("检查苹果")
        if need_restoring_ap() then
            if fruit=="不吃" then
                logDebug("不吃苹果")
                tap(table.unpack(restore_ap_close_button))
                notifyVibrate(1500)
                lock_screen_if_necessary()
                os.exit()
            end
            if fruit=="铜" then
                tap(table.unpack(fruit_scroll_bar_slot_bottom))
                tap(fruit_x["银"],fruit_y)
            else
                tap(fruit_x[fruit],fruit_y)
            end
            tap(table.unpack(use_fruit_ok_button))
        end
        logDebug("检查助战界面")
        check_support_selection_interface()

        select_support_servant_automatically()
        keepScreen(false)
        if party_index~="当前" then
            logDebug("选择队伍")
            tap(formation_party_selection_button_x,formation_party_selection_button_y[tonumber(party_index)%10+1])
            tap(formation_party_selection_button_x,formation_party_selection_button_y[tonumber(party_index)])
        end

        mSleep(2000)
        tap(table.unpack(start_quest_button))
    end
    logDebug("等待进入关卡")
    wait_battle_began()
end
--等待进入一面
function wait_battle_began(waiting_delay)
    waiting_delay=waiting_delay or 5000
    local c=0
    while true do
        x, y = findMultiColorInRegionFuzzy(table.unpack(attack_points));
        if x ~= -1 and y ~= -1 then  -- attack
            return 
        end
        if waiting_delay~=5000 then -- is waiting skill cast
        else-- is waiting battle start
            if sp_mode=="手动" then
                toast("请选择助战并进入关卡",3000)
                if c%5==0 then
                    notifyVibrate(1000)
                end
            else
                if c%3==0 then
                    logDebug("tap start_quest_button")
                    tap(table.unpack(start_quest_button))
                end
            end
            c=c+1
        end

        mSleep(waiting_delay)
    end
end
function lock_screen_if_necessary()
    if lock_screen_after_finished=="是" then
        _, _, signal = os.execute("activator send libactivator.system.sleepbutton")
        while signal and signal>0 do
            logDebug('failed to lock screen')
            mSleep(1000)
            _, _, signal = os.execute("activator send libactivator.system.sleepbutton")
        end
    end
end
--战斗是否结束
function is_battle_finished()
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

        for i=1,#battle_finished_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(battle_finished_points[i]));
            if x ~= -1 and y ~= -1 then  -- 
                x, y = findMultiColorInRegionFuzzy(table.unpack(rainbow_trophy_points));
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    notifyVibrate(5000)
                    if after_dropped_ce=="停止" then
                        os.exit(0)
                    end
                end
                keepScreen(false)
                return true
            end
        end

        retry_connection_if_needed()
        keepScreen(false)
        mSleep(4000)
    end
end
--退出战斗
function quit_quest()
    x, y = findMultiColorInRegionFuzzy(table.unpack(all_servants_incapacitated_points));
    if x ~= -1 and y ~= -1 then  -- 撤退
        notifyVibrate(3000)
        for i=1,#withdraw_actions do
            tap(table.unpack(withdraw_actions[i]))
        end
        if after_failed=="停止" then
            lock_screen_if_necessary()
            os.exit()
        end
        return
    end
    mSleep(2000)
    --连点三下右下角、下一步
    for _=1,4 do
        tap(table.unpack(bottom_right))
    end
    
    mSleep(1000)
    close_repeat_quest_if_needed()
    
    if times>=2 and sp_mode~="手动" then
        wait_quest_quitted()
    end
end
function close_repeat_quest_if_needed()
    x, y = findMultiColorInRegionFuzzy(table.unpack(repeat_quest_points));
    if x ~= -1 and y ~= -1 then
        tap(table.unpack(repeat_quest_close_button))
    end
end
--等待出本
function wait_quest_quitted()
    while true do
        for i=1,#possible_menu_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(possible_menu_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                return
            end
        end

        x, y = findMultiColorInRegionFuzzy(table.unpack(ce_detail_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            tap(table.unpack(ce_detail_close_button))
            for _=1,2 do
                tap(table.unpack(bottom_right))
            end
        end
        close_repeat_quest_if_needed()
        for i=1,#friend_request_interface_points do
            x, y = findMultiColorInRegionFuzzy(table.unpack(friend_request_interface_points[i]));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                tap(table.unpack(friend_request_close_button))
                break
            end
        end
        tap(table.unpack(blank_area))
        mSleep(5000)
    end
end
--stub
function start_one_mission(t) 
    start_one_quest(t) 
end
function start_one_quest(t)
    logDebug(string.format("times:%d",t))
    local notify=string.format("当前文件: %s 剩余次数: %d",conf_file_name,times-t)
    toast(notify,3000)

    current_battle=1
    enter_quest()

    turn_1_2()
    if not is_battle_finished() then
        turn_3()
        turn_4()
    end

    quit_quest()
end

--
function check_support_selection_interface()
    mSleep(3000)
    x, y = findMultiColorInRegionFuzzy(table.unpack(support_selection_interface_points));
    logDebug("未识别到助战界面")
    local c=0
    while x == -1 and y == -1 do  -- attack
        c=c+1
        if c>5 then
            os.exit(0)
        end
        retry_connection_if_needed()
        mSleep(3000)
        x, y = findMultiColorInRegionFuzzy(table.unpack(support_selection_interface_points));
    end


end

--(is_find, new_start_x)找助战
function find_support_servant_starting_from_(new_start_x)
    --logDebug(new_start_x)
    --找礼装
    local ce_x, ce_y = findMultiColorInRegionFuzzy(ce_points[ce], 80, new_start_x, sp_icon_start_y, sp_icon_end_x, sp_icon_end_y);
    local sp_x, sp_y = nil, nil
    if (ce_x ~= -1 and ce_y ~= -1) or ce=="任意" then  -- 如果找到了礼装
        if sp=="任意" then --任意从者
            if ce=="任意" then
                tap(table.unpack(support_first_slot))
            else
                tap(ce_x,ce_y)
            end
            return true
        end
        if ce=="任意" then --找英灵
            sp_x, sp_y = findMultiColorInRegionFuzzy(support_servant_points[sp], 90, new_start_x, sp_icon_start_y, sp_icon_end_x, sp_icon_end_y);
        else
            sp_x, sp_y = findMultiColorInRegionFuzzy(support_servant_points[sp], 90, ce_x+sp_icon_start_dx, y+sp_icon_start_dy , ce_x+sp_icon_end_dx, y+sp_icon_end_dy);
        end

        if sp_x ~= -1 and sp_y ~= -1 then  -- 如果找到了英灵
            if require_support_from_friends=="是" then
                friend_icon_x, friend_icon_y = findMultiColorInRegionFuzzy(sp_friend_icon_points, 90, sp_x+sp_friend_icon_start_dx, sp_friend_icon_start_y, sp_x+sp_friend_icon_end_dx, sp_friend_icon_end_y);
                if friend_icon_x~=-1 and friend_icon_y~=-1 then  -- 如果找到了
                    tap(sp_x,sp_y)
                    return true
                end
            else
                tap(sp_x,sp_y)
                return true
            end
        end
    end
    if ce_x~=-1 and ce_y ~= -1 then
        return false,ce_x+10 --继续找
    elseif sp_x~=-1 and sp_y ~= -1 then
        return false,sp_x+10 --继续找
    else
        return false --上滑
    end

end

--自动选助战
function select_support_servant_automatically()
    logDebug("选择助战")
    mSleep(2000)
    if sp_class_index and sp_class_index~="当前" then
        tap(support_selection_class_button_x,support_selection_class_button_y[sp_class_index])
    end

    if ce=="任意" and sp=="任意" then
        tap(table.unpack(support_first_slot))
        return
    end

    while true do
        keepScreen(true)
        if sp_mode=="图片" then
            x, y = findImageFuzzy(path.."sp.bmp",60); -- 
            if x ~= -1 and y ~= -1 then            -- 如果找到了
                tap(x,y)
                return
            end
        else
            new_start_x=sp_icon_start_x
            is_find, new_start_x=find_support_servant_starting_from_(new_start_x)
            while (not is_find) and new_start_x do
                is_find, new_start_x=find_support_servant_starting_from_(new_start_x)
            end
            if is_find then
                logDebug("找到助战")
                return
            end
        end
        x, y = findMultiColorInRegionFuzzy(table.unpack(support_scroll_bar_slot_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            x, y = findMultiColorInRegionFuzzy(table.unpack(support_scroll_bar_arrived_bottom_points));
            if x ~= -1 and y ~= -1 then  -- 如果到底了
                update_support_list()
            else
                press_and_move_upward(6)
            end
        else
            update_support_list()
        end

        keepScreen(false)

    end
end

--上滑
function press_and_move_upward(times,x,y)
    x=x or 100 
    y=y or 770
    touchDown(5, x, y)
    mSleep(34);
    local dx=15
    for _=1,times do
        touchMove(5, x+dx, y)
        mSleep(20);
        dx=dx+15
    end
    touchUp(5)

    mSleep(500);
end
--刷新助战
function update_support_list()
    keepScreen(false)
    tap(table.unpack(support_update_list_button))
    x, y = findMultiColorInRegionFuzzy(table.unpack(support_updating_in_succession_warning));
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        mSleep(3000)
        tap(table.unpack(support_updating_in_succession_warning_close_button))
        update_support_list()
        return
    end
    tap(table.unpack(support_update_list_yes_button))
end

--需要吃苹果
function need_restoring_ap()
    x, y = findMultiColorInRegionFuzzy(table.unpack(support_selection_interface_points));
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

function check_version_and_update_if_needed()
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

