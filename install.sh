#!/bin/bash
clear
CURRENTSRC='openssl-1.0.1e'

SRCFILE="$CURRENTSRC.tar.gz"

echo SRCFILE
echo =====
echo Sash\'s all encompassing openssl installer for $CURRENTSRC
echo excluding GOST \(русский\) and unimplemented DH ciphers such as DH-DSS-SEED-SHA
echo =====
echo
echo Removing current openssl installation
echo
read -p "Are you sure you want to remove? y/n...." -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo Removing $OPENSSLVERSION
    apt-get -y remove openssl 
else
	exit 1
fi 

echo Downloading $CURRENTSRC from http://www.openssl.org/source/$SRCFILE...
wget http://www.openssl.org/source/$SRCFILE
echo done

echo installing zlib1g for compression awesomeness...
apt-get install zlib1g-dev
echo done
tar -xvf $SRCFILE
echo extracting openssl
cd $CURRENTSRC
echo done

echo configuring openssl with mad options
./config --prefix=/usr enable-aes enable-bf enable-camellia enable-cast enable-des enable-dh enable-dsa enable-ec enable-hmac enable-idea enable-md2 enable-md4 enable-md5 enable-mdc2 enable-rc2 enable-rc4 enable-rc5 enable-ripemd enable-rsa enable-seed enable-sha enable-sha0 enable-sha1 enable-sha256 enable-sha512 enable-deprecated enable-ecdsa enable-ecdh enable-gost enable-krb5 shared zlib enable-rfc3779
echo done

echo make depend...
make depend
echo make...
make
echo installing...
make install
echo done
echo ==========
echo
echo `openssl version` installed
echo
echo ===============
echo
echo enjoy!
echo
echo==============
