mkdir /var/www/html

cat aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  month=$(echo "$dob" | sed 's/\s.*$//')
  echo "$month"

  mkdir /var/www/html/"$permission" /var/www/html/"$permission"/"$month"
  touch /var/www/html/"$permission"/"$month"/index.html
  echo "$country","$color","$fruits","$os","$shell","$username","$first","$last","$gender" >> /var/www/html/"$permission"/"$month"/index.html
done
