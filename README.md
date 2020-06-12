コンパクト版mjpg-streamer

Fork of http://sourceforge.net/projects/mjpg-streamer/

追加プラグイン output_motion https://github.com/jacksonliam/mjpg-streamer/pull/129/files

# raspbian関連ナレッジ
```
ユーザー名:pi
パスワード:raspberry
echo "set nocompatible" >> ~/.vimrc
echo "set backspace=indent,eol,start" >> ~/.vimrc
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
sudo su -
echo "set nocompatible" >> ~/.vimrc
echo "set backspace=indent,eol,start" >> ~/.vimrc
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
exit
sudo su -
raspi-config
  2 Network Options > Select > N1 Hostname > Select > mjpg-streamer > OK
  2 Network Options > Select > N2 Wireless LAN > Select > JP Japan > OK > OK > (SSID) > OK > (Passphrase) > OK
  4 Localisation Options > Select > I2 Change Timezone > Asia > OK > Tokyo > OK
  5 Interfacing Options > Select > P2 SSH > YES > OK
  (Wi-Fiを使う場合はここで有効にするがfpsが下がるので有線とした。)
cp -p /etc/dhcpcd.conf /etc/dhcpcd.conf.org
vi /etc/dhcpcd.conf
interface eth0(Wi-Fiを使う場合はwlan0)
static ip_address=XXX.XXX.XXX.XXX/24
static routers=XXX.XXX.XXX.XXX
static domain_name_servers=XXX.XXX.XXX.XXX XXX.XXX.XXX.XXX
reboot

ssh pi@XXX.XXX.XXX.XXX
ユーザー名:pi
パスワード:raspberry
sudo su -
raspi-config
  8 Update > Select
  Finish
reboot
```

# セットアップ
```
ssh pi@XXX.XXX.XXX.XXX
ユーザー名:pi
パスワード:raspberry
sudo su -
git clone https://github.com/kubotan/mjpg-streamer ./mjpg-streamer
cd mjpg-streamer
sh setup.sh   # 1台セットアップになってます。2台にする場合はコメントアウトされたecho行を有効化してください。
```

#以下でmjpgストリーミングの確認可能
```
http://XXX.XXX.XXX.XXX:8080/?action=stream
2台目はhttp://XXX.XXX.XXX.XXX:8081/?action=stream
```

# ナレッジ
```
#USB接続確認
lsusb 
#ツールのインストール
sudo apt-get install v4l-utils
#デバイス情報の表示
v4l2-ctl -d /dev/video0 --info
#より詳細な情報表示
v4l2-ctl -d /dev/video0 --all
#対応している解像度とフレームレート一覧表示
v4l2-ctl -d /dev/video0 --list-formats-ext
```
