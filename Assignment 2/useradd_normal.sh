sed -n -e '1,200p' aantu014.csv | cut -d "," -f1 | while IFS="," read username;
do
  useradd "$username"
done
