--本文件测试中，请勿乱调用
function init_type()
    uint8_t=0
    uint16_t=1
    uint32_t=2
    uint64_t=3
    int8_t=4
    int16_t=5
    int32_t=6
    int64_t=7
    float_t=8
    double_t=9
    custom=10
end
function init_offset()
    level_offset=-0x4
    atk_offset=0x4
    hp_offset=atk_offset+0xc
    max_hp_offset=hp_offset+0x4
    np_offset=max_hp_offset+0x10
    np_threshold_offset=np_offset+0x8
    np_level_offset=np_threshold_offset+0xac
end

function test_444444()
    mem.init("fatego",int32_t)
    n=mem.searchValue(444444)
    candidate={}
    for i=1,n do
        candidate[i]=mem.getResultAddressByIndex(i)
    end
    for i=1,n do
        ro=mem.searchAddress(candidate[i])
        r=mem.searchAddress(candidate[i]+0xa8)
        --NSLog(string.format("%d: 0x%x  %d -> %d",i,candidate[i],ro,r))
        if r==10000 and mem.searchAddress(candidate[i]+0x7c+hp_offset)>0 then
            max_level_ad=candidate[i]+0x7c
            level=mem.searchAddress(max_level_ad+level_offset)
            atk=mem.searchAddress(max_level_ad+atk_offset)
            hp=mem.searchAddress(max_level_ad+hp_offset)
            np=mem.searchAddress(max_level_ad+np_offset)/100
            NSLog(string.format("0x%x:  level:%d atk:%d hp:%d np:%d",max_level_ad,level,atk,hp,np))
        end
    end
end
function test_custom()
    mem.init("fatego",custom)
    mem.searchValue(30,1228)
    --ad=mem.search(30,1392)
    
    mem.changeType(int32_t)
    max_level_ad=mem.getResultAddressByIndex(1)

    NSLog(mem.searchAddress(max_level_ad))

    servant_ad={max_level_ad+0x320,max_level_ad,max_level_ad-0x320}

    NSLog(string.format("ad:0x%x",max_level_ad))
    while true do
        for i=1,3 do
            NSLog("-----------------------")
            atk=mem.searchAddress(servant_ad[i]+atk_offset)
            NSLog(string.format("atk: %d",atk))
            hp=mem.searchAddress(servant_ad[i]+hp_offset)
            NSLog(string.format("hp: %d",hp))
            np=mem.searchAddress(servant_ad[i]+np_offset)
            NSLog(string.format("np: %.2f",np/100))

        end

        for i=0,300 do
            ad=servant_ad[2]+i*0x4
            ret=mem.searchAddress(ad)
            NSLog(string.format("0x%x: %d",ad,ret))
        end
        break

    end
end
function test()
    local oc = require "liboc"
    NSLog=oc.NSLog
    mem=require "libmem"
    init_type()
    init_offset()
    
    NSLog("---------start----------")
    --test_444444()
    test_custom()
    NSLog("------------------------")
    mem.close()
    NSLog("----------exit----------")
    
end


function main()
    test()
end