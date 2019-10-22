UI = {
    { 'TextView{记得先换好默认队伍哦！}' },
    { 'InputBox{1}',             'times',    '打本次数：' },
    { 'DropList{不吃|金|银|彩}',             'apple',    '吃苹果：' },

    { 'TextView{ }' },
    { 'DropList{手动|自动}', 'sp_mode', '助战选择：' },
    { 'TextView{如手动，则不用管接下来两项}' },
    { 'DropList{无限池(满破)|无限池|所长|新所长|擦汗|午餐|qp(任意从者)}', 'mc', '礼装：' },
    { 'DropList{孔明|cba|梅林|狐狸}', 'sp', '从者：' },
    { 'TextView{ }' },

    { 'DropList{自定义(在下方输入)|满破宝石狂兰wcba充能衣服|满破宝石阿塔wcba充能衣服|(模板)满破宝石尼托+二号打手+孔明|(模板队(仅)需填写二号打手技能)}', 'skill_mode', '队伍信息：' },

    { 'TextView{}' },
    { 'TextView{技能格式：从者1-9，御主10-12，}' },
    { 'TextView{对象为abc、mnopqr(换人)}' },
    { 'TextView{示例：9 8 7b 1}' },

    { 'InputBox{}',             'skill_serial_1',    '1t技能：' },
    { 'InputBox{}',             'skill_serial_2',    '2t技能：' },
    { 'InputBox{}',             'skill_serial_3',    '3t技能：' },
    { 'TextView{}' },
    { 'TextView{每t释放的宝具：}' },
    { 'DropList{1|2|3|0}', 'np_index_1','1t宝具：'},
    { 'DropList{1|2|3|0}', 'np_index_2','2t宝具：'},
    { 'DropList{1|2|3|0}', 'np_index_3','3t宝具：'},
    { 'TextView{}' },
    { 'DropList{1|2|3}', 'big_enemy_2', '二面大怪序号：' },
    { 'DropList{后补刀|先垫刀}', 'big_enemy_mode', '二面大怪打法：' },
    { 'DropList{1|2|3}', 'big_enemy_3', '三面大怪序号：' },
    { 'DropList{红卡|绿卡|蓝卡}', 'mode_', '队伍性质：' },
    { 'DropList{否|是|}', 'shuffle_cloth', '是否洗牌衣服：' },
    { 'TextView{记得换好默认队伍哦！}' }




}
dofile("/var/touchelf/scripts/lib_fgo.lua")




function main()
    --[[
    times=1
    apple="不吃"
    is_speed_up="是"
    
    sp_mode="手动"
    mc="午餐"
    sp="梅林"
    
    skill_mode="手动"
    skill_serial_1="7a"
    skill_serial_2="8 9"
    skill_serial_3=""
    np_index_1="1"
    np_index_2="1"
    np_index_3="2"
    
    big_enemy="2"
    mode_="红卡"
    shuffled_="否"
    dashou="通用"
    
    server="国服"
    ]]--

    init()

    for ii=1,times do
        start_one_mission()
    end

    notifyMessage("感谢使用")
    notifyVibrate(3000)

end