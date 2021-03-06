rm -rf /etc/named/zones/*


cat /root/aantu014.csv | cut -d "," -f7 | xargs -n1 | sort -u | while IFS="," read color;
do
cat << EOF>> /etc/named/zones/db.${color}.aantu014.cts4348.fiu.edu
\$TTL    604800
@       IN      SOA     ns1.cts4348.fiu.edu. aantu014.cts4348.fiu.edu. (
                              3         ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL

; name servers - NS records
    IN      NS      ns1.cts4348.fiu.edu.
    IN      NS      ns2.cts4348.fiu.edu.

EOF

  count=0
  grep -w "${color}" /root/aantu014.csv | cut -d "," -f1 | while IFS="," read username;
  do
    count=$((count+1))
    echo "$username     IN A 192.168.66.${count}" >> /etc/named/zones/db.${color}.aantu014.cts4348.fiu.edu
  done
done

systemctl restart named
