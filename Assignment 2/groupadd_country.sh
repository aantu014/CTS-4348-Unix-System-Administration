sed -n -e '401,600p' aantu014.csv | cut -d "," -f6 | sed 's/,[a-z]/\U&/g' | while IFS="," read groupname;
do
  groupadd "$groupname"
done
