# NOTE:run these as root (or prefixed with sudo)

# install required packages
apt-get install alsa-utils autoconf libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev avahi-daemon libavahi-client-dev libssl-dev

# grab the source
git clone https://github.com/mikebrady/shairport-sync.git

# build it
cd shairport-sync
autoreconf -i -f
./configure --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-systemd
make

# create a user account for it and add it to the audio group
groupadd -r shairport-sync
useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync

# install and enable service
make install
systemctl enable shairport-sync

# set volume to 100%
amixer set PCM 100%
