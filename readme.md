# exert lazarus

[官网](https://www.lazarus-ide.org/)

## 界面

项目》项目查看器，可以看到源码文件结构。
视图》对象查看器，可以看到 GUI Form 界面对象组件树，以及编辑组件属性。
视图》在窗体于对象间切换，打开 所见即所得 窗体编辑界面。

## 源码修改与重命名

文件》另存为，可以用来重命令 unit1.pas 这类文件。

源代码编辑器选中 类名，变量名等 右键菜单》重构》重命名标识符 可以修改类名变量名。

注：重命名 unit1.pas 这类文件问题不大，但是重命名类名，例如 TForm2 这种，就很可能导致编译错误。

解决方法：
1. 出现编译错误的暂行方法是重新命名回来。
2. 搜索整个文件会发现 .lfm 里面的名字没有被替换，而且很多缓存文件也没有。统统替换，然后清理缓存再编译。

运行》清理和构建，可以清理缓存后编译。

## 日志

### LazLogger

运行》运行参数，在命令行参数中加入 --debug-log=aaa.log 可以把 DebugLn 的输出输出到文件 aaa.log 里。

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
