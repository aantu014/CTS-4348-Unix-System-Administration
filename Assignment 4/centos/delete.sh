rm del.js
grep ',f,' aantu014.csv | cut -d "," -f1,2,3,4,5,6,7,8,9,10,11 | while IFS="," read username first last gender dob country color fruits os shell permission;
do
  s=$(echo $shell | cut -d "/" -f3)

  if [[ "$os" == "mac" ]]; then
    ###Maria###
    mysql -e " use shells;
    delete from $s where uid='$username';"

    ###Mongo###
    echo "use shells;
    db.$s.remove({ 'uid': '$username' });" >> del.js
  fi
done

mongo < del.js
