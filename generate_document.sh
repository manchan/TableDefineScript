#!/bin/sh
IFS='
'

db_name=$1
if [ "$db_name" = "" ]; then
    echo "you should specify a name of db."
    exit
fi


echo "<html>"
echo "<body>"
for table in `mysql -u root -e 'show tables' -D $db_name --silent --skip-column-names`
do

    echo "<b>$table</b>"
    echo "<table border=1>"
    echo "<tr>"
    echo "    <td>Field</td>"
    echo "    <td>Type</td>"
    echo "    <td>Null</td>"
    echo "    <td>Key</td>"
    echo "    <td>Default</td>"
    echo "    <td>Extra</td>"
    echo "    <td>Comment</td></tr>"

    for line in `mysql -u root  -D $db_name -e "show full columns from $table" --skip-column-names`
    do
        _field=`echo $line | cut -f1`
        _type=`echo $line | cut -f2`
        _null=`echo $line | cut -f4`
        _key=`echo $line | cut -f5`
        _default=`echo $line | cut -f6`
        _extra=`echo $line | cut -f7`
        _comment=`echo $line | cut -f9`

        if [ "$_key" = "" ]; then
            _key="&nbsp;"
        fi
        if [ "$_null" = "" ]; then
            _null="&nbsp;"
        fi
        if [ "$_default" = "" ]; then

            _default="&nbsp;"
        fi
 		if [ "$_extra" = "" ]; then
            _extra="&nbsp;"
        fi
        if [ "$_extra" = "" ]; then
            _extra="&nbsp;"
        fi
        if [ "$_comment" = "" ]; then
            _comment="&nbsp;"
        fi

        echo "<tr>"
        echo "    <td>${_field}</td>"
        echo "    <td>${_type}</td>"
        echo "    <td>${_null}</td>"
        echo "    <td>${_key}</td>"
        echo "    <td>${_default}</td>"
        echo "    <td>${_extra}</td>"
        echo "    <td>${_comment}</td></tr>"
    done

    echo "</table>"
    echo "<br>"

    echo -e "\n\n\n\n\n"
done

echo "</body>"
echo "</html>"








