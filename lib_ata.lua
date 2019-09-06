--打手取色信息
function init2()
    --阿塔取色 眼睛
    feature_start_x=229
    feature_start_y={82}
    feature_end_x=300
    feature_end_y={143}
    for i=2,5 do
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
    end
    
    dalay_1=12000
    delay_2=8000
    
end


--色卡判断
function get_card_info()
    for i=1,5 do
        x, y = findMultiColorInRegionFuzzy({ 0xFEEDCB, -2, 10, 0xFEECD5, 8, 4, 0x339D00, 19, -1, 0xE3D9B7, 20, 17, 0x1F7A5D }, 80, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            is_dashou[i]=true   -- 点击那个点
        else
            is_dashou[i]=false
        end
        color[i]=get_color(i)
    end

end

--一二面的死操作
function buff(is_debug,need_skip)
    if is_debug or need_skip then
        return
    end
    
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

    mSleep(10082);
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