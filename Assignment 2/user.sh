mkdir /home/mac /home/windows


cat aantu014.csv | cut -d "," -f1,2,3,6,7,9,10 | while IFS="," read username firstname lastname country groupname os shell;
do 
  mkdir /home/"$os"/"$country" /home/"$os"/"$country"/"$username"
  useradd -d /home/"$os"/"$country"/"$username" "$username"
  touch /home/"$os"/"$country"/"$username"/about
 
# echo "" > /home/"$os"/"$country"/"$username"/about

# echo "$firstname $lastname" "$groupname" "$shell" "$username"
done
