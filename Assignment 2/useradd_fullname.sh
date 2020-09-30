sed -n -e '201,400p' aantu014.csv | cut -d "," -f1,2,3 | sed 's/,[a-z]/\U&/g' | while IFS="," read username firstname lastname;
do
  useradd "$username" -c "$firstname $lastname"
done
