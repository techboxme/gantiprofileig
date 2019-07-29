#!/bin/bash
# Instagram : @techboxme

clear
printf "\033[1;32m	++++++++++++++++++++	\n"
printf "\033[1;33m	 Ganti profile pict	\n"
printf "\033[1;32m	++++++++++++++++++++	\n"
echo
csrftoken=$(curl https://www.instagram.com/accounts/login/ajax -L -i -s | grep "csrftoken" | cut -d "=" -f2 | cut -d ";" -f1)
login_user() {

if [[ "$default_username" == "" ]]; then
read -p $'\033[1;31m[√]\033[1;35m Login: \033[1;36m' username
else
username="${username:-${default_username}}"
fi

if [[ "$default_password" == "" ]]; then
IFS=$'\n'
read -s -p $'\033[1;31m[√]\033[1;35m Password: \033[1;36m' password
else
password="${password:-${default_password}}"
fi

printf "\n\033[1;34m[+]\033[1;33m Mencoba Login %s\033[1;32m\n" $username

IFS=$'\n'
echo
check_login=$(curl -c cookies.txt 'https://www.instagram.com/accounts/login/ajax/' -H 'Cookie: csrftoken='$csrftoken'' -H 'X-Instagram-AJAX: 1' -H 'Referer: https://www.instagram.com/' -H 'X-CSRFToken:'$csrftoken'' -H 'X-Requested-With: XMLHttpRequest' --data 'username='$username'&password='$password'&intent' -L --compressed -s | grep -o '"authenticated": true')
echo $check_login
if [[ "$check_login" == *'"authenticated": true'* ]]; then
echo
printf "\033[1;34m[+]\033[1;33m Login berhasil!\n"
else
printf "\033[1;34m[+]\033[1;33m Login gagal!\n"

login_user
fi

}

change_picture() {

read -p $'\033[1;31m[√]\033[1;35m Lokasi gambar : \033[1;36m' path_pic

if [[ ! -e $path_pic ]]; then
printf "\033[1;34m[!]\033[1;33m Lokasi file tidak di temukan\n"
exit 1
else
if [[ ! $path_pic == *".jpg" ]]; then
printf "\033[1;34m[!]\033[1;33m Gagal! Gunakan file format .jpg\n"
exit 1
else


curl -b cookies.txt 'https://www.instagram.com/accounts/web_change_profile_picture/' -H 'origin: https://www.instagram.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: pl-PL,pl;q=0.8,en-US;q=0.6,en;q=0.4' -H 'x-requested-with: XMLHttpRequest' -H 'cookie:  csrftoken='$csrftoken';' -H 'x-csrftoken: '$csrftoken'' -H 'pragma: no-cache' -H 'x-instagram-ajax: 1' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36' -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundarycqpuFD4uRAhkxVFt' -H 'accept: */*' -H 'cache-control: no-cache' -H 'authority: www.instagram.com' -H 'referer: https://www.instagram.com/'$username'' --compressed -F 'profile_pic=@'$path_pic'' 
fi
fi
}

login_user
change_picture
clear
sleep 1.5
echo
printf "\033[1;33m ------------------------------\n"
printf "\033[1;31m 	Suksess diubah brow	 \n"
printf "\033[1;32m ------------------------------\n"
