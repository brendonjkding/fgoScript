--[[
    制作：面包
    本脚本假定你启用了游戏蜂窝的七倍加速
    适用iphone8屏幕大小
    适用于：狂兰、cba、cba。充能衣服。我本人用于刷钢。
    目前实现了一到三面自动加buff和选卡，在三面没狂兰卡时洗一次牌再选卡。
    如果还没有牌，或者没打死需要手动处理
]]--

-- 适用屏幕参数
SCREEN_RESOLUTION="750x1334";
SCREEN_COLOR_BITS=32;
--指令卡选择坐标
card_x=222
card_y={150,400,680,940,1200}--266

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
--根据坐标选卡
function select_card(a_x,a_y,b_x,b_y,c_x,c_y)
    --宝具卡1
    if a_x==nil then
        a_x=542
        a_y=454
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
--判断三面该出什么卡
function select_3t()
    if q_index~=0 then--有绿
        if b_num~=0 then--有红
            select_card(nil,nil,nil,card_y[b_index[1]],nil,card_y[q_index])
        elseif a_index~=0 then--有蓝
            select_card(nil,nil,nil,card_y[a_index],nil,card_y[q_index])
        else
            select_card(nil,nil,nil,card_y[(q_index+1)%5],nil,card_y[q_index])
        end
    elseif b_num~=0 then--有红
        if b_num>=2 then--两红
            select_card(nil,nil,nil,card_y[b_index[2]],nil,card_y[b_index[1]])
        else
            if a_index~=0 then--一红一蓝
                select_card(nil,nil,nil,card_y[a_index],nil,card_y[b_index[1]])
            else--一红
                select_card(nil,nil,nil,card_y[(b_index[1]+1)%5],nil,card_y[b_index[1]])
            end
        end
    elseif a_index~=0 then--只有蓝
        select_card(nil,nil,nil,card_y[(a_index+1)%5],nil,card_y[a_index])
    else
        return 1
    end
    return 0
end

function get_card_info()
    for i=1,5 do
        if compare_color_point(feature_x,feature_y[i],ber_r,ber_g,ber_b,30) then
            is_ber[i]="yes"
        else
            is_ber[i]="no"
        end
        _color[i]=get_color(i)
    end
end
function get_berserker_info()
    for i=1,5 do
        if is_ber[i]=="yes" then
            if _color[i]=="green" then
                q_index=i
            elseif _color[i]=="blue" then
                a_index=i
            else
                b_num=b_num+1
                b_index[b_num]=i
            end
            count=count+1
        end
    end
end
function shuffle()
    mSleep(1184);
    touchDown(4, 426, 1254)
    mSleep(83);
    touchUp(4)

    mSleep(685);
    touchDown(1, 426, 1132)
    mSleep(66);
    touchUp(1)
end
-- 主入口
function main()
    --
    rotateScreen(0);
    buff()--一二面
    
    --获取三面卡信息
    is_ber={}
    _color={}
    get_card_info()


    q_index=0
    a_index=0
    b_index={}
    b_num=0
    count=0
    get_berserker_info()
    
    
    --三面选卡
    local need_shuffle=select_3t()
    if need_shuffle==1 then
        shuffle()
        local temp=select_3t()
        if temp==1 then
            notifyVibrate(500)
        end
    end
    mSleep(1000)
    notifyMessage("制作：面包")
end