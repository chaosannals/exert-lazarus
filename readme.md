# exert lazarus

[官网](https://www.lazarus-ide.org/)

## 插件

菜单 >  软件包  >  插件管理

由于 Lazarus 界面是拆成一堆小窗口的，所以需要安装插件合并成一个大窗口。

AnchorDocking
AnchorDockingDsgn
DockedFormEditor

### 通过 lpk 文件安装

菜单 >  软件包  >  打开 lpk 

## Web 框架

### [brookfreepascal](https://github.com/risoflora/brookfreepascal)

这个框架支持生成类型：

- CGI ，老式的网关协议，可执行文件，有安全隐患。
- FastCGI， PHP 使用的 CGI 协议，通过 socket 和反向代理交互。
- 内嵌服务器， 就是一般 golang rust c++ 生成的 exe HTTP 服务器后端。
- embed daemon server 这种不知道是啥，生成了 exe 文件，执行没有反应。。。。
