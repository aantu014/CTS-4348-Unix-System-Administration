mysql -e "CREATE DATABASE shells"
mysql -e "use shells;
create table bash ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"

mysql -e "use shells;
create table csh ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"

mysql -e "use shells;
create table ksh ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"

mysql -e "use shells;
create table tcsh ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"

cat << EOF > script.js
use shells;
db.createCollection('bash');
db.createCollection('csh');
db.createCollection('ksh');
db.createCollection('tcsh');
EOF

grep ',m,' aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  hash=$(echo "$username,$first,$last,$gender,$dob,$country,$color,$fruits,$os,$shell,$permission" |md5sum |cut -d " " -f1)

  s=$(echo $shell | cut -d "/" -f3)

  ###Maria###
  mysql -e " use shells;
  insert into $s ( uid, first, last, md5 ) values ( '$username', '$first', '$last', '$hash');"

  ###Mongo###
  echo "use shells;
  db.$s.insert({'uid':'$username','first':'$first','last':'$last','md5':'$hash'} );" >> script.js
done

mongo < script.js
