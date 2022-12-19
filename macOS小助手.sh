#!/bin/bash
clear
BLACK="\033[0;30m"  
DARK_GRAY="\033[1;30m"  
BLUE="\033[0;34m"  
LIGHT_BLUE="\033[1;34m"  
GREEN="\033[0;32m"  
LIGHT_GREEN="\033[1;32m"  
CYAN="\033[0;36m"  
LIGHT_CYAN="\033[1;36m"  
RED="\033[0;31m"  
LIGHT_RED="\033[1;31m"  
PURPLE="\033[0;35m"  
LIGHT_PURPLE="\033[1;35m"  
BROWN="\033[0;33m"  
YELLOW="\033[0;33m"  
LIGHT_GRAY="\033[0;37m"  
WHITE="\033[1;37m" 
NC="\033[0m"

echo ""
echo ""
echo -e "macOS小助手 ${RED}by PowerApps Inc."
echo ""
                                                      
echo ""
echo -e "${CYAN}macOS有不少操作都需要通过终端命令执行，这个小脚本，希望可以帮到你。${NC}"
echo ""


CLTGDIR="/Library/Developer/CommandLineTools/"
PS3='请输入数字然后按下回车进行选择: '
options=(
	"开启任何来源 (可解决应用运行出现『xxx已损坏/身份不明的开发者』等问题)" 
	"绕过 Apple 签名认证 (可解决因应用签名导致的应用无法运行的问题)"
	"安装 Command Line Tools （签名前必需安装，只安装一次即可）"
	"对应用进行签名认证 （可解决应用运行出现『意外退出/崩溃闪退』问题）"
	"查看SIP状态"
	"调整启动台 (Launchpad) 的布局"
	"DOCK栏（程序坞）自动显示和隐藏的响应速度"
	"修改截图默认保存位置"
	"禁用窗口截图的阴影"
	"启用窗口截图的阴影"
	"禁用Safari在新标签中打开网页"
	"启用Safari在新标签中打开网页"
	"禁用系统更新提示（去除设置图标上小红点）"
	)
select opt in "${options[@]}"
do
	case $opt in
		"开启任何来源 (可解决应用运行出现『xxx已损坏/身份不明的开发者』等问题)")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}解决『xxx已损坏/来自身份不明的开发者/Apple无法检查其是否包含恶意软件』问题${NC}，此操作将会为您开启任何安装来源。"
			echo ""
			echo -e "${RED}请输入您的电脑密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
			echo ""
			sudo spctl --master-disable
			echo -e "${GREEN}设置成功，请重新运行应用查看，如问题未解决，这可能是因为此应用需要绕过苹果签名认证才可以运行，您可以重新运行本工具，然后输入数字『2』绕过苹果签名。本窗口可以关闭啦！${NC}"
			break
			;;
		"绕过 Apple 签名认证 (可解决因应用签名导致的应用无法运行的问题)")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}解决因苹果签名导致的应用无法运行的问题${NC}，通过此工具可以绕过苹果应用签名检查。"
			echo ""
			echo -e "${YELLOW}打开 Finder -> 应用程序，然后将需要绕过苹果签名的应用程序拖放到此处，然后按回车键${NC} ${LIGHT_GRAY}（对于在dmg安装包中的应用，可以先从包中拖到桌面上，然后再从桌面上拖到此处）${NC}"
			echo ""
			echo ""
			read -e -p "请将应用拖到这儿来: " FILEPATH
			echo ""
			echo -e "${RED}请输入您的电脑密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
			echo ""
			sudo spctl --master-disable
			sudo xattr -rd com.apple.quarantine "$FILEPATH"
			echo -e "${GREEN}设置成功！${NC} ${LIGHT_GRAY}请重新运行应用查看，如问题未解决，这可能是因为此应用必需要进行苹果签名认证才可以运行，您可以重新运行本工具，然后输入数字『4』进行苹果签名。本窗口可以关闭啦！${NC}"
			break
			;;
		"安装 Command Line Tools （签名前必需安装，只安装一次即可）")
			echo ""
			echo -e "您选择了 ${LIGHT_BLUE}安装 Command Line Tools${NC}"
			echo ""
			echo -e "${YELLOW}应用签名前必须安装此工具，只安装一次即可，无需再次安装。${NC}"
			if [ ! -d "$CLTGDIR" ];then
  				echo ""
				xcode-select --install
				echo -e "执行成功！在弹出安装窗口中点击${GREEN}『安装』${NC}，安装过程需要几分钟，请耐心等待，本窗口可以关闭了！"
				else
  				echo ""
				echo -e "提示：您已安装${BLUE} Command Line Tools ${NC}，无需再次安装！您可以重新运行本工具然后输入数字『4』对应用进行签名。"
  				echo ""
			fi
			break
			;;
		"对应用进行签名认证 （可解决应用运行出现『意外退出/崩溃闪退』问题）")
			echo ""
			echo -e "您选择了解决${LIGHT_BLUE}『意外退出/崩溃闪退』问题${NC}，通过此工具可以对应用进行苹果签名认证。"
			echo ""
			echo -e "${YELLOW}打开 Finder -> 应用程序，然后将无法运行的应用程序拖放到此处，然后按回车键${NC}"
			echo ""
			echo ""
			read -e -p "请将应用拖到这儿来: " FILEPATH
			echo ""
			echo -e "${RED}请输入您的电脑密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
			echo ""

			if [ ! -d "$CLTGDIR" ];then
  				echo ""
				echo -e "执行结果：${RED}您还未安装 Command Line Tools ，请重新运行本工具，输入数字『3』，进行安装${NC}"
				else
				echo -e "${BLUE}请输入电脑密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
				sudo spctl --master-disable
				sudo codesign --force --deep --sign - "$FILEPATH"
				echo ""
				echo ""
				echo -e "提示：${BLUE}replacing existing signature${NC}证明签名成功！"
			fi
			echo -e "${GREEN}操作成功！${NC}请重新运行应用查看，如问题未解决，请尝试关闭 SIP，关闭方法：${BLUE}https://www.powerapps.app/articles/69033.html${NC} 本窗口可以关闭了！"
			break
			;;
		"查看SIP状态")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}查看SIP状态${NC}"
			echo ""
			echo ""
			csrutil status
			echo ""
			echo -e "上面的${RED}disabled${NC} 代表当前SIP是${CYAN}关闭${NC}的，${RED}enabled${NC} 代表当前SIP是${YELLOW}开启${NC}的"
			echo ""
			echo ""
			echo -e "SIP介绍以及关闭教程：${BLUE}https://www.powerapps.app/articles/33479.html${NC} 本窗口可以关闭了！"
			break
			;;
		"调整启动台 (Launchpad) 的布局")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}『调整启动台布局』${NC}，如果你希望调整一下启动台里面的图标大小，让显示效果看起来舒服一点，可以使用此工具实现，特别是对于高分辨率的显示器特别有用。"
			echo ""
			echo -e "${YELLOW}请输入要修改的显示行数，输入数字即可，然后按回车键${NC}${BLUE}默认为5行，不输入即可跳过此项设置${NC}"
			echo ""
			read -e -p "行数: " ROW
			echo -e "${YELLOW}请输入要修改的显示列数，输入数字即可，然后按回车键${NC}${BLUE}默认为7列，不输入即可跳过此项设置${NC}"
			read -e -p "列数: " COL
			# echo -e "${YELLOW}请输入要修改的背景模糊度，输入数字即可，输入范围：0 ~ 255，然后按回车键${NC}${BLUE}默认为100，不输入即可跳过此项设置${NC}"
			# read -e -p "背景模糊度: " BLURRADIUS
			echo ""
			if [ -n "$ROW" ]; then
				echo "ROW不为空"
				defaults write com.apple.dock springboard-rows -int ${ROW}
			fi
			if [ -n "$COL" ]; then
				echo "COL不为空"
				defaults write com.apple.dock springboard-columns -int ${COL}
			fi
			# if [ -n "$BLURRADIUS" ]; then
			# 	echo "BLURRADIUS不为空"
			# 	defaults write com.apple.dock springboard-blur-radius -int ${BLURRADIUS}
			# fi
			
			if [ -n "$ROW" ] || [ -n "$COL" ]; then
				defaults write com.apple.dock ResetLaunchPad -bool TRUE
				killall Dock
				echo -e "${GREEN}设置成功！您设置的为启动台布局为： ${ROW}行 ${COL}列， ${NC}快打开启动台看看效果吧！本窗口可以关闭了。"
				else
				echo -e "${CYAN}您未进行输入，将不会做任何设置！${NC}本窗口可以关闭了。"
			fi
			echo ""
			break
			;;
		"DOCK栏（程序坞）自动显示和隐藏的响应速度")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}『DOCK栏（程序坞）自动显示和隐藏的响应速度』${NC}，当您在『系统偏好设置 -> 程序坞』中开启了『自动显示和隐藏程序坞』选项后，可能会觉得鼠标滑动到底部时显示程序坞的动画有点长，可以使用此工具调整。"
			echo ""
			echo -e "${YELLOW}请输入要修改的响应速度，立即响应请输入数字 0 ，单位秒，支持小数。${NC}${BLUE}如果想恢复初始，请输入:reset${NC}"
			echo ""
			read -e -p "动画时长: " TIME
			if [ "$TIME" == 'reset' ]; then
				defaults delete com.apple.Dock autohide-delay && killall Dock
				else
				defaults write com.apple.Dock autohide-delay -float ${TIME} && killall Dock
			fi
			echo ""
			echo -e "${GREEN}设置成功！您设置的为 ${TIME} 秒后显示 DOCK栏，${NC}赶快去看看效果吧！本窗口可以关闭了。"
			break
			;;
		"修改截图默认保存位置")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}修改截图默认保存位置${NC}"
			echo ""
			read -e -p "将要保存的目录拖放到此处，然后按回车键: " FILEPATH
			echo ""
			defaults write com.apple.screencapture location "$FILEPATH"
            killall SystemUIServer
			echo -e "${GREEN}修改成功，您现在可以关闭窗口啦${NC}"
			break
			;;
		"禁用窗口截图的阴影")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}禁用窗口截图的阴影${NC}"
			echo ""
			echo ""
			defaults write com.apple.screencapture disable-shadow -bool true
            killall SystemUIServer
			echo -e "${GREEN}设置成功，您现在可以关闭窗口啦${NC}"
			break
			;;
		"启用窗口截图的阴影")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}启用窗口截图的阴影${NC}"
			echo ""
			echo ""
			defaults write com.apple.screencapture disable-shadow -bool false
            killall SystemUIServer
			echo -e "${GREEN}设置成功，您现在可以关闭窗口啦${NC}"
			break
			;;
		"禁用Safari在新标签中打开网页")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}禁用Safari在新标签中打开网页${NC}"
			echo ""
			echo ""
			defaults write com.apple.Safari TargetedClicksCreateTabs -bool false
			echo -e "${GREEN}设置成功，您现在可以关闭窗口啦${NC}"
			break
			;;
		"启用Safari在新标签中打开网页")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}启用Safari在新标签中打开网页${NC}"
			echo ""
			echo ""
			defaults write com.apple.Safari TargetedClicksCreateTabs -bool true
			echo -e "${GREEN}设置成功，您现在可以关闭窗口啦${NC}"
			break
			;;
		"禁用系统更新提示（去除设置图标上小红点）")
			echo ""
			echo -e "您选择了${LIGHT_BLUE}禁用系统更新提示（可以去掉设置图标上因更新而显示的小红点）${NC}"
			echo ""
			echo -e "${RED}请输入您的电脑密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
			echo ""
			defaults write com.apple.systempreferences AttentionPrefBundleIDs 0
			killall Dock
			echo -e "${GREEN}设置成功，您现在可以关闭窗口啦${NC}"
			break
			;;
	esac
done