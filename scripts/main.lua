UI = {
    { 'InputBox{}',             'conf_file_name',    '保存文件名：' },
    { 'TextView{输入信息运行后会生成新文件，再去直}' },
    { 'TextView{接运行生成的新文件。}' },

    { 'TextView{}' },
    { 'DropList{手动|自动}', 'sp_mode', '助战选择：' },
    { 'TextView{如手动选助战，则无视接下来两项}' },
    { 'DropList{新午餐|新qp|新所长|擦汗|满破宝石|任意}', 'ce', '礼装：' },
    { 'DropList{C呆|孔明|cba|梅林|狐狸|花嫁|任意}', 'sp', '从者：' },
    { 'DropList{否|是}', 'require_support_from_friends', '仅选择好友：' },
    { 'TextView{}' },
    
    { 'TextView{}' },
    { 'TextView{技能格式：从者1-9，御主10-12，}' },
    { 'TextView{释放目标为abc、mnopqr(换人)}' },
    { 'TextView{示例：9 8 7b 1}' },

    { 'InputBox{}',             'skill_serial_1',    '1t技能：' },
    { 'InputBox{}',             'skill_serial_2',    '2t技能：' },
    { 'InputBox{}',             'skill_serial_3',    '3t技能：' },
    { 'TextView{}' },
    { 'TextView{每t释放的宝具(0代表平a)：}' },
    { 'DropList{1|2|3|0}', 'np_index_1','1t宝具：'},
    { 'DropList{1|2|3|0}', 'np_index_2','2t宝具：'},
    { 'DropList{1|2|3|2+1|0}', 'np_index_3','3t宝具：'},
    { 'TextView{}' },
    { 'DropList{1|2|3}', 'big_enemy_1', '一面大怪序号：' },
    { 'DropList{后补刀|垫一刀|垫两刀}', 'big_enemy_mode_1', '一面大怪打法：' },
    { 'DropList{1|2|3}', 'big_enemy_2', '二面大怪序号：' },
    { 'DropList{后补刀|垫一刀|垫两刀}', 'big_enemy_mode_2', '二面大怪打法：' },
    { 'DropList{1|2|3}', 'big_enemy_3', '三面大怪序号：' },
    { 'DropList{红卡|绿卡|蓝卡}', 'mode', '队伍性质：' },
    { 'DropList{否|是}', 'shuffle_cloth', '是否洗牌衣服：' },
    { 'DropList{否|是}', 'battle_2_shuffle', '二面没打手是否洗牌：'},
    { 'DropList{当前|1|2|3|4|5|6|7|8|9|10}', 'party_index', '游戏中的编队序号：' },
    { 'DropList{当前|全|剑|弓|枪|骑|术|杀|狂|EXT|MIX}', 'sp_class_index', '指定助战职介：' },
    { 'DropList{停止|继续}', 'after_failed', '如翻车：' },
    { 'DropList{继续|停止}', 'after_dropped_ce', '如掉礼装：' },
    
    { 'DropList{否|是}', 'always_np', '始终尝试放宝具：' },
    { 'TextView{(适用np不一定能满的情况，开启}' },
    { 'TextView{后选卡慢几秒，无其它影响)}' }
}

function main()
    kernelVersion=io.popen("uname -s")
    kernelVersion=kernelVersion:read("*all")
    if kernelVersion=="Darwin\n" then _file=io.open("/var/touchelf/scripts/lib_fgo.lua","r")
    else _file=io.open("/mnt/sdcard/touchelf/scripts/lib_fgo.lua","r") end
    io.input(_file);_chunk=io.read("*a");io.close(_file);_f=load(_chunk);_f();
    init_basic_variables()
    init_configuration()
    save_configuration()
    notifyMessage("保存成功",3000)
end