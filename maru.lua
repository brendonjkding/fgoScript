UI = {
    { 'DropList{抽友情+搓丸子|抽友情|搓丸子|抽无限池}',      'mode',    '功能：' },
}

dofile("/var/touchelf/scripts/lib_fgo.lua")

function maru_points()
    menu_button={38,1237}
    summor_button={  77,560 }
    strength_button={  86,366 }
    strength_mc_button={ 260,983 }
    strength_mc_interface_points={{ 0x6D6E6E, -8, -187, 0x6B6C6E, -19, -825, 0x1090CE, 534, -817, 0xFE3B95, 522, -817, 0xFF4AD6 }, 90, 30, 425, 583, 1250}

    left_arrow={ 373,52  }
    friend_summon_interface_points={{ 0x1081D2, 1, -173, 0x0B7FE6, -77, -1, 0xE3FA8E, -83, -408, 0xACF14F }, 90, 93, 346, 177, 754}
    summor10_button={ 169,858 }
    summor_again_points={{ 0x10ADE9, 2, 23, 0x1481C0, 2, 118, 0x1374BE, 3, 137, 0x169FE4, 24, 80, 0x005896, -22, 90, 0x054191 }, 90, 25, 725, 71, 862}
    summor_again_button={  54,795 }
    full_points={{ 0xD7D8D8, 0, 12, 0x000000, 1, 18, 0xD4D5D4, -1, 22, 0x000000, -1, 42, 0xDADADA, -88, -37, 0xD5D6D6, 0, -328, 0xD6D7D8, 5, 246, 0xD8D8D9 }, 90, 165, 297, 258, 871}
    close_full_button={ 157,670 }

    slot={465,950}
    first_mc={523,145}
    second_mc={ 496,290 }
    pos_start_x=414
    pos_start_y={75,219}
    pos_end_x=559
    pos_end_y={213,348}
    maru_slot={ 357,214 }
    maru_slot_points={{ 0x414345, -95, -13, 0x525658, -112, -17, 0x343839, -166, -13, 0x525557 }, 90, 341, 203, 507, 220}
    hungry_mc_points={ 0x641072, 2, 19, 0x281A21, 2, 47, 0xE387F7, 0, 71, 0x7A0A8B, 0, 83, 0xECD038 }
    confirm_button={ 134,878 }
    blank={226,1155,500}

end

function infinity_points()
    pool_empty_points={{ 0x6A8BC0, -5, 144, 0x87AADE }, 90, 497, 1109, 502, 1253}
    refresh_button={488,1180}
    refresh_confirm_button{164,879}
    close_button={164,652}
    draw_button={326,409,80}
end


function friend_summon()
    click(table.unpack(menu_button))
    click(table.unpack(summor_button))
    mSleep(3000)
    click(table.unpack(left_arrow))
    while true do
        x, y = findMultiColorInRegionFuzzy(table.unpack(friend_summon_interface_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            click(table.unpack(summor10_button))
            x, y = findMultiColorInRegionFuzzy(table.unpack(full_points));
            if x ~= -1 and y ~= -1 then  -- 爆仓
                click(table.unpack(close_full_button))
                return true
            end

            click(table.unpack(confirm_button))
            mSleep(2000)
            for i=1,5 do
                click(table.unpack(blank))
            end
            x, y = findMultiColorInRegionFuzzy(table.unpack(summor_again_points));
            while x == -1 and y == -1 do  -- 等结果出来
                click(table.unpack(blank))
                mSleep(3000)
                x, y = findMultiColorInRegionFuzzy(table.unpack(summor_again_points));
            end
            click(table.unpack(summor_again_button))
        else
            click(table.unpack(left_arrow))
            --notifyMessage("当前不是友情池")
            --return false
        end
    end
end
function select_mc(x,y)
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

function make_maru()
    click(table.unpack(menu_button))
    click(table.unpack(strength_button))
    click(table.unpack(strength_mc_button))
    x, y = findMultiColorInRegionFuzzy(table.unpack(strength_mc_interface_points));
    if x == -1 and y == -1 then  -- 
        return false
    end

    while true do
        click(table.unpack(maru_slot))
        click(table.unpack(second_mc))
        click(table.unpack(slot))

        x, y = findMultiColorInRegionFuzzy(hungry_mc_points, 90, pos_start_x, pos_start_y[2], pos_end_x, pos_end_y[2]);
        if x == -1 and y == -1 then -- 没同种丸子了
            notifyVibrate(3000)
            return true
        end

        while true do
            --跳过同种
            move_upward(10)
            x, y = findMultiColorInRegionFuzzy(hungry_mc_points, 90, pos_start_x, pos_start_y[1], pos_end_x, pos_end_y[1]);
            while x ~= -1 and y ~= -1 do  -- 如果找到了
                move_upward(10)
                x, y = findMultiColorInRegionFuzzy({ 0xFAF3DE }, 90, 28, 1062, 28, 1062);
                if x ~= -1 and y ~= -1 then  -- 到底没素材了
                    click(table.unpack(privious_button))
                    click(table.unpack(privious_button))
                    return true
                end
                x, y = findMultiColorInRegionFuzzy(hungry_mc_points, 90, pos_start_x, pos_start_y[1], pos_end_x, pos_end_y[1]);
            end

            select_mc()

            --没选上
            x, y = findMultiColorInRegionFuzzy({ 0xD3D4D4 }, 90, 50, 1110, 50, 1110);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                break
            end
        end
        --选底
        move_upward(5,497,1065)
        click(table.unpack(first_mc))

        click(table.unpack(lr_corner))
        click(table.unpack(lr_corner))
        click(table.unpack(confirm_button))
        mSleep(2000)
        for i=1,10 do
            click(table.unpack(blank))
        end
        x, y = findMultiColorInRegionFuzzy(table.unpack(maru_slot_points));
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            return false
        end


    end
end
function main()
    init_points()
    if mode=="搓丸子" or mode=="抽友情" or mode=="抽友情+搓丸子" then
        check_miss_operate("请在主界面启动")

        maru_points()
        toast("提示：使用前请把其它礼装扔仓库里或锁住",4000)
        mSleep(2000)

        if mode=="搓丸子" then
            make_maru()
        elseif mode=="抽友情" then
            friend_summon()
        else
            while true do
                friend_summon()
                r=make_maru()
                if not r then
                    return
                end
            end
        end
    end
    if mode=="抽无限池" then
        while true do
            x, y = findMultiColorInRegionFuzzy(table.unpack(pool_empty_points));
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                click(table.unpack(refresh_button))
                click(table.unpack(refresh_confirm_button))
                mSleep(1000)
                click(table.unpack(close_button))
            end
            for i=1,100 do
                click(table.unpack(draw_button))
            end

        end
    end

end

