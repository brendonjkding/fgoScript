--[[
    制作：面包
    本脚本假定你启用了游戏蜂窝的七倍加速
    适用iphone8屏幕大小
    适用于：阿塔、cba、cba。充能衣服。我本人用于刷勋章。
    
    
]]--
function init()
-- 适用屏幕参数
SCREEN_RESOLUTION="750x1334";
SCREEN_COLOR_BITS=32;
--指令卡选择坐标
card_x={222,222,222,222,222,542}--1,2,3,4,5,np
card_y={150,400,680,940,1200,454}--266




--阿塔取色 眼睛
feature_start_x=229
feature_start_y={82}
feature_end_x=300
feature_end_y={143}

--卡色取色坐标 卡上不被英灵挡住的点
color_x=252
color_y={72,338,604,873,1145}

blue_r=0x16
blue_g=0x45
blue_b=0xa0
red_r=0x9d
red_g=0x18
red_b=0x18

--战斗结束取色
end_x=643
end_y=125
end_r=0xcf
end_g=0x93
end_b=0x10

    for i=2,5 do
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
    end
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
    mSleep(890);
    touchDown(4, 278, 842)
    mSleep(82);
    touchUp(4)

    mSleep(568);
    touchDown(5, 400, 104)
    mSleep(64);
    touchUp(5)

    mSleep(919);
    touchDown(2, 140, 284)
    mSleep(33);
    touchMove(2, 140, 284)
    mSleep(48);
    touchUp(2)

    mSleep(1135);
    touchDown(1, 148, 394)
    mSleep(50);
    touchMove(1, 148, 394)
    mSleep(48);
    touchUp(1)

    mSleep(369);
    touchDown(6, 284, 314)
    mSleep(17);
    touchMove(6, 284, 314)
    mSleep(16);
    touchMove(6, 284, 314)
    mSleep(17);
    touchMove(6, 284, 314)
    mSleep(48);
    touchUp(6)

    mSleep(1336);
    touchDown(3, 138, 728)
    mSleep(64);
    touchUp(3)

    mSleep(536);
    touchDown(6, 304, 334)
    mSleep(64);
    touchUp(6)

    mSleep(3585);
    touchDown(4, 64, 1138)
    mSleep(67);
    touchUp(4)

    mSleep(1033);
    touchDown(5, 258, 426)
    mSleep(84);
    touchUp(5)

    mSleep(150);
    touchDown(2, 464, 456)
    mSleep(16);
    touchMove(2, 464, 456)
    mSleep(17);
    touchMove(2, 464, 456)
    mSleep(17);
    touchMove(2, 464, 456)
    mSleep(32);
    touchUp(2)

    mSleep(135);
    touchDown(1, 228, 668)
    mSleep(33);
    touchMove(1, 228, 668)
    mSleep(17);
    touchMove(1, 228, 668)
    mSleep(16);
    touchUp(1)

    mSleep(10584);
    touchDown(3, 410, 1246)
    mSleep(34);
    touchMove(3, 410, 1246)
    mSleep(32);
    touchUp(3)

    mSleep(535);
    touchDown(6, 418, 1034)
    mSleep(33);
    touchMove(6, 418, 1034)
    mSleep(33);
    touchUp(6)

    mSleep(401);
    touchDown(4, 290, 340)
    mSleep(33);
    touchMove(4, 290, 340)
    mSleep(32);
    touchUp(4)

    mSleep(1450);
    touchDown(5, 150, 608)
    mSleep(34);
    touchMove(5, 150, 608)
    mSleep(17);
    touchMove(5, 150, 608)
    mSleep(32);
    touchUp(5)

    mSleep(568);
    touchDown(4, 260, 324)
    mSleep(65);
    touchUp(4)

    mSleep(1451);
    touchDown(2, 154, 500)
    mSleep(83);
    touchUp(2)

    mSleep(1617);
    touchDown(1, 144, 70)
    mSleep(52);
    touchMove(1, 144, 70)
    mSleep(14);
    touchUp(1)

    mSleep(1602);
    touchDown(3, 96, 1180)
    mSleep(50);
    touchMove(3, 96, 1180)
    mSleep(16);
    touchMove(3, 96, 1180)
    mSleep(17);
    touchUp(3)

    mSleep(1783);
    touchDown(6, 492, 420)
    mSleep(50);
    touchMove(6, 492, 420)
    mSleep(49);
    touchUp(6)

    mSleep(152);
    touchDown(5, 266, 410)
    mSleep(16);
    touchMove(5, 266, 410)
    mSleep(16);
    touchMove(5, 266, 410)
    mSleep(17);
    touchMove(5, 266, 410)
    mSleep(32);
    touchUp(5)

    mSleep(136);
    touchDown(4, 226, 652)
    mSleep(15);
    touchMove(4, 226, 652)
    mSleep(35);
    touchUp(4)

    mSleep(8082);
    touchDown(2, 122, 934)
    mSleep(51);
    touchUp(2)

    mSleep(817);
    touchDown(1, 296, 322)
    mSleep(33);
    touchMove(1, 296, 322)
    mSleep(49);
    touchUp(1)

    mSleep(2001);
    touchDown(3, 134, 826)
    mSleep(82);
    touchUp(3)

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
    
    is_ata={}
    color={}
end
--有非打手红卡
function has_cba_b()
    local temp=false
    for i=1,5 do
        if is_ata[i]==false and color=="red" then
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
        if not used[i] and color[i]=="red" and not is_ata[i] then
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
        if b_num==1 then--有红
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
    choose_first()
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
        x, y = findMultiColorInRegionFuzzy({ 0xFEEDCB, -2, 10, 0xFEECD5, 8, 4, 0x339D00, 19, -1, 0xE3D9B7, 20, 17, 0x1F7A5D }, 80, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            is_ata[i]=true   -- 点击那个点
        else
            is_ata[i]=false
        end
        color[i]=get_color(i)
    end
    
end

--判断阿塔卡和颜色
function get_ata_info()
    for i=1,5 do
        if is_ata[i]==true then
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

--4t选卡
function select_4t()
    if count==0 then
        return 1
    end
    index={0,0,0}
    if count==3 then
        if b_num==1 then--有红
            index[1]=b_index[b_num]
            b_num=b_num-1
            used[index[1]]=true
        end
    end
    
    if count>=1 then--2 3
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
    
    choose_first()
    for i=3,1,-1 do
        if index[i]==0 then
            choose_card(i)
        end
    end
    --notifyMessage(string.format("%d %d %d",index[1],index[2],index[3]))
    select_card(index[1],index[2],index[3])
    return false
    
end

-- 主入口
function main()
    init()
    rotateScreen(0);
    
    
    buff()--一二面
    
    shuffled=false
    
    -------------------------------------3t
    --获取卡信息
    info_init()
    get_card_info()
    get_ata_info()
    
    
    --notifyMessage(string.format("%s %s, %s %s, %s %s, %s %s, %s %s, %d",is_ata[1],color[1],is_ata[2],color[2],is_ata[3],color[3],is_ata[4],color[4],is_ata[5],color[5],count),3000);
    --notifyMessage(string.format("%d %d %d",b_num,a_num,q_num),3000);
    
    
    ----[[
    --3t选卡
    local need_shuffle=select_4t()
    ----[[
    if need_shuffle then
        shuffle()
        shuffled=true
        info_init()
        get_card_info()
        get_ata_info()
        need_shuffle=select_3t()
    end
    if need_shuffle then
        select_card(6,1,2)
    end
    
    
    ----------------------4t
    mSleep(10000)
    --
    touchDown(3, 455, 834)
    mSleep(64);
    touchUp(3)
    
    mSleep(1184);
    touchDown(4, 455, 834)
    mSleep(83);
    touchUp(4)
    --4t选卡
    battle_ended=compare_color_point(end_x,end_y,end_r,end_g,end_b)
    if not battle_ended then
        --选卡
        mSleep(1000);
        touchDown(3, 88, 1164)
        mSleep(64);
        touchUp(3)
        
        info_init()
        get_card_info()
        get_ata_info()

        need_shuffle=select_4t()
        if need_shuffle then
            if not shuffled then
                shuffle()
                info_init()
                get_card_info()
                get_ata_info()
                need_shuffle=select_4t()
                if need_shuffle then
                    return
                end
            end
        end
                
    end
    --]]--
end


