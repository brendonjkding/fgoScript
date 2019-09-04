--[[
    制作：面包
    本脚本假定你启用了游戏蜂窝的七倍加速
    适用iphone8屏幕大小
    适用于：阿塔、cba、cba。充能衣服。我本人用于刷勋章。
    
    
]]--
-- 适用屏幕参数
SCREEN_RESOLUTION="750x1334";
SCREEN_COLOR_BITS=32;
--指令卡选择坐标
card_x=222
card_y={150,400,680,940,1200}--266

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
function init()
    for i=2,5 do
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
    end
end
--下一张卡
function next_card(index)
    local temp=index
    temp=temp+1
    if temp==6 then
        temp=1
    end
    return temp
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

--判断第i张卡的颜色

--根据坐标选卡
function select_card(a_x,a_y,b_x,b_y,c_x,c_y)
    --宝具卡1
    if a_y==nil then
        a_x=542
        a_y=454
    else
        a_x=card_x
    end
    --普通指令卡x
    b_x=card_x
    c_x=card_x

    
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

--判断三面该出什么卡
function select_3t()
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
    
    mSleep(1000)
end

--4t选卡
function select_4t()
end

-- 主入口
function main()
    init()
    --
    rotateScreen(0);
    
    ----[[
    buff()--一二面
    
    shuffled=0
    
    --获取卡信息
    info_init()
    get_card_info()
    get_ata_info()
    notifyMessage(string.format("%s %s, %s %s, %s %s, %s %s, %s %s, ",is_ata[1],color[1],is_ata[2],color[2],is_ata[3],color[3],is_ata[4],color[4],is_ata[5],color[5]),7000);
    --[[
    --3t选卡
    local need_shuffle=select_3t()
    if need_shuffle==1 then
        shuffle()
        shuffled=1
        info_init()
        get_card_info()
        get_ata_info()
        need_shuffle=select_3t()
    end
    if need_shuffle==1 then
        return
    end
    ]]--
end


