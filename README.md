コンパクト版mjpg-streamer

# raspbian関連ナレッジ
```
ユーザー名:pi
パスワード:raspberry
sudo su -
raspi-config
  2 Network Options > N1 Hostname > OK > mjpg-streamer > OK
  4 Localisation Options > I2 Change Timezone > Asia > OK > Tokyo > OK
  5 Interfacing Options > P2 SSH > YES > OK
  (Wi-Fiを使う場合はここで有効にするがfpsが下がるので有線とした。)
cp -p /etc/dhcpcd.conf /etc/dhcpcd.conf.org
vi /etc/dhcpcd.conf
interface eth0(Wi-Fiを使う場合はwlan0)
static ip_address=XXX.XXX.XXX.XXX/24
static routers=XXX.XXX.XXX.XXX
static domain_name_servers=XXX.XXX.XXX.XXX XXX.XXX.XXX.XXX
shutdown -h now

ssh pi@XXX.XXX.XXX.XXX
ユーザー名:pi
パスワード:raspberry
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
sudo su -
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
raspi-config
  8 Update
```

# make
```
git clone https://github.com/kubotan/mjpg-streamer ./mjpg-streamer
cd mjpg-streamer
sh make.sh
```

#1台自動起動の場合は以下を実行
```
sh setup.sh
systemctl stop mjpg-streamer  # 手動終了テスト
systemctl start mjpg-streamer  # 手動起動テスト
```

#2台自動起動の場合は以下を実行
```
sh setup2.sh
systemctl stop mjpg-streamer1  # 手動終了テスト
systemctl start mjpg-streamer1  # 手動起動テスト
systemctl stop mjpg-streamer2  # 手動終了テスト
systemctl start mjpg-streamer2  # 手動起動テスト
```

#以下でmjpgストリーミングの確認可能
```
http://XXX.XXX.XXX.XXX:8080/?action=stream
2台目はhttp://XXX.XXX.XXX.XXX:8081/?action=stream
```

# ナレッジ
```
USB接続確認
lsusb 
ツールのインストール
sudo apt-get install v4l-utils
デバイス情報の表示
v4l2-ctl -d /dev/video0 --info
より詳細な情報表示
v4l2-ctl -d /dev/video0 --all
対応している解像度とフレームレート一覧表示
v4l2-ctl -d /dev/video0 --list-formats-ext
```
