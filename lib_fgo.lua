--[[
    -------------------------------------------------------------------
    初始化数据类函数
    -------------------------------------------------------------------
]]--
function init()
    -- 适用屏幕参数
    SCREEN_RESOLUTION="750x1334";
    SCREEN_COLOR_BITS=32;
    rotateScreen(0);

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
    master_skill_x=418
    master_skill_y=1251

    --从者坐标
    servant_x=281
    servant_y={}
    servant_y["a"]=344
    servant_y["b"]=671
    servant_y["c"]=1011

    --卡色判断区域
    color_start_x=54
    color_start_y={7}
    color_end_x=265
    color_end_y={284}
    for i=2,5 do
        color_start_y[i]=color_start_y[i-1]+268
        color_end_y[i]=color_end_y[i-1]+268
    end
    --切换敌人坐标
    enemy_x=700
    enemy_y={47,305,548}

    --卡信息区域
    feature_start_x=171
    feature_start_y={24}
    feature_end_x=459
    feature_end_y={280}
    for i=2,5 do
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
    end
    --技能释放延迟
    if is_speed_up=="是" then
        delay_=1300
    else
        delay_=3500
    end
    --换人礼装目标坐标
    change_x=388
    change_y={}
    change_y["m"]=139
    change_y["n"]=359
    change_y["o"]=579
    change_y["p"]=799
    change_y["q"]=1019
    change_y["r"]=1239
    --助战礼装特征
    mc_points={}
    mc_points["午餐"]={ 0x67B180, -27, 4, 0xEFEBE2, -7, 64, 0xF3C8BC, -23, 98, 0x493438, 3, 138, 0x67AF82, -6, 131, 0xA0D898, -24, 138, 0xFBFC84, -32, 137, 0xB1F3D5, -26, 141, 0xF5F9BB }
    mc_points["擦汗"]={ 0x7EA75B, 20, -7, 0xF2ECCF, 29, 24, 0xF5D9D8, 22, 61, 0x9A6ACB, 27, 77, 0xCDA49A, 30, 109, 0x597027, 2, 120, 0xA2C24F, 3, 124, 0xEBF1B2, 7, 120, 0xF9FA44 }
    mc_points["qp(任意从者)"]={ 0xBF8E69, 21, 10, 0x435DCB, 2, 44, 0x283B56, 10, 69, 0xF9D9A1, 9, 94, 0x1A1F2B, 3, 131, 0xFDFB5C, -1, 132, 0xB8D55E, 22, 115, 0xD3EEFA }
    mc_points["所长"]={ 0x5F362F, 5, 18, 0xD9A879, 7, 32, 0x63132D, 11, 43, 0x906F5F, 11, 69, 0xF9DEB7, -3, 97, 0xFBCCC5, 18, 125, 0x4E110E, 18, 142, 0xEBAD59, 7, 138, 0xF9F824 }
    mc_points["新所长"]={ 0x372F2F, -19, 12, 0xF1ECE2, -26, 51, 0x89381B, -11, 50, 0x92C37E, -5, 77, 0xFEEEE3, 9, 105, 0x2A2B58, 9, 142, 0x1D3B29, -13, 137, 0xFAFA54, -18, 137, 0xA2C262 }
    mc_points["无限池"]={}
    --助战从者特征
    support_points={}
    support_points["孔明"]={ 0xFAF4D6, -6, 4, 0x716256, -3, 15, 0xFBF5D5, -31, 11, 0xDEC4A2, -33, -59, 0xBFEFD6, 36, -15, 0x4C5D59 }
    support_points["梅林"]={ 0x739EE3, 43, 47, 0x6D4B7C, 46, 66, 0xF3D6D9, 54, 81, 0x1D1B68, 41, 104, 0xAEAAE2, 47, 141, 0xFFF0EF }
    support_points["cba"]={ 0xD099F5, 44, -4, 0xDEC9F4, 45, 26, 0x793561, 45, 41, 0xAF0E19, 28, 51, 0xFEFFE1, 45, 86, 0xB10B12 }
    support_points["狐狸"]={ 0xB18B34, 2, 26, 0xE28875, 8, 49, 0xF7C268, 8, 70, 0xF6E4C4, 13, 98, 0xF9CD76, 13, 111, 0xD07765, 13, 152, 0xFEFFF2 }


    --np_full={false,false,false}

    --苹果坐标
    apple_x={}
    apple_x["彩"]=574
    apple_x["金"]=418
    apple_x["银"]=290
    apple_y=700


    if dashou=="狂兰" then
        color_points={ 0x181830, 6, -5, 0x504477, 13, -11, 0xFD0051, 25, -13, 0x444477, 20, -22, 0xF9004C }
    elseif dashou=="阿塔" then
        color_points={ 0xFEEDCB, -2, 10, 0xFEECD5, 8, 4, 0x339D00, 19, -1, 0xE3D9B7, 20, 17, 0x1F7A5D }
    end

    --初始化队伍信息
    if skill_mode=="满破宝石狂兰wcba充能衣服" then
        init_ber()
    elseif skill_mode=="满破宝石阿塔wcba充能衣服" then
        init_ata()
    elseif skill_mode=="(模板)满破宝石尼托+二号打手+孔明" then
        init_nituo()
    end


    --init_m
    skills={}
    skills[1]=Split(skill_serial_1," ")
    skills[2]=Split(skill_serial_2," ")
    skills[3]=Split(skill_serial_3," ")
    np_index={}
    np_index[1]=tonumber(np_index_1)+5
    np_index[2]=tonumber(np_index_2)+5
    np_index[3]=tonumber(np_index_3)+5
    if mode_=="绿卡" then
        mode="green"
    elseif mode_=="红卡" then
        mode="red"
    else
        mode="blue"
    end

    if shuffle_cloth=="是" then
        shuffled=false
    else
        shuffled=true
    end
    times=tonumber(times)

    init_ob()


    --Debug
    current_turn=1
    logDebug("------------------------------------------------------------")
    is_debug=false
    need_skip=false

end

function init_ata()

    skill_serial_1="7a 4a 3"
    skill_serial_2="11a 6a 5 1"
    skill_serial_3="9a 8"
    np_index_1="1"
    np_index_2="1"
    np_index_3="1"
    big_enemy="1"
    mode_="绿卡"
    shuffle_cloth="是"

end
function init_ber()
    skill_serial_1="7a 4a 2 1"
    skill_serial_2="11a 6a 3"
    skill_serial_3="9a 8 5"
    np_index_1="1"
    np_index_2="1"
    np_index_3="1"
    big_enemy="1"
    mode_="绿卡"
    shuffle_cloth="是"

end
function init_nituo()
    skill_serial_1=skill_serial_1 or ""
    skill_serial_2=skill_serial_2 or ""
    skill_serial_3=skill_serial_3 or ""

    skill_serial_1="9 8 7b 1 "..skill_serial_1
    skill_serial_2="2 "..skill_serial_2

    skill_serial_3=skill_serial_3
    np_index_1="1"
    np_index_2="1"
    np_index_3="2"
    big_enemy="1"
    mode_="红卡"
    shuffle_cloth="否"
end

function init_ob()
    Card={index=0,priority=0}
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
--[[
    -------------------------------------------------------------------
    获取卡信息相关函数
    -------------------------------------------------------------------
]]--

--判断第i张卡的颜色
function get_color(i)
    x, y = findMultiColorInRegionFuzzy({ 0x357FFE, -2, 48, 0x56AFFE, 23, 20, 0xB0834A, 52, 13, 0xFEF9CA, 75, -31, 0x075CFE, 61, 69, 0x55C7FE }, 80, color_start_x, color_start_y[i], color_end_x, color_end_y[i]) 
    if x ~= -1 and y ~= -1 then
        return "blue"
    end
    x, y = findMultiColorInRegionFuzzy({ 0xFE5612, -7, 33, 0xFD6F1A, 2, 71, 0xFF3A1E, 68, 11, 0xFEE13A, 76, 67, 0xFE6B1F }, 80, color_start_x, color_start_y[i], color_end_x, color_end_y[i]) 
    if x ~= -1 and y ~= -1 then
        return "red"
    end
    return "green"
end
--卡信息变量初始化
function info_init()
    --是否已选
    used={false,false,false,false,false}
    --本轮打手各色色卡的序号
    q_index={}
    a_index={}
    b_index={}
    --本轮打手各色色卡的数量
    q_num=0
    a_num=0
    b_num=0
    --打手卡数
    count=0

    --是否为打手卡
    is_dashou={true,true,true,true,true}
    restrain={false,false,false,false,false}
    weak={false,false,false,false,false}
    --卡色
    color={}
    --序号与优先级
    cards={Card:new(1,10),Card:new(2,10),Card:new(3,10),Card:new(4,10),Card:new(5,10)}
    --是否有拐红卡
    has_sup_b=false
end
--提取卡信息
function get_card_info()
    if dashou=="通用" then

        for i=1,5 do
            repeat
                x, y = findMultiColorInRegionFuzzy({ 0xFEFEE6, -1, -16, 0x985598, -6, -28, 0xFEFEED, -5, -35, 0xDE1616, -10, -42, 0xFEFEED }, 90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
                if x ~= -1 and y ~= -1 then  
                    is_dashou[i]=false
                    break
                end
                ----[[
                x, y = findMultiColorInRegionFuzzy({ 0xFFCC77, 24, -3, 0x445555, 18, -17, 0xFFEEDD, 15, -26, 0xD5CCBB, 11, -29, 0xFFEEDD }, 90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
                if x ~= -1 and y ~= -1 then  
                    is_dashou[i]=false
                    break
                end
                --]]--
                ----[[
                x, y = findMultiColorInRegionFuzzy({ 0xFEFEFE, -12, 11, 0xFEEDDC, -20, 8, 0xE09CA9, -26, 17, 0x32339D, -31, 17, 0xA955CB, -36, 17, 0xFEEDDC, -51, 17, 0xC7B2B2 }, 90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
                if x ~= -1 and y ~= -1 then  
                    is_dashou[i]=false
                    break
                end
                --]]--
            until true
            x, y = findMultiColorInRegionFuzzy({ 0xC32823, 1, 13, 0xDD3B35, 0, 8, 0xC11816, 11, 11, 0xF2B16F, 10, 0, 0xF0AF6C, 16, 5, 0xF9E991, 13, 5, 0xF0C567 }, 90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                restrain[i]=true
            end
            x, y = findMultiColorInRegionFuzzy({ 0x0433AE, 2, 0, 0x013FBF, 5, 0, 0x0159DB, 8, 0, 0x0C7DEB, 11, 0, 0x27A8F4, 13, 0, 0x3AC5F9, 13, -11, 0x48DAFD, 13, 11, 0x29ABF5 }, 90, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                weak[i]=true
            end
        end
    else

        for i=1,5 do
            x, y = findMultiColorInRegionFuzzy(color_points, 80, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                is_dashou[i]=true   -- 点击那个点
            else
                is_dashou[i]=false
            end
        end
    end
end

--计算卡优先级
function calculate_priority()
    --色卡权重
    if mode=="green" and current_turn<=3 then
        q_p=3
        b_p=2
        a_p=1
    elseif mode=="blue" then
        a_p=3
        b_p=2
        q_p=1
    else
        b_p=3
        a_p=2
        q_p=1
    end



    for i=1,5 do
        color[i]=get_color(i)

        --克制打手200 打手100 克制拐20 拐10 被克打手5 被克拐1
        if is_dashou[i] then
            if not weak[i] then
                cards[i].priority=100
            else
                cards[i].priority=5
            end
        else
            if weak[i] then
                cards[i].priority=1
            end

        end
        --克制 为两倍
        if restrain[i] then
            cards[i].priority=cards[i].priority*2
        end

        --颜色权重
        if color[i]=="green" then
            if is_dashou[i] then
                q_num=q_num+1
                q_index[q_num]=i
                count=count+1
            end
            cards[i].priority=cards[i].priority+q_p

        elseif color[i]=="blue" then
            if is_dashou[i] then
                a_num=a_num+1
                a_index[a_num]=i
                count=count+1
            end
            cards[i].priority=cards[i].priority+a_p

        elseif color[i]=="red" then
            if is_dashou[i] then

                b_num=b_num+1
                b_index[b_num]=i
                count=count+1
            end
            cards[i].priority=cards[i].priority+b_p
        else
            logDebug("error calculate")

        end

    end

end
function get_info()
    keepScreen(true)
    info_init()
    get_card_info()
    calculate_priority()
    keepScreen(false)
    logDebug(string.format("\n打手:%s %s %s %s %s, \n颜色:%s %s %s %s %s, \n克制:%s %s %s %s %s,\n被克制:%s %s %s %s %s,\n优先:%d %d %d %d %d     \nb:%d a:%d q:%d count:%d      ",is_dashou[1],is_dashou[2],is_dashou[3],is_dashou[4],is_dashou[5],color[1],color[2],color[3],color[4],color[5],restrain[1],restrain[2],restrain[3],restrain[4],restrain[5],weak[1],weak[2],weak[3],weak[4],weak[5],cards[1].priority,cards[2].priority,cards[3].priority,cards[4].priority,cards[5].priority,b_num,a_num,q_num,count))
    table.sort(cards)
end



--[[
    -------------------------------------------------------------------
    选卡逻辑相关函数
    -------------------------------------------------------------------
]]--

--没决定第一张卡时考虑首红
function choose_first()
    if index[1]~=0 then
        return
    end

    local x=1
    for i=1,5 do
        if not used[i] and color[i]=="red" and not is_dashou[i] then
            index[x]=i
            used[i]=true
            return
        end
    end
    for i=1,5 do
        if not used[i] and color[i]=="red" then
            table.remove(b_index,1)
            b_num=b_num-1
            count=count-1
            index[x]=i
            used[i]=true
            return
        end
    end

end
--
function choose_card_priority(x)
    for i=1,5 do
        if not used[cards[i].index] then
            index[x]=cards[i].index
            used[cards[i].index]=true
            return
        end
    end
end



--带宝具选卡
function select_np(t,is_debug)
    np_index_=np_index[t]
    if np_index_==5 then
        select_normal()
        return
    end
    


    index={0,0,0}

    if count>=2 then
        --绿卡模式考虑首红
        if b_num>=1 and mode=="green" and t>=3 then--有红
            index[1]=b_index[b_num]
            b_num=b_num-1

            used[index[1]]=true

            index[2]=np_index_
        else

            index[1]=np_index_

        end
    elseif count==1 then
        if b_num==1 then
            if not has_sup_b and mode=="green" and t>=3 then--有红没拐红
                index[1]=b_index[b_num]
                b_num=b_num-1
                used[index[1]]=true
                index[2]=np_index_
            else
                index[1]=np_index_
            end


        else
            if has_sup_b and mode=="green" and t>=3 then
                index[2]=np_index_
            else
                index[1]=np_index_
            end

        end
    else
        index[1]=np_index_
        --绿卡队3t需洗牌
        if sp=="cba" and t==3 and not shuffled then
            if is_debug then
                return false
            end
            return true
        end
    end
    choose_first()

    for i=3,1,-1 do
        if index[i]==0 then
            choose_card_priority(i)
            --[[
            if mode=="green" then
                choose_card_green(i)
            elseif mode=="red" then
                choose_card_red(i)
            else
                choose_card_blue(i)
            end
            ]]--
        end
    end


    logDebug(string.format("select_np: %d %d %d\n",index[1],index[2],index[3]))
    if is_debug then
        return
    end
    select_card(index[1],index[2],index[3])

    if select_fail() then
        select_card(index[1],index[2],index[3])
        select_normal()
    end
    

    return false

end
--不带宝具选卡
function select_normal(t,is_debug)
    index={0,0,0}
    if count>=3 then
        if b_num>=1 then--有红
            index[1]=b_index[b_num]
            b_num=b_num-1
            used[index[1]]=true
        end
    elseif count>=1 then--1 2
        if b_num==1 then--有红
            if has_sup_b==false then--有红没拐红
                index[1]=b_index[b_num]
                b_num=b_num-1
                used[index[1]]=true
            end
        end
    else
        if sp=="cba" and t==4 and not shuffled then
            return true
        end

    end
    choose_first()

    for i=3,1,-1 do
        if index[i]==0 then
            choose_card_priority(i)
            --choose_card_red(i)
        end
    end
    logDebug(string.format("select_normal: %d %d %d\n",index[1],index[2],index[3]))
    if is_debug then
        return
    end
    select_card(index[1],index[2],index[3])
    return false

end
--1t 2t
function turn_1_2(is_debug,need_skip)
    for i=1,2 do
        logDebug(string.format("current_turn:%d",current_turn))
        --点技能
        click_skills(i)
        check_np()
        click_attack()
        get_info()
        select_np(i)
        if battle_ended() then
            return
        end

        while get_current_turn() ==i do
            click_attack()
            get_info()
            select_normal(i)
            if battle_ended() then
                return
            end

        end
        current_turn=current_turn+1

    end

end
--3t的操作
function turn_3(is_debug)
    if not is_debug then
        click_enemy(big_enemy)
    end
    logDebug(string.format("current_turn:%d",current_turn))
    click_skills(3)
    check_np()
    click_attack()
    --获取卡信息
    get_info()

    --3t选卡
    local need_shuffle=select_np(3,is_debug)
    ----[[
    if need_shuffle then
        shuffle()
        get_info()
        select_np(3,is_debug)


    end
    current_turn=current_turn+1
    --wait_attack_end()

end




--4t操作
function turn_4(is_debug)
    if is_debug then
        return
    end

    while not battle_ended() do
        logDebug(string.format("current_turn:%d",current_turn))
        --attack
        click_attack()
        get_info()
        need_shuffle=select_normal(4)
        if need_shuffle then
            shuffle()
            shuffled=true
            get_info()
            need_shuffle=select_normal(4)
        end
        current_turn=current_turn+1
    end

end






--[[
    -------------------------------------------------------------------
    点击类函数
    -------------------------------------------------------------------
]]--
--点技能
function select_skill(index,target,target_2)

    --选目标间隔
    local delay_t=400
    --按御主技能
    if index>=10 then
        touchDown(5, master_skill_x, master_skill_y)
        mSleep(33);
        touchMove(5, master_skill_x, master_skill_y)
        mSleep(34);
        touchUp(5)
        mSleep(delay_t)
    end

    a_x=skill_x[index]
    a_y=skill_y[index]

    --按技能
    touchDown(5, a_x, a_y)
    mSleep(33);
    touchMove(5, a_x, a_y)
    mSleep(34);
    touchUp(5)

    if not target then
        mSleep(delay_)
        return
    end

    mSleep(delay_t)

    --1.普通目标
    if not target_2 then
        b_x=servant_x
        b_y=servant_y[target]
        click(b_x,b_y,0)
        mSleep(delay_)
        return
    end

    --2.换人衣服
    b_x=change_x
    b_y=change_y[target]
    click(b_x,b_y,delay_t)

    b_x=change_x
    b_y=change_y[target_2]
    click(b_x,b_y,delay_t)

    click(100,664)

    mSleep(delay_)
end



--素质三连
function select_card(a,b,c)
    local d=400

    click(card_x[a],card_y[a],d)
    click(card_x[b],card_y[b],d)
    click(card_x[c],card_y[c],d)

    mSleep(d)
end
--点某一回合的技能
function click_skills(t)
    for j,v in pairs(skills[t]) do
        local index=get_skill_index(v)
        local target=get_skill_target(v)
        if index==nil then
            break
        end
        --logDebug(index)
        if target~="" then
            --logDebug(target[1])
            if string.len(target)==1 then
                select_skill(index,target)
            else
                select_skill(index,string.sub(target,1,1),string.sub(target,2,2))
            end

        else
            select_skill(index)
        end
    end
end



--(返回) 洗牌 (attack)
function shuffle()
    logDebug("shuffled")
    --返回
    click(35,1253)

    select_skill(12)

    click_attack()

    shuffled=true

end
--退出战斗
function quit_battle()
    x, y = findMultiColorInRegionFuzzy({ 0x7632D8, 19, 9, 0x77E890, 26, 3, 0xF9EAC0, 15, -7, 0xE171A0, 13, 3, 0xF1F9F9 }, 90, 602, 963, 628, 979);
    if x ~= -1 and y ~= -1 then  -- 撤退
        click(416,338)
        click(378,914)
        click(165,667)
        return
    end
    --连点三下右下角
    click(42,1143)
    click(42,1143)
    click(42,1143)
    --下一步
    click(43,1660)
    --不申请
    click(106,340)
    if times>=2 and sp_mode=="自动" then
        wait_exit_mission()
    end
    if times==1 then
        notifyMessage("感谢使用")
    end

end
--点击attack进入选卡界面
function click_attack()
    click(88,1164)
    mSleep(2000);
end

--选择敌人
function click_enemy(index)
    index=tonumber(index)
    click(enemy_x, enemy_y[index])
end
--点坐标
function click(x,y,t)
    touchDown(3, x, y)
    mSleep(64);
    touchUp(3)
    t=t or 1500

    mSleep(t);
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
--当前回合(面)
function get_current_turn()
    keepScreen(true)
    if server=="国服" then
        x, y = findMultiColorInRegionFuzzy({ 0xE1E1E1, 2, 3, 0xF9F9F8, 3, 5, 0xFEFFFE, -1, 5, 0xEFEFEF, -6, 5, 0xEFEFEF, -11, 5, 0xEFEFEF }, 90, 716, 908, 730, 913);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 1
        end
        x, y = findMultiColorInRegionFuzzy({ 0xE9E9E9, 1, 5, 0xF5F5F5, 1, 8, 0xF3F3F3, -3, 10, 0xF8F8F7, -8, 6, 0xFDFEFD, -15, 0, 0xF7F7F7, -16, 7, 0xE6E6E6 }, 90, 714, 905, 731, 915);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 2
        end
        x, y = findMultiColorInRegionFuzzy({ 0xEFEFEF, 1, 5, 0xF4F4F4, -1, 9, 0xF8F8F7, -7, 4, 0xE8E8E8, -12, 10, 0xF9FAF9, -16, 4, 0xE9E9E9, -14, 0, 0xD7D7D7 }, 90, 714, 905, 731, 915);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 3
        end
    --台服
    else
        x, y = findMultiColorInRegionFuzzy({ 0xDDDDDD, 4, 0, 0xDDDDDD, 11, 0, 0xDDDDDD, 13, 0, 0xDBDBDB, 13, -3, 0x818181 }, 90, 717, 907, 730, 910);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 1
        end
        x, y = findMultiColorInRegionFuzzy({ 0xCCCCCC, 0, -7, 0xCDCDCD, 5, -4, 0x888888, 13, 2, 0xEAEAEA, 16, 0, 0xE5E5E5, 12, -6, 0xEFEFEF, 16, -6, 0x878787 }, 90, 715, 905, 731, 914);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 2
        end
        x, y = findMultiColorInRegionFuzzy({ 0xE2E2E2, -4, 3, 0x959595, 1, 8, 0xF2F2F2, 6, 3, 0x636363, 6, 6, 0xEAEAEA, 10, 7, 0xD5D5D5, 11, -1, 0xCECECE }, 90, 714, 905, 729, 914);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            keepScreen(false)
            return 3
        end
    end
    keepScreen(false)
    logDebug("error get_current_turn")
end
--等待进入一面
function wait_battle_start()
    while true do
        x, y = findMultiColorInRegionFuzzy({ 0xFEDF6A, 0, 25, 0xEAEAEA, 39, 103, 0x0061C1, 30, 112, 0x998974, 23, 121, 0x0E49A3 }, 90, 3, 980, 180 , 1213);
        if x ~= -1 and y ~= -1 then  -- attack
            return 
        end
        if sp_mode=="手动" then
            toast("请选择礼装并进本",3000)
        end

        mSleep(5000)
    end
end
--战斗是否结束
function battle_ended()
    local count=0
    while true do
        count=count+1
        if count>=10 then
            notifyVibrate(1500)
        end

        keepScreen(true)
        x, y = findMultiColorInRegionFuzzy({ 0xB7A48B, -13, -80, 0xBFAF94, 18, -136, 0x9D8E77, -7, -246, 0xFBD865, -9, 5, 0xBFAB91 }, 90, 29, 1014, 60, 1265);
        if x ~= -1 and y ~= -1 then  -- 出现attack没结束
            keepScreen(false)
            return false
        end

        x, y = findMultiColorInRegionFuzzy({ 0x48A9C3, -16, 0, 0x0209AF, -15, 35, 0x006402, -2, 33, 0x50E35B, -2, 39, 0x6BE670 }, 90, 291, 595, 307, 634);
        if x ~= -1 and y ~= -1 then  -- 出现羁绊则结束
            keepScreen(false)
            return true
        end
        x, y = findMultiColorInRegionFuzzy({ 0x7632D8, 19, 9, 0x77E890, 26, 3, 0xF9EAC0, 15, -7, 0xE171A0, 13, 3, 0xF1F9F9 }, 90, 602, 963, 628, 979);
        if x ~= -1 and y ~= -1 then  -- 战斗失败
            keepScreen(false)
            return true
        end
        keepScreen(false)
        mSleep(4000)
    end
end

--防止误启动
function check()
    if sp_mode=="手动" then
        return
    end

    x, y = findMultiColorInRegionFuzzy({ 0xE8C17B, 18, 0, 0xFBF8F4, 17, -6, 0xF5E9DC, 17, 8, 0xF7E7D3, 26, 8, 0xF0EDA0, 27, 1005, 0xD6D6D8, 29, 1129, 0xD0D2D3 }, 90, 9, 166, 38, 1301);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return
    end
    toast("请把关卡放在第一个")
    os.exit()
end


--进本
function enter_mission()
    if sp_mode=="自动" then
        click(563,999)
        if need_apple() then
            if apple=="不吃" then
                click(100,678)
                os.exit()
            end
            click(apple_x[apple],apple_y)
            click(165,863)
        end

        select_support()
        keepScreen(false)
        mSleep(2000)
        click(39,1240)
    end
    wait_battle_start()
end
--等待出本
function wait_exit_mission()
    while true do
        x, y = findMultiColorInRegionFuzzy({ 0xE8C17B, 18, 0, 0xFBF8F4, 17, -6, 0xF5E9DC, 17, 8, 0xF7E7D3, 26, 8, 0xF0EDA0, 27, 1005, 0xD6D6D8, 29, 1129, 0xD0D2D3 }, 90, 9, 166, 38, 1301);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            return
        end
        click(300,150)
        mSleep(5000)
    end
end
--自动选助战
function select_support()
    mSleep(1500)
    while true do
        keepScreen(true)
        --pos-1
        x, y = findMultiColorInRegionFuzzy(mc_points[mc], 80, 288, 23, 588, 232);
        if x ~= -1 and y ~= -1 then  -- 如果找到了礼装
            if mc=="qp(任意从者)" then
                touchDown(0, x, y);   -- 点击那个点
                touchUp(0);
                mSleep(1000)
                return
            end

            x, y = findMultiColorInRegionFuzzy(support_points[sp], 80, x, y-60 , x+174, x+155);
            if x ~= -1 and y ~= -1 then  -- 如果找到了英灵
                if sp=="cba" then --cba技能是否满了
                    --notifyMessage(string.format("%d %d",x,y))


                    xx, yy = findMultiColorInRegionFuzzy({ 0xFEFFFE, -1, 2, 0xFEFFFE, -9, 3, 0xFEFFFE, -11, 15, 0xFEFFFE, -5, 11, 0xFEFFFE, -3, 19, 0xFEFFFE, 3, 15, 0xFEFFFE }, 80, x-87, 1021, x-13, 1082);
                    if xx~=-1 and yy~=-1 then  -- 如果找到了
                        touchDown(0, x, y);   -- 点击那个点
                        touchUp(0);
                        mSleep(1000)
                        return
                    end
                else--其它直接选
                    touchDown(0, x, y);   -- 点击那个点
                    touchUp(0);
                    mSleep(1000)
                    return
                end
            end
        end
        --pos-2
        x, y = findMultiColorInRegionFuzzy(mc_points[mc], 80, 4, 32, 292, 236);
        if x ~= -1 and y ~= -1 then  -- 如果找到了礼装
            if mc=="qp(任意从者)" then
                touchDown(0, x, y);   -- 点击那个点
                touchUp(0);
                mSleep(1000)
                return
            end

            x, y = findMultiColorInRegionFuzzy(support_points[sp], 80, x, y-60 , x+174, x+155);
            if x ~= -1 and y ~= -1 then  -- 如果找到了英灵
                if sp=="cba" then --cba技能是否满了
                    --notifyMessage(string.format("%d %d",x,y))


                    xx, yy = findMultiColorInRegionFuzzy({ 0xFEFFFE, -1, 2, 0xFEFFFE, -9, 3, 0xFEFFFE, -11, 15, 0xFEFFFE, -5, 11, 0xFEFFFE, -3, 19, 0xFEFFFE, 3, 15, 0xFEFFFE }, 80, x-87, 1021, x-13, 1082);
                    if xx~=-1 and yy~=-1 then  -- 如果找到了
                        touchDown(0, x, y);   -- 点击那个点
                        touchUp(0);
                        mSleep(1000)
                        return
                    end
                else--其它直接选
                    touchDown(0, x, y);   -- 点击那个点
                    touchUp(0);
                    mSleep(1000)
                    return
                end
            end
        end
        keepScreen(false)

        move_support()
        x, y = findMultiColorInRegionFuzzy({ 0xF7F8FB, 21, 0, 0xEAEBF0 }, 90, 24, 1292, 45, 1292);
        if x ~= -1 and y ~= -1 then  -- 如果到底了
            refresh_support()
        end

    end

end
--助战列表小幅上移
function move_support()
    touchDown(5, 100, 770)
    mSleep(34);

    local dx=15
    for i=1,5 do
        touchMove(5, 100+dx, 770)
        mSleep(20);
        dx=dx+15
    end

    touchUp(5)

    mSleep(1000);
end
--刷新助战
function refresh_support()
    click(612,881)
    x, y = findMultiColorInRegionFuzzy({ 0x000000, -7, 13, 0xD9DAD9, 5, 18, 0xDADBDA, -3, 26, 0x000000, 1, 33, 0xD7D7D7 }, 90, 157, 646, 169, 679);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        mSleep(8000)
        click(169,672)
        refresh_support()
        return
    end
    click(162,870)
end
--无效
function check_np()

end
--需要吃苹果
function need_apple()
    x, y = findMultiColorInRegionFuzzy({ 0xDA6888, -31, 24, 0x6E46E3, -9, 28, 0xF9F8F5, -1, 49, 0x5DD7B5, -168, 36, 0xFEFF9B, -344, 30, 0x414E57 }, 90, 231, 361, 575, 410);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    end
    return false
end
--select_np失败
function select_fail()
    mSleep(800)
    x, y = findMultiColorInRegionFuzzy({ 0x00AFE0, 0, 23, 0xE0F2F8, 0, 29, 0x329AC8, 0, 36, 0xEDFAFF, 0, 41, 0xFEFFFE, 1, 54, 0x1C5495, 1, 57, 0xFDFEFF }, 90, 37, 1205, 38, 1262);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        logDebug("select_np fail")
        return true
    end
    return false
end

