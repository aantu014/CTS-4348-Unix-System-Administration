mkdir /home/mac /home/windows


cat aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do 
  mkdir /home/"$os"/"$country" /home/"$os"/"$country"/"$username"
  useradd -d /home/"$os"/"$country"/"$username" "$username"
  touch /home/"$os"/"$country"/"$username"/about
 
   if [[ "$os" == "mac" ]]; then
    touch /home/"$os"/"$country"/"$username" .DS_Store
    echo "$first $last" >> /home/"$os"/"$country"/"$username"/about
    echo "$dob" >> /home/"$os"/"$country"/"$username"/about
  elif [[ "$os" == "windows" ]]; then
    touch /home/"$os"/"$country"/"$username" Thumbs.db
    echo "$last $first" >> /home/"$os"/"$country"/"$username"/about
    echo "$shell" >> /home/"$os"/"$country"/"$username"/about
  else
    echo "Error not valid"
  fi
 
# echo "" > /home/"$os"/"$country"/"$username"/about

# echo "$firstname $lastname" "$groupname" "$shell" "$username"
done
