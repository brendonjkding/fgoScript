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

--阿塔取色

--色卡取色

--战斗结束取色

--下一张卡
function next_card(index)
    local temp=index
    temp=temp+1
    if temp==6 then
        temp=1
    end
    return temp
end

--区域模糊找点列

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
    
end

--判断阿塔卡和颜色
function get_ata_info()
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
    --
    rotateScreen(0);
    
    ----[[
    buff()--一二面
    
    shuffled=0
    
    --获取卡信息
    info_init()
    get_card_info()
    get_ata_info()
    
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
end


