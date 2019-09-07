# fgo 自动打本
## 如何使用
* 前往 http://www.touchelf.com/ 安装触摸精灵(最新版似乎会导致白菊花，我用的3.7.0)
* 导入lua文件
* main.lua--手动播放--根据你的队伍选择、填写所需信息
* 进游戏按音量键播放
## 文件
* lib_fgo.lua 各种函数
* main.lua 主程序
## 说明
### 选择打手
* 通用是指：只要不是孔明梅林cba就看做打手(梅林待更新我还没加进去)
### 礼装/助战选择
* 自动刷新、选礼装/助战
* 无限池会更新相应礼装
* 选cba会自动排除充能没满的憨憨

### 打本次数
* 把要打的本置于第一个，自动循环进本、打本、出本(目前不能自动吃苹果)

### 技能模式
* 手动模式需在之后输入每回合放的宝具、技能。
* 内置我自用的固定队伍(狂兰/阿塔、充能衣服、双cba)
  * 狂兰可用于刷钢
  * 阿塔可用于刷勋章
### 队伍性质
* 据此确定选卡逻辑，自动选首红、尾红、尾绿等

### 游戏速度(待更新)
* 假定启用了游戏蜂窝的7倍加速(按键延迟基于此)



## 界面
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/4.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/3.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/1.PNG) 

## 未来可能会加入/更新的功能
* 自动吃苹果，睡觉前开始刷，起床100池不是梦
* 更多内置的打手识别
* 不加速的延迟选择以及更多选项
* 更优的选卡逻辑,更严谨的流程控制
* 自动更新
## 可参考资料
* 触摸精灵文档 https://www.zybuluo.com/touchelf/note/153751
## P.S.
* 由于我曾经10管体力没掉材料，所以不敢吃苹果测试，测试次数少，可能有bug
* 其实我是来练练git怎么用的
