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

--卡色取色坐标 卡上不被英灵挡住的点
    color_x=252
    color_y={72,338,604,873,1145}

    blue_r=0x16
    blue_g=0x45
    blue_b=0xa0
    red_r=0x9d
    red_g=0x18
    red_b=0x18



end
function init_m()
    skills={}
    skills[1]=Split(skill_serial_1," ")
    skills[2]=Split(skill_serial_2," ")
    skills[3]=Split(skill_serial_3," ")
    np_index={}
    np_index[1]=tonumber(np_index_1)+5
    np_index[2]=tonumber(np_index_2)+5
    np_index[3]=tonumber(np_index_3)+5
end

--[[
    -------------------------------------------------------------------
    获取卡信息相关函数
    -------------------------------------------------------------------
]]--

--模糊比较两个点
function compare_color_point(x,y,r,g,b,sim)
    sim=20
    local lr,lg,lb;
    lr,lg,lb = getColorRGB(x,y);
    ----[[
    if math.abs(lr-r) > sim then
        return false;
    end
    if math.abs(lg-g) > sim then
        return false;
    end
    if math.abs(lb-b) > sim then
        return false;
    end
    return true;
end
--判断第i张卡的颜色
function get_color(i)
    if compare_color_point(color_x,color_y[i],blue_r,blue_g,blue_b) then
        return "blue"
    end
    if compare_color_point(color_x,color_y[i],red_r,red_g,red_b) then
        return "red"
    end
    return "green"
end
--卡信息初始化
function info_init()
    --是否已选
    used={false,false,false,false,false}
    --本轮各色色卡的序号
    q_index={}
    a_index={}
    b_index={}
    --本轮各色色卡的数量
    q_num=0
    a_num=0
    b_num=0
    --打手卡数
    count=0

    --是否为打手卡
    is_dashou={}
    --卡色
    color={}
    --是否有cba的红卡
    has_cba_b=false
end
--获取卡色，区分打手与cba 目前逻辑下因打手而异
function get_card_info()
    for i=1,5 do
        color[i]=get_color(i)
    end
end

--提取打手卡信息
function get_dashou_info()
    for i=1,5 do
        if is_dashou[i]==true then
            if color[i]=="green" then
                q_num=q_num+1
                q_index[q_num]=i
            elseif color[i]=="blue" then
                a_num=a_num+1
                a_index[a_num]=i
            else
                b_num=b_num+1
                b_index[b_num]=i
            end
            count=count+1
        else
            if color[i]=="red" then
                has_cba_b=true
            end
        end
    end
end
function get_info()
    info_init()
    get_card_info()
    get_dashou_info()
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
            index[x]=i
            used[i]=true
            return
        end
    end

end


--决定第x张卡
function choose_card(x)
    if q_num>0 then
        if not used[q_index[q_num]] then
            index[x]=q_index[q_num]
            used[q_index[q_num]]=true
            q_num=q_num-1
            return
        end
    elseif b_num>0 then
        if not used[b_index[b_num]] then
            index[x]=b_index[b_num]
            used[b_index[b_num]]=true
            b_num=b_num-1
            return
        end
    elseif a_num>0 then
        if not used[a_index[a_num]] then
            index[x]=a_index[a_num]
            used[a_index[a_num]]=true
            a_num=a_num-1
            return
        end
    else
        for i=1,5 do
            if not used[i] and color[i]=="green" then
                index[x]=i
                used[i]=true
                return
            end
        end
        for i=1,5 do
            if not used[i] and color[i]=="red" then
                index[x]=i
                used[i]=true
                return
            end
        end
        for i=1,5 do
            if not used[i] and color[i]=="blue" then
                index[x]=i
                used[i]=true
                return
            end
        end
    end

end
--
function choose_card_manual(x)
    for i=1,5 do
        if not used[i] and color[i]=="red" then
            index[x]=i
            used[i]=true
            return
        end
    end
    for i=1,5 do
        if not used[i] and color[i]=="blue" then
            index[x]=i
            used[i]=true
            return
        end
    end
    for i=1,5 do
        if not used[i] and color[i]=="green" then
            index[x]=i
            used[i]=true
            return
        end
    end
end

--判断3t该出什么卡
function select_3t(is_debug)
    if count==0 then
        return 1
    end
    index={0,0,0}

    if count>=2 then
        if b_num>=1 then--有红
            index[1]=b_index[b_num]
            b_num=b_num-1
            used[index[1]]=true

            index[2]=6
        else
            index[1]=6
        end
    elseif count==1 then
        if b_num==1 then
            if not has_cba_b then--有红没cba红
                index[1]=b_index[b_num]
                b_num=b_num-1
                used[index[1]]=true

            end
            index[2]=6
        else
            if has_cba_b then
                index[2]=6
            else
                index[1]=6
            end

        end
    else
        if is_debug then
            return false
        end

        return true
    end
    if count==1 then
        choose_first()
    end
    for i=3,1,-1 do
        if index[i]==0 then
            choose_card(i)
        end
    end
    if is_debug then
        notifyMessage(string.format("%d %d %d",index[1],index[2],index[3]))
    else
        select_card(index[1],index[2],index[3])
    end
    return false

end
--3t的操作
function buff_3t(t,is_debug)
    --获取卡信息
    get_info()
    --调试
    if is_debug then
        notifyMessage(string.format("%s %s, %s %s, %s %s, %s %s, %s %s, %d",is_dashou[1],color[1],is_dashou[2],color[2],is_dashou[3],color[3],is_dashou[4],color[4],is_dashou[5],color[5],count),3000);
        notifyMessage(string.format("%d %d %d",b_num,a_num,q_num),3000);
    end


    --3t选卡
    local need_shuffle=select_3t(is_debug)
    ----[[
    if need_shuffle then
        shuffle()
        shuffled=true
        get_info()
        need_shuffle=select_3t(is_debug)
        if need_shuffle then
            select_cba(6)
        end
    end
    mSleep(t)
end



--判断4t...该出什么卡
function select_4t()
    if count==0 then
        return 1
    end
    index={0,0,0}
    if count>=3 then
        if b_num==1 then--有红
            index[1]=b_index[b_num]
            b_num=b_num-1
            used[index[1]]=true
        end
    elseif count>=1 then--1 2
        if b_num==1 then--有红
            if has_cba_b==false then--有红没cba红
                index[1]=b_index[b_num]
                b_num=b_num-1
                used[index[1]]=true
            end
        end

    else
        return true
    end
    if count<=2 then
        choose_first()
    end
    for i=3,1,-1 do
        if index[i]==0 then
            choose_card(i)
        end
    end
    --notifyMessage(string.format("%d %d %d",index[1],index[2],index[3]))
    select_card(index[1],index[2],index[3])
    return false

end
--4t操作
function buff_4t(t,is_debug)
    if is_debug then
        return
    end

    while not battle_ended() do
        --attack
        click_attack()
        get_info()
        need_shuffle=select_4t()
        if need_shuffle then
            if not shuffled then
                shuffle()
                shuffled=true
                get_info()
                need_shuffle=select_4t()
                if need_shuffle then
                    select_cba(0)
                end
            else
                select_cba(0)
            end
        end
        mSleep(t)
    end

end

--无打手卡时选法
function select_cba(x)
    index={x,0,0}
    for i=3,1,-1 do
        if index[i]==0 then
            choose_card(i)
        end
    end
    select_card(index[1],index[2],index[3])
end
--战斗是否结束
function battle_ended()
    x, y = findMultiColorInRegionFuzzy({ 0x121014, 2, 9, 0xE9BA24, 1, 16, 0xE3B51E, -12, 16, 0x131215, 13, 16, 0x131115 }, 90, 541, 79, 566, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    end
    return false
end



--[[
    -------------------------------------------------------------------
    死操作
    -------------------------------------------------------------------
]]--
function select_skill(index,target)
    local delay_i=1500
    local delay_t=1000
    if index>=10 then
        mSleep(delay_t);
        touchDown(5, master_skill_x, master_skill_y)
        mSleep(33);
        touchMove(5, master_skill_x, master_skill_y)
        mSleep(34);
        touchUp(5)
    end
    --notifyMessage(index)
    a_x=skill_x[index]
    a_y=skill_y[index]


    mSleep(delay_i);
    touchDown(5, a_x, a_y)
    mSleep(33);
    touchMove(5, a_x, a_y)
    mSleep(34);
    touchUp(5)

    if not target then
        return
    end
    b_x=servant_x
    b_y=servant_y[target]

    mSleep(delay_t);
    touchDown(3, b_x, b_y)
    mSleep(33);
    touchMove(3, b_x, b_y)
    mSleep(33);
    touchUp(3)
end



--根据序号选卡
function select_card(a,b,c)
    a_x=card_x[a]
    a_y=card_y[a]
    b_x=card_x[b]
    b_y=card_y[b]
    c_x=card_x[c]
    c_y=card_y[c]


    mSleep(600);
    touchDown(5, a_x, a_y)
    mSleep(33);
    touchMove(5, a_x, a_y)
    mSleep(34);
    touchUp(5)

    mSleep(551);
    touchDown(3, b_x, b_y)
    mSleep(33);
    touchMove(3, b_x, b_y)
    mSleep(33);
    touchUp(3)

    mSleep(217);
    touchDown(4, c_x, c_y)
    mSleep(49);
    touchUp(4)
end

--录制获得一二面的死操作
function buff()

end
function buff_manual()
    for i=1,3 do
        
        for j,v in pairs(skills[i]) do
            local index=get_skill_index(v)
            local target=get_skill_target(v)
            if target~="" then
                select_skill(index,target)
            else
                select_skill(index)
            end
        end
        click_attack()
        get_info()
        index={np_index[i],0,0}
        for j=3,2,-1 do
            choose_card_manual(j)
        end
        select_card(index[1],index[2],index[3])
        mSleep(10000)
    end
    while not battle_ended() do
        click_attack()
        get_info()
        index={0,0,0}
        choose_first()
        for j=3,1,-1 do
            choose_card_manual(j)
        end
        select_card(index[1],index[2],index[3])
        mSleep(10000)
    end
    quit_battle()
    
end




--(返回) 洗牌 (attack)
    function shuffle()
        --返回
        mSleep(1184);
        touchDown(4, 35, 1253)
        mSleep(83);
        touchUp(4)

        mSleep(1184);
        touchDown(4, 426, 1254)
        mSleep(83);
        touchUp(4)

        mSleep(685);
        touchDown(1, 426, 1132)
        mSleep(66);
        touchUp(1)

        --attack
        mSleep(685);
        touchDown(3, 88, 1164)
        mSleep(64);
        touchUp(3)

        mSleep(2000)
    end
--连点三下右下角退出战斗
    function quit_battle()
        mSleep(1184);
        touchDown(4, 42, 1143)
        mSleep(83);
        touchUp(4)

        mSleep(1184);
        touchDown(4, 42, 1143)
        mSleep(83);
        touchUp(4)

        mSleep(1184);
        touchDown(4, 42, 1143)
        mSleep(83);
        touchUp(4)
    end
--点击attack进入选卡界面
    function click_attack()
        mSleep(1000);
        touchDown(3, 88, 1164)
        mSleep(64);
        touchUp(3)
        
        mSleep(1000);
    end
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

