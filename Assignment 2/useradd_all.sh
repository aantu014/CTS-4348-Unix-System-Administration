sed -n -e '601,1000p' aantu014.csv | cut -d "," -f1,2,3,7,10 | while IFS="," read username firstname lastname groupname shell;
do
  groupadd "$groupname"
  useradd -c "$firstname $lastname" -G "$groupname" -s "$shell" "$username"
done
