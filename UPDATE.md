# 更新内容
## v1.6.1
* 进进进一步部分适配新版本
* 选助战时不再检查cba技能是否满级
## v1.6.0
* 进进一步部分适配新版本
## v1.5.9
* 进一步部分适配新版本
## v1.5.8
* 部分适配新版本
## v1.5.7
* 尝试改进打手识别
## v1.5.6
* 增加caber助战选项
* fix: menu_points, round_cn_points[2:4]
## v1.5.5
* 适配增加了终端按钮的菜单栏
## v1.5.4
* 助战增加花嫁
* 增加掉礼装停止选项
* bug fix: 
## v1.5.3
* 忽略连续出击
* bug fix: big_enemy(always_np) attack_points always_np blue_color_points
## v1.5.2
* 增加3面双宝具选项
* bug fix: 
## v1.5.1
* 更换区分ios/安卓的方法
* 改进判断自身版本的方法
* bug fix: 新午餐可能不准确 台服apply_interface_points？
## v1.5.0
* always_np优化
* 一面本优化
* 判断苹果优化
* bug fix: need_apple 台服apply_interface_points
## v1.4.9
* bug fix: autoupdate
* 增加梅林改模的特征
* 移除XJBD
## v1.4.8
* bug fix: apple_window_points(与melior冲突) counter_points(tw) is_dashou(XJBD)
## v1.4.7
* 增加结束后锁屏选项
* 增加新qp礼装
* bug fix: menu_point, scroll_bar_slot_points
## v1.4.6
* 新UI适配: not_apply, friend_summon
* bug fix: make_maru
## v1.4.5
* bug fix: select_normal, exp_points
## v1.4.4
* 退出战斗、抽池子优化
* 始终尝试放宝具选项
## v1.4.3
* 增加几个拐信息
* bug fix:apple_window, select_np, battle_ended, check_miss_operate
## v1.4.2
* 发现安卓模拟器改好分辨率也能用
* 助战界面进入(苹果吃完)检测
## v1.4.1
* 掉礼装震动提醒
* bug fix:big_enemy_mode[3] select_np shuffle find_support
## v1.4
* 主程序仅用作生成新文件，生成的文件可单独运行
* bug fix:enemy_y check_miss_operate_points
## v1.3.5
* 文件名优化
* bug fix:select_support 抽池子
## v1.3.4
* find_support优化
* bug fix:select_support maru.lua select_np
## v1.3.3
* 刷助战功能
* 领银狗粮功能
* 删去一些用不上/不好用的功能
* wait_battle_start振动频率减小
* bug fix:quit_mission table.sort(b_card)
## v1.3.2
* 失败可选停止/继续
* 助战职介选项
* 选自定义截图助战
* 抽无限池
* bug fix:count=3首红  开始任务卡住

## v1.3.1
* bug fix:搓满一个丸子停
## v1.3
* 增加抽友情、省qp搓丸子
* 增加选队伍选项
* bug fix:助战刷到底
## v1.2.4
* bug fix:点击敌人改为点本体
## v1.2.3
* 增加一点都不准的np识别
## v1.2.2
* 增加310cba选项
* 一些优化
* bug fix
## v1.2.1
* 增加换好默认队伍提示
* 优化出卡
* 默认不检查更新
* bug fix: has_sup_b未计算，一些点
## v1.2
* 增加自动保存配置到文件以及从文件读取配置
* 助战增加无要求选项
* 优化垫刀
* bug fix：find_support
## v1.1.1
* 增加无限池礼装信息
* 将点、颜色相关信息都放在init()和init_points()里，有兴趣者可自行适配不同设备
* bug fix：羁绊结算增加2秒延迟，current_turn，wait_skill

## v1.1
* 加速/非加速合并
* 国服/台服合并
* 增加二面大怪选择、以及先后手补刀选择
* 增加新版本检测、自动更新
## v1.0
* 正式版本
