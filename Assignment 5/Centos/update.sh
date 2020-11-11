count=0
def_port=8866

cat aantu014.csv | cut -d "," -f8 | xargs -n1 | sort -u  | while IFS="," read f;
do
  rm -f /etc/httpd/conf.d/aantu014/$f.conf
  rm -rf /var/www/"$f"
done

cat aantu014.csv | cut -d "," -f9 | xargs -n1 | sort -u  | while IFS="," read o;
do
  port=$((def_port+$count))
  maxp=8885
  echo $o.conf 
  if [ "$port" -le "$maxp" ];then
cat << EOF >> /etc/httpd/conf.d/aantu014/$o.conf
Listen $port
<VirtualHost *:$port>
 ServerName localhost
 DocumentRoot /var/www/$o/
 SSLEngine on
 SSLCertificateFile /root/aantu014-selfsigned.crt
 SSLCertificateKeyFile /root/aantu014-selfsigned.key
</VirtualHost>
EOF
  fi

  count=$count+1
done

cat aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  month=$(echo "$dob" |cut -d " " -f1)

  if [[ "$month" == "january" ]] || [[ "$month" == "march" ]] || [[ "$month" == "may" ]] || [[ "$month" == "july" ]] || [[ "$month" == "september" ]] || [[ "$month" == "november" ]]; then
    mkdir /var/www/"$os"
    echo "$username,$first,$last,$gender,$dob,$country,$color,$fruits,$os,$shell,$permission" >> /var/www/"$os"/index.html
  fi
done
