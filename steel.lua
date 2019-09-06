--[[
    制作：面包
    本脚本假定你启用了游戏蜂窝的七倍加速
    适用iphone8屏幕大小
    适用于：狂兰、cba、cba。充能衣服。我本人用于刷勋章。
    
    角色取色信息
    buff()
    get_card_info()
    msleep
]]--
function init()
-- 适用屏幕参数
    SCREEN_RESOLUTION="750x1334";
    SCREEN_COLOR_BITS=32;
--指令卡选择坐标
    card_x={222,222,222,222,222,542}--1,2,3,4,5,np
    card_y={150,400,680,940,1200,454}--266




--狂兰取色坐标 英灵上不被三种字挡住的点
    feature_x=202
    feature_y={235,501,767,1033,1299}
    ber_r=0x44
    ber_g=0x44
    ber_b=0x77

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

--一二面的死操作
function buff()
     mSleep(607);
    touchDown(5, 290, 844)
    mSleep(67);
    touchUp(5)

    mSleep(684);
    touchDown(2, 474, 124)
    mSleep(17);
    touchMove(2, 474, 124)
    mSleep(32);
    touchUp(2)

    --一面buff
    mSleep(934);
    touchDown(4, 140, 80)
    mSleep(34);
    touchMove(4, 140, 80)
    mSleep(33);
    touchUp(4)

    mSleep(1098);
    touchDown(1, 154, 182)
    mSleep(83);
    touchUp(1)

    mSleep(1051);
    touchDown(6, 146, 414)
    mSleep(82);
    touchUp(6)

    mSleep(419);
    touchDown(3, 290, 306)
    mSleep(16);
    touchMove(3, 290, 306)
    mSleep(17);
    touchMove(3, 290, 306)
    mSleep(32);
    touchUp(3)

    mSleep(1167);
    touchDown(5, 146, 732)
    mSleep(68);
    touchUp(5)

    mSleep(567);
    touchDown(3, 298, 316)
    mSleep(16);
    touchMove(3, 298, 316)
    mSleep(16);
    touchMove(3, 298, 316)
    mSleep(32);
    touchUp(3)
    --一面选卡
    mSleep(1117);
    touchDown(2, 90, 1166)
    mSleep(19);
    touchMove(2, 90, 1166)
    mSleep(16);
    touchMove(2, 90, 1166)
    mSleep(33);
    touchUp(2)

    mSleep(618);
    touchDown(4, 514, 440)
    mSleep(16);
    touchMove(4, 514, 440)
    mSleep(16);
    touchMove(4, 514, 440)
    mSleep(32);
    touchUp(4)

    mSleep(152);
    touchDown(1, 218, 402)
    mSleep(17);
    touchMove(1, 218, 402)
    mSleep(16);
    touchMove(1, 218, 402)
    mSleep(33);
    touchUp(1)

    mSleep(151);
    touchDown(6, 272, 610)
    mSleep(16);
    touchMove(6, 272, 610)
    mSleep(17);
    touchMove(6, 272, 610)
    mSleep(32);
    touchUp(6)
    --二面buff
    mSleep(8587);
    touchDown(5, 154, 264)
    mSleep(31);
    touchMove(5, 154, 264)
    mSleep(17);
    touchMove(5, 154, 264)
    mSleep(32);
    touchUp(5)

    mSleep(1233);
    touchDown(3, 170, 614)
    mSleep(70);
    touchUp(3)

    mSleep(482);
    touchDown(2, 270, 342)
    mSleep(16);
    touchMove(2, 270, 342)
    mSleep(17);
    touchMove(2, 270, 342)
    mSleep(49);
    touchUp(2)

    mSleep(1184);
    touchDown(4, 426, 1254)
    mSleep(83);
    touchUp(4)

    mSleep(685);
    touchDown(1, 422, 1040)
    mSleep(66);
    touchUp(1)

    mSleep(617);
    touchDown(2, 302, 320)
    mSleep(16);
    touchMove(2, 302, 320)
    mSleep(34);
    touchUp(2)
    --二面选卡
    mSleep(1232);
    touchDown(6, 116, 1200)
    mSleep(68);
    touchUp(6)

    mSleep(600);
    touchDown(5, 542, 454)
    mSleep(33);
    touchMove(5, 542, 454)
    mSleep(34);
    touchUp(5)

    mSleep(551);
    touchDown(3, 240, 430)
    mSleep(33);
    touchMove(3, 240, 430)
    mSleep(33);
    touchUp(3)

    mSleep(217);
    touchDown(4, 266, 650)
    mSleep(49);
    touchUp(4)
    --三面buff
    mSleep(9050);
    touchDown(1, 156, 490)
    mSleep(17);
    touchMove(1, 156, 490)
    mSleep(17);
    touchMove(1, 156, 490)
    mSleep(18);
    touchUp(1)

    mSleep(1298);
    touchDown(2, 136, 840)
    mSleep(67);
    touchUp(2)

    mSleep(1216);
    touchDown(6, 150, 960)
    mSleep(66);
    touchUp(6)

    mSleep(636);
    touchDown(5, 306, 316)
    mSleep(64);
    touchUp(5)
    --三面选卡
    mSleep(1469);
    touchDown(3, 88, 1164)
    mSleep(64);
    touchUp(3)

    mSleep(1000);
end

--卡信息初始化
function info_init()
    used={false,false,false,false,false}
    q_index={}
    a_index={}
    b_index={}
    q_num=0
    a_num=0
    b_num=0
    count=0

    is_dashou={}
    color={}
end
--有非打手红卡
function has_cba_b()
    local temp=false
    for i=1,5 do
        if is_dashou[i]==false and color=="red" then
            temp=true
            break
        end
    end
    return temp
end
--
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


--决定x号卡
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
            if not used[i] then
                index[x]=i
                used[i]=true
                return
            end
        end
    end

end

--判断三面该出什么卡
function select_3t()
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
            if has_cba_b==false then--有红没cba红
                index[1]=b_index[b_num]
                b_num=b_num-1
                used[index[1]]=true
            end

        end
        index[2]=6
    else
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
    --notifyMessage(string.format("%d %d %d",index[1],index[2],index[3]))
    select_card(index[1],index[2],index[3])
    return false

end

--判断卡
function get_card_info()
    for i=1,5 do
        if compare_color_point(feature_x,feature_y[i],ber_r,ber_g,ber_b,30) then
            is_dashou[i]=true
        else
            is_dashou[i]=false
        end
        color[i]=get_color(i)
    end
end

--判断打手卡和颜色
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
        end
    end
end
function get_info()
    info_init()
    get_card_info()
    get_dashou_info()
end


--洗牌
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

    --选卡
    mSleep(685);
    touchDown(3, 88, 1164)
    mSleep(64);
    touchUp(3)

    mSleep(2000)
end

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

--4t选卡
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
function select_cba(x)
    index={x,0,0}
    for i=3,1,-1 do
        if index[i]==0 then
            choose_card(i)
        end
    end
    select_card(index[1],index[2],index[3])
end

function battle_ended()
    x, y = findMultiColorInRegionFuzzy({ 0x121014, 2, 9, 0xE9BA24, 1, 16, 0xE3B51E, -12, 16, 0x131215, 13, 16, 0x131115 }, 90, 541, 79, 566, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    end
    return false
end

function click_attack()
    mSleep(1000);
    touchDown(3, 88, 1164)
    mSleep(64);
    touchUp(3)
end

-- 主入口
function main()
    init()
    rotateScreen(0);


    buff()--一二面

    shuffled=false

    -------------------------------------3t
    --获取卡信息
    get_info()


    --notifyMessage(string.format("%s %s, %s %s, %s %s, %s %s, %s %s, %d",is_dashou[1],color[1],is_dashou[2],color[2],is_dashou[3],color[3],is_dashou[4],color[4],is_dashou[5],color[5],count),3000);
    --notifyMessage(string.format("%d %d %d",b_num,a_num,q_num),3000);


    ----[[
    --3t选卡
    local need_shuffle=select_3t()
    ----[[
    if need_shuffle then
        shuffle()
        shuffled=true
        get_info()
        need_shuffle=select_3t()
        if need_shuffle then
            select_cba(6)
        end
    end

    ----------------------4t
    mSleep(14000)
    --

    --4t选卡

    while not battle_ended() do
        --选卡
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
        mSleep(8000)
    end
    quit_battle()
    --]]--
end


