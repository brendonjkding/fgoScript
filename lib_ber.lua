--打手取色信息
function init2()
    --狂兰取色
    feature_start_x=245
    feature_start_y={107}
    feature_end_x=315
    feature_end_y={155}
    for i=2,5 do
        feature_start_y[i]=feature_start_y[i-1]+268
        feature_end_y[i]=feature_end_y[i-1]+268
    end
    --选完卡后的等待时间 可根据宝具长度调整
    dalay_1=14000
    delay_2=8000
    
end


--色卡判断
function get_card_info()
    for i=1,5 do
        x, y = findMultiColorInRegionFuzzy({ 0x181830, 6, -5, 0x504477, 13, -11, 0xFD0051, 25, -13, 0x444477, 20, -22, 0xF9004C }, 80, feature_start_x, feature_start_y[i], feature_end_x, feature_end_y[i]);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            is_dashou[i]=true   -- 点击那个点
        else
            is_dashou[i]=false
        end
    end
end

--一二面的死操作
function buff(is_debug,need_skip)
    if is_debug or need_skip then
        return
    end
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