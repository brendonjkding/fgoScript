
# 【ios】 fgo 自动打本

## 效果视频演示
* https://www.bilibili.com/video/av67121512/
## 文件
* `lib_fgo.lua` 各种函数
* `main.lua` 主程序
* `UPDATE.md` 更新内容
## 如何使用
* 越狱，添加源 `cydia.touchelf.com` 安装触摸精灵正式版
* 导入两个lua文件到`/var/touchelf/scripts` 或 添加我的源`brendonjkding.github.io`安装
* 点`main.lua`--手动播放--简单输入每回合放的宝具、技能等信息
* 进游戏把要打的本置于第一个，按音量键开始播放即可自动进本、打本、出本、吃苹果，再按可提前停止播放。


## 使用说明
* 主要用于无限池、普通free等需要多次刷的高机械性副本
  * 兼容一面平a、一二面补/垫刀、三面补刀、XJBD打等各类队伍。兼容只有一/二面、一面两批怪等副本。
  * 出卡优先级大致为：红字打手、白字打手、红字拐、白字拐、蓝字打手、蓝字拐。每个级别再按队伍性质/回合数细分三色卡优先级。
  * 绿卡队带洗牌服三面没打手卡会自动洗牌
  * 如打着打着全猝死了，自动撤退，发出3秒震动提醒。
  * 内置几个没啥用的队伍信息。狂兰可刷钢、阿塔可刷勋章，尼托加二号打手可刷灰。
* 可自动选常用礼装/助战。
  * 也可手动选，选好进本再开始播放。
  * 默认选满破礼装
  * 从者只支持三破头像，自动排除充能未满cba
* 搭配游戏蜂窝/叉叉助手加速功能更佳
  * 加速最好不要超过6倍(游戏蜂窝)/30倍(叉叉助手)，再快不好区分点击与按住
  * 个人开了1年加速没啥事，建议平时开、无限池别开
  * 游戏蜂窝源： `apt.ifengwoo.com`
  * 叉叉离线版： 在我的源搜`xxacctoggle`
* 兼容台服
  * 主要区别是字体不同(如回合数)
* 为了避免干扰识别与点击，请关闭assistivetouch，activator是个更好的替代
* qq、微信等通知关了比较好，不然可能误点击
* 勾选检查更新再启动时如有更新会自动更新


## 大致界面
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/1.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/3.PNG) 

## 目前的不足
* 只支持750x1334(iphone 8/7/6s/6等)分辨率(尝试适配但似乎触摸精灵截图有bug或我的ipad4太旧了，放弃)
* 打着打着充满的宝具不会释放，只会释放预先设定好的(宝具值不太好判断)
* 尽量优化选卡，但非最优
* 有些功能我暂时用不上所以没能测试可能有bug，不过顶多是卡住这种小问题，卡住太久会振动提醒


## 深入了解
* 触摸精灵文档 https://www.zybuluo.com/touchelf/note/153751

