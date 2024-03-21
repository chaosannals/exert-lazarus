# exert lazarus

[官网](https://www.lazarus-ide.org/)

## 界面

项目》项目查看器，可以看到源码文件结构。
视图》对象查看器，可以看到 GUI Form 界面对象组件树，以及编辑组件属性。
视图》在窗体于对象间切换，打开 所见即所得 窗体编辑界面。

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

Full Cgi/FastCGI Server 项是有个导航页，用来引导生成项目。

- CGI ，老式的网关协议，可执行文件，有安全隐患。
- FastCGI， PHP 使用的 CGI 协议，通过 socket 和反向代理交互。
- 内嵌服务器， 就是一般 golang rust c++ 生成的 exe HTTP 服务器后端。
- embed daemon server 这种不知道是啥，生成了 exe 文件，执行没有反应。。。。

这框架文档只到了开启服务器，没看到其他文档，基本上要靠自己扩展开发了吧，太裸了。
