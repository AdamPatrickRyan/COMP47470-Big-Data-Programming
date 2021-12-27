#!/bin/bash

echo "line 1"
mysql -e 'drop database if exists 14395076_assignment;'

echo "line 2"
mysql -e 'create database 14395076_assignment;'

echo "line 3"
mysql -e 'use 14395076_assignment;'

echo "line 4"
mysql -D '14395076_assignment' -e "DROP TABLE IF EXISTS bashdm"

echo "line 5"
mysql -D '14395076_assignment' -e "CREATE TABLE bashdm 
                                        (pk_index               INT             NOT NULL
                                        ,name                  VARCHAR(128)
                                        ,age                   INT
                                        ,country               VARCHAR(255)
                                        ,height                 INT
                                        ,hair_colour            VARCHAR(40)
                                        ,Primary Key (pk_index));"

exec <  "bashdm-clean.csv"


#Note: Not as efficient as reading column at once, BUT allows for line-by-line posting
while IFS="," read -a csv_line; do 
    Index="${csv_line[0]}"
    Name="${csv_line[1]}"
    Age="${csv_line[2]}"
    Country="${csv_line[3]}"
    Height="${csv_line[4]}"
    Hair_Colour="${csv_line[5]}"

    #no -u or -p in the container
    if [[ $Index != "INDEX" ]]; 
    then
            mysql -D '14395076_assignment' -e "INSERT INTO bashdm(pk_index,name,age,country,height,hair_colour) values ('$Index','$Name','$Age','$Country','$Height','$Hair_Colour');" 
    fi


done

mysql -D '14395076_assignment' -e "SELECT
                                        country                     AS      country
                                        ,ROUND(AVG(height),2)       AS      avg_height
                                    FROM
                                        bashdm bdm
                                    GROUP BY
                                        country
                                    " > avg_height.csv



mysql -D '14395076_assignment' -e "SELECT
                                        hair_colour                     AS      hair_colour
                                        ,MAX(height)                AS      max_height
                                    FROM
                                        bashdm bdm
                                    GROUP BY
                                        hair_colour
                                    " > max_hair_colour.csv