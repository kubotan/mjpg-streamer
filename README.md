コンパクト版mjpg-streamer

Fork of http://sourceforge.net/projects/mjpg-streamer/

-----
# Rapid Setup

## Download Raspberry Pi Imager
https://www.raspberrypi.org/downloads/
1. Raspberry Pi Imagerをダウンロードする
2. Raspberry Pi Imagerをインストールして、Windowsの場合はアイコンを右クリックして、「管理者として実行」を選択して、実行する
3. 「Operating System」から「ERASE」を選択し、SDカードを選択して、「WRITE」ボタンを押す

## Write image file.
https://www.raspberrypi.org/downloads/raspberry-pi-os/
1. 「Raspberry Pi OS (32-bit) Lite」の「Download ZIP」ボタンを押してダウンロードする。
2. 「Operating System」から「Use custom」 > 「2020-05-27-raspios-buster-lite-armhf.zip」を選択し、SDカードを選択して、「WRITE」ボタンを押す

## Build
- ユーザー名:pi
- パスワード:raspberry
- ヘッドレスセットアップを行う為、sdカードの直下にsshという名前の空ファイルを作成する

```
ssh -p 22 pi@raspberrypi.local
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
  2 Network Options > Select > N1 Hostname > Select > mjpg-streamer1 > OK
  2 Network Options > Select > N2 Wireless LAN > Select > JP Japan > OK > OK > (SSID) > OK > (Passphrase) > OK
  4 Localisation Options > Select > I2 Change Timezone > Asia > OK > Tokyo > OK
  5 Interfacing Options > Select > P2 SSH > YES > OK
  (Wi-Fiを使う場合はここで有効にするがfpsが下がるので有線とした。)
  5 Interfacing Options > Select > P1 Camera > Select > Yes > Ok
  (フレキシブルフラットケーブルのCSI接続をする場合のみ。USBカメラでは不要)
  8 Update > Select
  Finish
cp -p /etc/dhcpcd.conf /etc/dhcpcd.conf.org
echo "" >> /etc/dhcpcd.conf
echo "interface eth0" >> /etc/dhcpcd.conf  # Wi-Fiを使う場合はwlan0
echo "static ip_address=XXX.XXX.XXX.XXX/24" >> /etc/dhcpcd.conf  # XXX部分は任意の数値を指定
echo "static routers=XXX.XXX.XXX.XXX" >> /etc/dhcpcd.conf  # XXX部分は任意の数値を指定
echo "static domain_name_servers=XXX.XXX.XXX.XXX" >> /etc/dhcpcd.conf  # XXX部分は任意の数値を指定
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kubotan/mjpg-streamer/master/setup.sh)"  # setup and reboot
```

#以下でmjpgストリーミングの確認可能
```
http://mjpg-streamer1.local:8080/?action=stream
2台目はhttp://mjpg-streamer1.local:8081/?action=stream
```

# ナレッジ
```
#USB接続確認
$ lsusb 
#ツールのインストール
$ sudo apt-get install v4l-utils
#デバイス一覧の表示
$ v4l2-ctl --list-devices
#デバイス情報の表示
$ v4l2-ctl -d /dev/video0 --info
#より詳細な情報表示
$ v4l2-ctl -d /dev/video0 --all
#対応している解像度とフレームレート一覧表示
$ v4l2-ctl -d /dev/video0 --list-formats-ext
#オプション
$ ./mjpg_streamer -i "input_uvc.so --help"
$ ./mjpg_streamer -o "output_http.so --help"
 
 オプション
 -b バックグラウンドで起動
 -i 入力修飾子を指定
 [-d | --device ].......: video device to open (your camera)
 [-r | --resolution ]...: the resolution of the video device,
                          can be one of the following strings:
                          QQVGA QCIF CGA QVGA CIF PAL
                          VGA SVGA XGA HD SXGA UXGA
                          FHD
                          or a custom value like the following
                          example: 640x480
 [-f | --fps ]..........: frames per second
                          (activates YUYV format, disables MJPEG)
 [-q | --quality ] .....: set quality of JPEG encoding
 [-m | --minimum_size ].: drop frames smaller then this limit, useful
                          if the webcam produces small-sized garbage frames
                          may happen under low light conditions
 [-e | --every_frame ]..: drop all frames except numbered
 [-n | --no_dynctrl ]...: do not initalize dynctrls of Linux-UVC driver
 [-l | --led ]..........: switch the LED "on", "off", let it "blink" or leave
                          it up to the driver using the value "auto"
 [-t | --tvnorm ] ......: set TV-Norm pal, ntsc or secam
 [-u | --uyvy ] ........: Use UYVY format, default: MJPEG (uses more cpu power)
 [-y | --yuv  ] ........: Use YUV format, default: MJPEG (uses more cpu power)
 [-fourcc ] ............: Use FOURCC codec 'argopt',
                          currently supported codecs are: RGBP
 ---------------------------------------------------------------

 Optional parameters (may not be supported by all cameras):

 [-br ].................: Set image brightness (auto or integer)
 [-co ].................: Set image contrast (integer)
 [-sh ].................: Set image sharpness (integer)
 [-sa ].................: Set image saturation (integer)
 [-cb ].................: Set color balance (auto or integer)
 [-wb ].................: Set white balance (auto or integer)
 [-ex ].................: Set exposure (auto, shutter-priority, aperature-priority, or integer)
 [-bk ].................: Set backlight compensation (integer)
 [-rot ]................: Set image rotation (0-359)
 [-hf ].................: Set horizontal flip (true/false)
 [-vf ].................: Set vertical flip (true/false)
 [-pl ].................: Set power line filter (disabled, 50hz, 60hz, auto)
 [-gain ]...............: Set gain (auto or integer)
 [-cagc ]...............: Set chroma gain control (auto or integer)
 ---------------------------------------------------------------
 
 -o 出力修飾子を指定
   -p ポート
   -w ウェブコンテンツのあるディレクトリ
   -c 認証情報。ユーザ名:パスワードで指定
   -n デモページのControlコマンド無効化
```
