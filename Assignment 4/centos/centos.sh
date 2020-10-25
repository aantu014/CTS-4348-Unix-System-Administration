mysql -e "CREATE DATABASE country"
mysql -e "CREATE DATABASE fruits"

rm centos.js
touch centos.js

rm del_centos.js
touch del_centos.js

grep ',f,' aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  hash=$(echo "$username,$first,$last,$gender,$dob,$country,$color,$fruits,$os,$shell,$permission" |md5sum |cut -d " " -f1)

    mysql -e " use country;
    create table $country ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"
    mysql -e " use country;
    insert into $country ( uid, first, last, md5 ) values ( '$username', '$first', '$last', '$hash');"

    mysql -e " use fruits;
    create table $fruits ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"
    mysql -e " use fruits;
    insert into $fruits ( uid, first, last, md5 ) values ( '$username', '$first', '$last', '$hash');"

    echo "use country;
    db.createCollection('$country');
    db.$country.insert({'uid':'$username','first':'$first','last':'$last','md5':'$hash'} );" >> centos.js

    echo "use fruits;
    db.createCollection('$fruits');
    db.$fruits.insert({'uid':'$username','first':'$first','last':'$last','md5':'$hash'} );" >> centos.js

    if [[ "$os" == "mac" ]]; then
    mysql -e "use country;
    delete from $country where uid='$username';"

    mysql -e "use fruits;
    delete from $fruits where uid='$username';"

    echo "use country;
    db.$country.remove({ 'uid': '$username' });" >> del_centos.js

    echo "use fruits;
    db.$fruits.remove({ 'uid': '$username' });" >> del_centos.js
  fi
done

mongo < centos.js
mongo < del_centos.js
