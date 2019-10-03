
# 【ios】 fgo 自动打本
## 效果视频演示
* https://www.bilibili.com/video/av67121512/
## 文件
* `lib_fgo.lua` 各种函数
* `main.lua` 主程序
## 如何使用
* 越狱，添加源 cydia.touchelf.com 安装触摸精灵正式版
* 导入两个lua文件到/var/touchelf/scripts
* 点`main.lua`--手动播放--简单输入每回合放的宝具、技能等信息
* 进游戏把要打的本置于第一个，按音量键开始播放即可自动进本、打本、出本、吃苹果，再按可提前停止播放。


## 使用说明
* 主要用于无限池、普通free等可针对性配队、需要多次刷的高机械性副本
  * 兼容1面平a、二面补刀、三面补刀、XJBD打等各类队伍。兼容只有一/二面、一面两批怪等副本。
  * 出卡优先级大致为：红字打手、白字打手、红字拐、白字拐、蓝字打手、蓝字拐。每个级别再按队伍性质细分三色卡优先级。
  * 绿卡队带洗牌服三面没打手卡会自动洗牌
  * 如打着打着全猝死了，自动撤退。
  * 内置几个我自用的队伍信息。狂兰可刷钢、阿塔可刷勋章，尼托加二号打手可刷灰。
* 可自动选指定礼装/助战。
  * 也可手动选，选完进本自动开打。
  * 默认选满破礼装
  * 从者只支持三破头像，自动排除充能未满cba
* 搭配游戏蜂窝/叉叉助手加速功能更佳
  * 延迟按游戏蜂窝(6倍)/叉叉助手(30倍)设定，再快不好区分点击与按住
  * 不加速的延迟也写了但没测试(因为默认速度会变慢)
  * 个人开了1年加速没啥事，建议平时开、无限池别开
  * 游戏蜂窝源 apt.ifengwoo.com 
  * 叉叉离线版：https://pan.baidu.com/s/1JGxNWBWr4SZNuyBCpLeWvA 提取码：p4ig 。使用方法：https://pan.baidu.com/s/1I0WfQpSfCIKWeS7S3Uaorw 提取码：09jq 


* 支持国服/台服
  * 主要区别是字体不同，文字特征点不同


## 界面
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/1.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/2.PNG) 
![](https://github.com/brendonjkding/fgo_lua_test/raw/master/pic/3.PNG) 

## 目前的不足
* 只支持iphone8分辨率(我没别的设备没法取特征点)
* 打着打着充满的宝具不会释放，只会释放预先设定好的(宝具值不太好取)
* 羁绊界面取棱形颜色判定，立绘较大的角色羁绊提升时会挡到导致卡住，御主升级/衣服升级/掉礼装也可能有干扰，不过理论上卡住太久会振动提醒
* 有些功能我暂时用不上所以没能测试可能有bug，不过顶多是卡住这种小问题

## 深入了解
* 触摸精灵文档 https://www.zybuluo.com/touchelf/note/153751

