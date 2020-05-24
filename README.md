
# 【ios/安卓】 fgo 打本/搓丸子

## 文件
* `lib_fgo.lua` 所需文件
* `main.lua` 填入队伍信息运行后会生成新的单独脚本文件
* `maru.lua` 抽友情池/搓丸子/抽无限池等辅助功能
* `UPDATE.md` 更新说明

## 如何使用
* 苹果
  * 只支持750x1334(iphone 8/7/6s/6等)分辨率
  * 越狱，添加源 `cydia.touchelf.com` 安装触摸精灵3.7.4(之后版本未测试)
  * 导入lua文件到`/var/touchelf/scripts` 或 添加我的源 [brendonjkding.github.io](http://brendonjkding.github.io) 直接安装
* 安卓
  * 雷电模拟器，分辨率设为750*1334
  * 导入lua文件到`/mnt/sdcard/touchelf/scripts/`
* 刷本
  * `main.lua`--手动播放--输入每回合放的宝具、技能等信息，按音量键运行后生成新文件，点击右上角刷新后显示
  * 进游戏，home键朝右，把要打的本置于第一个，播放新文件，即可自动进本、打本、出本、吃苹果，再按可提前停止播放。
* 搓丸子：同上，在游戏大厅/进迦勒底之门那里播放`maru.lua`

## 功能简介
  * 可以应付一些简单的情况，如一面平a、一二面无脑补/垫刀、三面补刀，也兼容只有一/二面、一面两批怪等副本，兼容台服。
  * 出卡优先级大致为：红字打手、白字打手、红字拐、白字拐、蓝字打手、蓝字拐。每个级别再按队伍性质/回合数分三色卡优先级。
  * 绿卡队带洗牌服三面没打手卡会自动洗牌

* 可自动选礼装/助战。
  * 内置常用礼装/助战信息。默认选满破礼装，cba满充能
  * 只支持三破头像，注意在设置里关闭

* 抽友情/搓丸子。
  * 抽友情：如爆仓，根据设置会停止或切换搓丸子。
  * 搓丸子: 因为会尽量搓完礼装，所以`使用前`先把其他礼装`放仓库`或`锁住`，礼装请按消耗顺序升序排列。只会选`饥饿`礼装搓。如没丸子/没狗粮则停止/切换抽友情。如满了一个丸子则停止

## 大致界面
![](https://github.com/brendonjkding/fgoScript/raw/master/pic/1.PNG) 
![](https://github.com/brendonjkding/fgoScript/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgoScript/raw/master/pic/3.PNG) 
## 搓丸子效果视频演示
* https://www.bilibili.com/video/av67121512/
## 目前的不足
* 打着打着充满的宝具不会释放，只会释放预先设定好的
* 尽量优化选卡，但非最优
* 有些功能我暂时用不上所以没能测试可能有bug，不过顶多是卡住这种小问题，卡住太久会振动提醒


