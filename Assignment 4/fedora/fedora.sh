mysql -e "CREATE DATABASE color"
mysql -e "CREATE DATABASE gender"

rm fedora.js
touch fedora.js

rm del_fedora.js
touch del_fedora.js

grep ',m,' aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  hash=$(echo "$username,$first,$last,$gender,$dob,$country,$color,$fruits,$os,$shell,$permission" |md5sum |cut -d " " -f1)

    mysql -e " use color;
    create table $color ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"
    mysql -e " use color;
    insert into $color ( uid, first, last, md5 ) values ( '$username', '$first', '$last', '$hash');"

    mysql -e " use gender;
    create table $gender ( uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255) );"
    mysql -e " use gender;
    insert into $gender ( uid, first, last, md5 ) values ( '$username', '$first', '$last', '$hash');"

    echo "use color;
    db.createCollection('$color');
    db.$color.insert({'uid':'$username','first':'$first','last':'$last','md5':'$hash'} );" >> fedora.js

    echo "use gender;
    db.createCollection('$gender');
    db.$gender.insert({'uid':'$username','first':'$first','last':'$last','md5':'$hash'} );" >> fedora.js

    if [[ "$os" == "windows" ]]; then
    mysql -e "use color;
    delete from $color where uid='$username';"

    mysql -e "use gender;
    delete from $gender where uid='$username';"

    echo "use color;
    db.$color.remove({ 'uid': '$username' });" >> del_fedora.js

    echo "use gender;
    db.$gender.remove({ 'uid': '$username' });" >> del_fedora.js
  fi
done

mongo < fedora.js
mongo < del_fedora.js