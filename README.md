�R���p�N�g��mjpg-streamer

# make
git clone https://github.com/kubotan/mjpg-streamer ./mjpg-streamer
cd mjpg-streamer
sh make.sh

#1�䎩���N���̏ꍇ�͈ȉ������s
sh setup.sh
systemctl stop mjpg-streamer  # �蓮�I���e�X�g
systemctl start mjpg-streamer  # �蓮�N���e�X�g

#2�䎩���N���̏ꍇ�͈ȉ������s
sh setup2.sh
systemctl stop mjpg-streamer1  # �蓮�I���e�X�g
systemctl start mjpg-streamer1  # �蓮�N���e�X�g
systemctl stop mjpg-streamer2  # �蓮�I���e�X�g
systemctl start mjpg-streamer2  # �蓮�N���e�X�g

�ȉ���mjpg�X�g���[�~���O�̊m�F�\
http://XXX.XXX.XXX.XXX:8080/?action=stream

2��ڂ�http://XXX.XXX.XXX.XXX:8081/?action=stream

# �i���b�W
USB�ڑ��m�F
lsusb 
�c�[���̃C���X�g�[��
sudo apt-get install v4l-utils
�f�o�C�X���̕\��
v4l2-ctl -d /dev/video0 --info
���ڍׂȏ��\��
v4l2-ctl -d /dev/video0 --all
�Ή����Ă���𑜓x�ƃt���[�����[�g�ꗗ�\��
v4l2-ctl -d /dev/video0 --list-formats-ext

# raspbian�֘A�i���b�W
���[�U�[��:pi
�p�X���[�h:raspberry
sudo su -
raspi-config
(SSH�T�[�r�X��L���ɂ���BTimezone��Asia/Tokyo�ɐݒ肷��BWi-Fi���g���ꍇ�͂����ŗL���ɂ��邪fps��������̂ŗL���Ƃ����B)
cp -p /etc/dhcpcd.conf /etc/dhcpcd.conf.org
vi /etc/dhcpcd.conf
interface eth0(Wi-Fi���g���ꍇ��wlan0)
static ip_address=XXX.XXX.XXX.XXX/24
static routers=XXX.XXX.XXX.XXX
static domain_name_servers=XXX.XXX.XXX.XXX 8.8.8.8

echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
sudo su -
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
