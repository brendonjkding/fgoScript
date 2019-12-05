UI = {
    { 'InputBox{1}',             'times',    '打本次数：' },
    { 'DropList{不吃|金|银|彩|铜}',             'apple',    '吃苹果：' },

    { 'DropList{自定义(在下方输入)|从文件导入|满破宝石狂兰wcba充能衣服|满破宝石阿塔wcba充能衣服|(模板)满破宝石尼托+二号打手+孔明|(模板队(仅)需填写二号打手技能)}', 'skill_mode', '设置：' },
    { 'DropList{1|2|3|4|5|6|7|8|9}', 'conf_index','文件序号：'},
    { 'TextView{输入信息运行一次后会自动保存至选}' },
    { 'TextView{择的文件，以后可直接选择导入，之}' },
    { 'TextView{后的信息不用再设置}' },
    { 'InputBox{}',             'conf_name',    '配置名(仅运行前提示用)' },
    
    { 'TextView{}' },
    { 'DropList{否|是}', 'is_check_update','检查更新：'},

    { 'TextView{}' },
    { 'DropList{手动|自动}', 'sp_mode', '助战选择：' },
    { 'TextView{如手动选助战，则无视接下来两项}' },
    { 'DropList{无限池(满破)|无限池|所长|新所长|擦汗|午餐|qp|任意}', 'mc', '礼装：' },
    { 'DropList{孔明|310cba|cba|梅林|狐狸|任意}', 'sp', '从者：' },
    { 'TextView{}' },
    
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
    { 'DropList{1|2|3}', 'big_enemy_1', '一面大怪序号：' },
    { 'DropList{后补刀|先垫刀}', 'big_enemy_mode_1', '一面大怪打法：' },
    { 'DropList{1|2|3}', 'big_enemy_2', '二面大怪序号：' },
    { 'DropList{后补刀|先垫刀}', 'big_enemy_mode_2', '二面大怪打法：' },
    { 'DropList{1|2|3}', 'big_enemy_3', '三面大怪序号：' },
    { 'DropList{红卡|绿卡|蓝卡|XJBD}', 'mode', '队伍性质：' },
    { 'DropList{否|是|}', 'shuffle_cloth', '是否洗牌衣服：' },
    { 'DropList{当前|1|2|3|4|5|6|7|8|9|10}', 'party_index', '游戏中的队伍序号：' }
}
dofile("/var/touchelf/scripts/lib_fgo.lua")

function main()
    init()
    
    for ii=1,times do
        start_one_mission(ii)
    end

    notifyMessage("感谢使用")
    notifyVibrate(3000)
end