#!/bin/sh
## base config
MYSQL_HOME=mysql
MYSQL_USER=test
MYSQL_PASSWD=******

CSS_FILE_NAME="style.css"

## db
if [ "$1" = "" ]; then
        DB_NAME=test_fuel
elseorn
        DB_NAME=$1
fi
OUTPUT=$DB_NAME.html

## table
MYSQL="$MYSQL_HOME -u $MYSQL_USER -p$MYSQL_PASSWD $DB_NAME"
TABLES=`echo "show tables;" | $MYSQL -s`

## export html
echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">" > $OUTPUT
echo "<html xmlns=\"http://www.w3.org/1999/xhtml\">" >> $OUTPUT
echo "<head>" >> $OUTPUT
echo "<title>MySql DB Document : $DB_NAME</title>" >> $OUTPUT
echo "<link rel=\"stylesheet\" href=\"$CSS_FILE_NAME\" type=\"text/css\" />" >> $OUTPUT
echo "</head>" >> $OUTPUT
echo "<body>" >> $OUTPUT
echo "<h1>Mysql DB Document : $DB_NAME</h1>" >> $OUTPUT

for TABLE_NAME in $TABLES;
do
    TABLE_STATUS=(`echo "show table status like '$TABLE_NAME'" | $MYSQL -s`)
    echo "<h3>$TABLE_NAME : ${TABLE_STATUS[18]}</h3>" >> $OUTPUT
    echo "show full columns from $TABLE_NAME;" | $MYSQL -H >> $OUTPUT
done

echo "</body>" >> $OUTPUT
echo "</html>" >> $OUTPUT
