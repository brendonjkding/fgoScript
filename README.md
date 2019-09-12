# fgo 自动打本
## 视频演示
* https://www.bilibili.com/video/av67121512/

## 如何使用
* 前往 http://www.touchelf.com/ 安装触摸精灵(最新版似乎会导致白菊花，我用的3.7.0)
* 导入lua文件到/var/touchelf/scripts
* main.lua--手动播放--根据你的队伍选择、填写所需信息
* 进游戏按音量键播放
## 文件
* `lib_fgo.lua` 各种函数
* `main.lua` 主程序
## 使用说明
* 把要打的本置于第一个，开始播放即可自动进本、打本、出本、吃苹果
* 推荐配好3t或3t加补刀的队伍。会自动判断打手卡(非拐卡视为打手卡)，卡色，自动根据队伍性质选首红、尾卡、三连等。
  * 简单输入每回合放的宝具、技能等信息即可。
  * 非3t队伍也行。比如二面宝具没打死，那么会自动平砍到3面再放应该在3面放的宝具和技能，不会乱放。XJBD队也行，比如打着打着全猝死了，会自动撤退。
  * 内置几个我自用的队伍信息。狂兰可刷钢、阿塔可刷勋章，尼托加二号打手可刷灰。
  * 绿卡队带洗牌服三面没打手卡会自动洗牌
* 可自动选指定礼装/助战。也可手动选。
  * 无限池会更新相应礼装
  * 选cba会自动选充能满了的
* 建议安装游戏蜂窝开启6倍加速
  * 不加速的延迟也写了但没测试


## 界面
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/1.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/3.PNG) 

## 目前的问题
* 目前只支持iphone8分辨率
* 自动选助战只支持三破
* 打着打着充满的宝具不会释放，只会释放预先设定好的
* 无限池掉礼装还不能处理，会卡住

## 深入了解
* 触摸精灵文档 https://www.zybuluo.com/touchelf/note/153751
## P.S.
* 其实我是来练练git怎么用的
