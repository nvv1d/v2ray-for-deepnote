#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
echo -e "\033[33m\033[01m$1\033[0m"
}

while true; do
clear
echo "#############################################################"
echo -e "# ${RED} Deepnote v2ray 一键安装脚本${PLAIN} #"
echo -e "# ${GREEN}作者${PLAIN}: MisakaNo の 小破站 #"
echo -e "# ${GREEN}博客${PLAIN}: https://blog.misaka.rest #"
echo -e "# ${GREEN}GitHub 项目${PLAIN}: https://github.com/Misaka-blog #"
echo -e "# ${GREEN}Telegram 频道${PLAIN}: https://t.me/misakablogchannel #"
echo -e "# ${GREEN}Telegram 群组${PLAIN}: https://t.me/misakanoxpz #"
echo -e "# ${GREEN}YouTube 频道${PLAIN}: https://www.youtube.com/@misaka-blog #"
echo "#############################################################"
echo ""

echo -e "${YELLOW}使用前请注意：${PLAIN}"
red "1. 我已知悉本项目有可能触发 Deepnote 封号机制"
red "2. 我不保证脚本其搭建节点的稳定性"
yesno="Y"
echo -e "${YELLOW}自动回答第一次提问：${GREEN}$yesno${PLAIN}"

read -rp "是否安装脚本？ [Y/N]：" yesno
yesno="Y"  # Automatically answer the first read question with Y
echo -e "${YELLOW}自动回答第一次提问：${GREEN}$yesno${PLAIN}"

if [[ $yesno =~ "Y"|"y" ]]; then
    rm -f web config.json
    yellow "开始安装..."
    wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
    unzip temp.zip
    rm -f temp.zip
    mv v2ray web
    uuid="779afda6-71f3-4cfe-a123-83cf453f9d4d"  # Set UUID
    rm -f config.json
    cat << EOF > config.json
{
"log": {
"loglevel": "warning"
},
"routing": {
"domainStrategy": "AsIs",
"rules": [
{
"type": "field",
"ip": [
"geoip:private"
],
"outboundTag": "block"
}
]
},
"inbounds": [
{
"listen": "0.0.0.0",
"port": 8080,
"protocol": "vless",
"settings": {
"clients": [
{
"id": "$uuid"
}
],
"decryption": "none"
},
"streamSettings": {
"network": "ws",
"security": "none"
}
}
],
"outbounds": [
{
"protocol": "freedom",
"tag": "direct"
},
{
"protocol": "blackhole",
"tag": "block"
}
]
}
EOF
nohup ./web run &>/dev/null &
green "Deepnote v2ray 已安装完成！"
yellow "请认真阅读项目博客说明文档，配置出站链接！"
yellow "别忘记给项目点一个免费的Star！"
echo ""
yellow "更多项目，请关注：小御坂的破站"
else
red "已取消安装，脚本退出！"
exit 1
fi

sleep 3h  # Wait for three hours before restarting
done
