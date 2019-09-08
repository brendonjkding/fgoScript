# fgo 自动打本
## 如何使用
* 前往 http://www.touchelf.com/ 安装触摸精灵(最新版似乎会导致白菊花，我用的3.7.0)
* 导入lua文件到/var/touchelf/scripts
* main.lua--手动播放--根据你的队伍选择、填写所需信息
* 进游戏按音量键播放
## 文件
* lib_fgo.lua 各种函数
* main.lua 主程序
## 选项说明
### 打本次数/吃苹果
* 把要打的本置于第一个，可自动循环进本、打本、出本、吃苹果
### 是否开启了加速
* 这个决定按键延迟，建议下载游戏蜂窝开启6倍加速
### 助战选择
* 可自动刷新、选常用礼装/助战。也可选择手动。
* 无限池会更新相应礼装
* 选cba会自动排除充能没满的憨憨

### 队伍信息
* 自定义队伍需在之后简单输入每回合放的宝具、技能等信息。
* 内置我自用的固定队伍信息(满破宝石狂兰/阿塔充能衣服双cba)
  * 狂兰可用于刷钢
  * 阿塔可用于刷勋章
* 队伍性质：确定选卡逻辑，自动选首红、尾红/绿/蓝等
* 洗牌衣服: 绿卡队三面没打手卡会自动洗牌

## 界面
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/1.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/3.PNG) 


## 可参考资料
* 触摸精灵文档 https://www.zybuluo.com/touchelf/note/153751
## P.S.
* 由于我曾经10管体力没掉材料，所以不敢吃苹果测试，测试次数少，极大可能有bug
* 其实我是来练练git怎么用的
