UI = {
    { 'DropList{抽友情|搓丸子|搓丸子(觉醒)|抽无限池|刷助战|检查更新|测试|关闭}',      'mode',    '功能：' }
}

function init_summon_and_bomb_points()
    menu_button={38,1237}
    summon_button={  77,669 }
    enhance_button={  86,494 }
    enhance_ce_button={ 260,983 }
    enhance_ce_interface_points={{ 0xD3D4D4, -2, 91, 0xD6D8D8, -672, 363, 0x1088C4, -672, 446, 0x0AA2EC, -393, 371, 0x72EFFE, -120, 366, 0xFE49AA }, 90, 30, 65, 702, 511}
    ce_fodder_scroll_bar_arrived_bottom_points={{ 0xFAF3DE }, 90, 28, 1062, 28, 1062}

    summon_interface_left_arrow={ 373,52  }
    friend_summon_interface_points={{ 0x1081D2, 1, -173, 0x0B7FE6, -77, -1, 0xE3FA8E, -83, -408, 0xACF14F }, 90, 93, 346, 177, 754}
    summon_10_button={ 169,858 }
    summon_again_points={{ 0x0DACE6, 48, 72, 0x1D66A9, 0, 128, 0x003787, 40, 142, 0x0670A4, 46, 190, 0x2980CA, 0, 204, 0x17ABE6 }, 90, 27, 688, 75, 892}
    summon_again_button={  54,795 }
    inventory_full_points={{ 0xD7D8D8, 0, 12, 0x000000, 1, 18, 0xD4D5D4, -1, 22, 0x000000, -1, 42, 0xDADADA, -88, -37, 0xD5D6D6, 0, -328, 0xD6D7D8, 5, 246, 0xD8D8D9 }, 90, 165, 297, 258, 871}
    inventory_full_close_button={ 157,670 }

    ce_fodder_slot={465,950}
    first_ce_fodder={523,145}
    second_ce_fodder={ 496,290 }
    ce_fodders_pos_start_x=331
    ce_fodders_pos_start_y={75,219}
    ce_fodders_pos_end_x=559
    ce_fodders_pos_end_y={213,348}
    ce_base_slot={ 357,214 }
    ce_base_slot_points={{ 0x414345, -95, -13, 0x525658, -112, -17, 0x343839, -166, -13, 0x525557 }, 90, 341, 203, 507, 220}
    ce_fodder_selected_points={{ 0xD3D4D4 }, 90, 50, 1110, 50, 1110}
    ce_famine_points={ 0x641072, 2, 19, 0x281A21, 2, 47, 0xE387F7, 0, 71, 0x7A0A8B, 0, 83, 0xECD038 }
    ce_awakening_points={ 0xFDFE3F, 12, 2, 0xF2BA0A, 19, 2, 0xFDFFD3, 21, 81, 0xFDF930, 13, 82, 0xF7BA00, 4, 82, 0xFDFDE2, -6, 48, 0xFAE300, 10, 47, 0xFFFFFF }
    if mode == "搓丸子" then fodder_ce_points=ce_famine_points end
    if mode == "搓丸子(觉醒)" then fodder_ce_points=ce_awakening_points end
    ce_enhance_ok_button={ 134,878 }
    blank_area={226,1155,500}

    check_misoperation_points=possible_menu_points
end

function init_lottery_points()
    reset_points={{ 0x47679D, -8, -2, 0x79A0D3, -19, -2, 0x467CB3, 1, -157, 0x44649D, -9, -157, 0x80A6DA, -19, -158, 0x4880B6 }, 90, 488, 1105, 508, 1263}
    reset_button={488,1180}
    reset_ok_button={164,879}
    reset_finished_popup_points={{ 0xD9D9D9, -8, 164, 0xD5D5D6 }, 90, 161, 586, 169, 750}
    reset_finished_popup_close_button={164,652}
    gift_box_full_points={{ 0xD3D4D4, -1, 161, 0xD5D5D5, 0, 457, 0xD4D4D4, 1, 636, 0xD5D5D6, -1, 68, 0x000000, -8, 80, 0xDADADB, 5, 80, 0xDBDBDB }, 90, 157, 349, 170, 985}
    pool_drained_points={{ 0x636363, 2, 0, 0x636363, 7, 1, 0x666666, 10, 3, 0x606060, 11, 6, 0x5E5E5E, 10, 9, 0x5E5E5E, 8, 11, 0x666666, 4, 12, 0x636363, 0, 12, 0x636363, -4, 11, 0x646464, -7, 9, 0x616161, -8, 6, 0x5C5C5C, -7, 3, 0x626262, -5, 1, 0x626262 }, 90, 339, 817, 358, 829}

    spin_points={{ 0x12CFF2, -3, -41, 0x2782BB, 25, -54, 0x145A94, -20, -452, 0x2095C8, 23, -434, 0x1A74A8 }, 90, 265, 97, 310, 549}
    spin_button={326,409,888}
    spin_unavailable_points={{ 0x066579, 53, 0, 0x0D6577, 30, -34, 0x10516A, 71, -32, 0x114262, 68, -110, 0x052C45, 23, -108, 0x062848, 22, -217, 0x056078, 62, -210, 0x0A5575 }, 90, 239, 191, 310, 408}
    check_misoperation_points={spin_points,spin_unavailable_points}
end
function init_support_points()
    start_quest_points={{ 0xC9D2D3, -23, 35, 0xCBD3D6, 28, 37, 0xF5F5F4, 28, 73, 0xF6F5F5, -26, 77, 0xE4ECEF, -22, 105, 0xDDE1E8, 29, 114, 0xF6F9F7, 0, 147, 0xCDD3D3 }, 90, 21, 1142, 76, 1289}
    check_misoperation_points={support_selection_interface_points}
end

function friend_summon()
    tap(table.unpack(menu_button))
    tap(table.unpack(summon_button))
    mSleep(3000)
    tap(table.unpack(summon_interface_left_arrow))
    while true do
        x, y = findMultiColorInRegionFuzzy(table.unpack(friend_summon_interface_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            tap(table.unpack(summon_10_button))
            x, y = findMultiColorInRegionFuzzy(table.unpack(inventory_full_points));
            if x ~= -1 and y ~= -1 then  -- 爆仓
                tap(table.unpack(inventory_full_close_button))
                return true
            end

            tap(table.unpack(ce_enhance_ok_button))
            mSleep(2000)
            for i=1,5 do
                tap(table.unpack(blank_area))
            end
            x, y = findMultiColorInRegionFuzzy(table.unpack(summon_again_points));
            while x == -1 and y == -1 do  -- 等结果出来
                tap(table.unpack(blank_area))
                mSleep(3000)
                x, y = findMultiColorInRegionFuzzy(table.unpack(summon_again_points));
            end
            tap(table.unpack(return_button))
        else
            tap(table.unpack(summon_interface_left_arrow))
            --notifyMessage("当前不是友情池")
            --return false
        end
    end
end
function select_fodder_ce(x,y)
    local x=510
    local y=150
    touchDown(5, x, y)
    mSleep(1000);
    local dy=0
    local dx=0
    for i=1,10 do
        touchMove(5, x-dx, y+dy)
        mSleep(20);
        dx=dx+82
    end
    for i=1,10 do
        touchMove(5, x-dx, y+dy)
        mSleep(20);
        dx=dx+29
    end
    touchUp(5)
    mSleep(500);
end

function make_bomb()
    tap(table.unpack(menu_button))
    tap(table.unpack(enhance_button))
    tap(table.unpack(enhance_ce_button))
    x, y = findMultiColorInRegionFuzzy(table.unpack(enhance_ce_interface_points));
    if x == -1 and y == -1 then  -- 
        return false
    end

    while true do
        tap(table.unpack(ce_base_slot))
        tap(table.unpack(second_ce_fodder))
        tap(table.unpack(ce_fodder_slot))

        x, y = findMultiColorInRegionFuzzy(fodder_ce_points, 90, ce_fodders_pos_start_x, ce_fodders_pos_start_y[2], ce_fodders_pos_end_x, ce_fodders_pos_end_y[2]);
        if x == -1 and y == -1 then -- 没同种丸子了
            notifyVibrate(3000)
            tap(table.unpack(return_button))
            tap(table.unpack(return_button))
            logDebug("没同种丸子了")
            return true
        end
        times=0
        while true do
            --跳过同种
            press_and_move_upward(10)
            x, y = findMultiColorInRegionFuzzy(fodder_ce_points, 90, ce_fodders_pos_start_x, ce_fodders_pos_start_y[1], ce_fodders_pos_end_x, ce_fodders_pos_end_y[1]);
            while x ~= -1 and y ~= -1 do  -- 如果找到了
                press_and_move_upward(10)
                x, y = findMultiColorInRegionFuzzy(table.unpack(ce_fodder_scroll_bar_arrived_bottom_points));
                if x ~= -1 and y ~= -1 then  -- 到底没素材了
                    tap(table.unpack(return_button))
                    tap(table.unpack(return_button))
                    logDebug("到底没素材了")
                    return true
                end
                x, y = findMultiColorInRegionFuzzy(fodder_ce_points, 90, ce_fodders_pos_start_x, ce_fodders_pos_start_y[1], ce_fodders_pos_end_x, ce_fodders_pos_end_y[1]);
            end
            
            press_and_move_upward(10)
            if times>0 then
                press_and_move_upward(10)
            end
            
            select_fodder_ce()

            --选上了
            x, y = findMultiColorInRegionFuzzy(table.unpack(ce_fodder_selected_points));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                break
            end
            times=times+1
            if times>3 then
                os.exit()
            end
            
        end
        --选底
        press_and_move_upward(5,497,1065)
        tap(table.unpack(first_ce_fodder))

        tap(table.unpack(bottom_right))
        tap(table.unpack(bottom_right))
        tap(table.unpack(ce_enhance_ok_button))
        mSleep(1000)
        for i=1,10 do
            tap(table.unpack(blank_area))
        end
        x, y = findMultiColorInRegionFuzzy(table.unpack(ce_base_slot_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            logDebug("满了一个丸子")
            return false
        end


    end
end
function spin_lottery()
    if tonumber(os.date("%Y"))>=2022 and tonumber(os.date("%m"))>=2 then
        toast("待适配", 3000)
    end

    while true do
        keepScreen(true)
        x, y = findMultiColorInRegionFuzzy(table.unpack(gift_box_full_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            return
        end

        x, y = findMultiColorInRegionFuzzy(table.unpack(spin_unavailable_points));
        if x ~= -1 and y ~= -1 then  -- 按钮灰色
            x, y = findMultiColorInRegionFuzzy(table.unpack(reset_points));
            if x ~= -1 and y ~= -1 then  --有刷新按钮
                -- x, y = findMultiColorInRegionFuzzy(table.unpack(pool_drained_points));
                -- if x ~= -1 and y ~= -1 then  --尺子已抽干
                    tap(table.unpack(reset_button))
                    tap(table.unpack(reset_ok_button))
                    mSleep(3000)
                    x, y = findMultiColorInRegionFuzzy(table.unpack(reset_finished_popup_points));
                    while x == -1 and y == -1 do  -- 没找到刷新完成按钮
                        retry_connection_if_needed()
                        mSleep(3000)
                        x, y = findMultiColorInRegionFuzzy(table.unpack(reset_finished_popup_points));
                    end
                    tap(table.unpack(reset_finished_popup_close_button))
                -- end
            else  -- 无刷新按钮
                return
            end
        end

        for i=1,5 do
            tap(table.unpack(spin_button))
        end
        keepScreen(false)
    end
end
function select_support_and_repeat_until_success()
    while true do
        tap(table.unpack(support_first_slot))
        x, y = findMultiColorInRegionFuzzy(table.unpack(start_quest_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            notifyVibrate(3000)
            break
        end
        update_support_list()
        mSleep(3000)
    end
end

function main()
    if mode=="关闭" then return end
    kernelVersion=io.popen("uname -s")
    kernelVersion=kernelVersion:read("*all")
    if kernelVersion=="Darwin\n" then dofile("/var/touchelf/scripts/lib_fgo.lua")
    else dofile("/mnt/sdcard/touchelf/scripts/lib_fgo.lua") end

    init_basic_variables()
    if mode=="检查更新" then
        check_version_and_update_if_needed()
    end
    if mode=="测试" then 
        rotateScreen(-90)
        press_and_move_upward(30,500,500)
        return
    end

    init_points() 
    if mode=="搓丸子" or mode=="搓丸子(觉醒)" or mode=="抽友情" then
        init_summon_and_bomb_points()
        check_misoperation("请在主界面启动")
        toast("提示：使用前请把其它礼装扔仓库里或锁住",4000)
        mSleep(2000)

        if mode=="搓丸子" or mode=="搓丸子(觉醒)" then
            make_bomb()
        elseif mode=="抽友情" then
            friend_summon()
        end
    end
    if mode=="抽无限池" then
        init_lottery_points()
        check_misoperation("请在抽池子界面启动")
        spin_lottery()
    end
    if mode=="刷助战" then
        init_support_points()
        check_misoperation("请在助战界面启动")
        select_support_and_repeat_until_success()
    end
end

