firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload

mkdir /home/mac /home/windows

cat aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do 
  mkdir /home/"$os"/"$country" /home/"$os"/"$country"/"$username"
  touch /home/"$os"/"$country"/"$username"/about
  groupadd "$color" 
  groupadd "$fruits"
 
   if [[ "$os" == "mac" ]]; then
    touch /home/"$os"/"$country"/"$username"/.DS_Store
    echo "$first $last" >> /home/"$os"/"$country"/"$username"/about
    echo "$dob" >> /home/"$os"/"$country"/"$username"/about
    useradd -d /home/"$os"/"$country"/"$username" -G "$color" "$username"
  elif [[ "$os" == "windows" ]]; then
    touch /home/"$os"/"$country"/"$username"/Thumbs.db
    echo "$last $first" >> /home/"$os"/"$country"/"$username"/about
    echo "$shell" >> /home/"$os"/"$country"/"$username"/about
    useradd -d /home/"$os"/"$country"/"$username" -G "$fruits" "$username"
  else
    echo "Error not valid"
  fi
done
