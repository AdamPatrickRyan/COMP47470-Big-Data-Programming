#!/bin/bash

function name_fix() 
{

    #Cleanse the Name - Remove Quotes and the character
    #Simple impl. without using a regex as natively supported by bash.

    local result=$1
    result=${result/\#\]/''}
    result=${result//\"/''}

    echo "$result"

}

function inital_cleanse() 
{

    #From the tutorial sheets 

    cp $1 $2

    while grep -q '"[^"][^"]*-.*"' $2;

        #NOTE: THIS LINE IS OPERATING SYSTEM DEPENDANT! For my laptop it needs the two single quotes.
        #On other operating systems this often is taken as just: do sed -i 's/\("[^"][^"]*\)-\(.*"\)/\1 \2/' $2
        do sed -i '' 's/\("[^"][^"]*\)-\(.*"\)/\1 \2/' $2

    done


}

function country_map() 
{

    #Find the country code and then replace it with the third column in the file.

    local country_code=$1
    local country_file_name=$2
    local country_delim_name=$3
    local return_value=''

	if grep -q "$country_code" $country_file_name
        then
            return_value="$(grep "$country_code" $country_file_name | cut -d"$3" -f3)"
            #return_value=${return_value//\-/'_'}
            #return_value=${return_value//'_'/' '}
    else
            return_value=$country_code
    fi

    echo "$return_value"

}




function initial_formatting_q1()

{



    #This does part 
    local initial_file="bashdm.csv"
    local country_file_name="countries.csv"
    local staging_file="bashdm-clean-p1.csv"
    local output_file="bashdm-clean-p2.csv"
    local final_file="bashdm-clean.csv"
    local country_file_delim="&"

    inital_cleanse $initial_file $staging_file

    exec < $staging_file

    while IFS="-" read -a csv_line; do 

        field_count=${#csv_line[@]}
        Index=${csv_line[0]}
        Name=$(name_fix "${csv_line[1]}")
        Age=${csv_line[2]}
        Country=$(country_map "${csv_line[3]}" "$country_file_name" "$country_file_delim")
        Height=${csv_line[4]}
        Hair_Colour=${csv_line[5]}
        YLA=${csv_line[6]}
        CONF=${csv_line[7]}

        echo "$Index,$Name,$Age,$Country,$Height,$Hair_Colour,$YLA,$CONF";

    done > $output_file

    rm -f $staging_file
    echo "$output_file"

}



function removing_single_value_fields_q1()

{
    local input_file=$1
    local output_file=$2
    local fields_to_keep=""
    local column_count=1

    for ((i=1; i<9; i++)) do

        column_count="$(cat $input_file | cut -d"," -f $i | sort | uniq | wc -l)"

        if [[ "$column_count" -gt "2" ]];
        then

            if [[ "$fields_to_keep" == "" ]];
            then
                fields_to_keep+="$i"
            else
                fields_to_keep+=",$i"
            fi

        fi

    done

    if [[ "$fields_to_keep" != '' ]];
    then
        cut -d"," -f "$fields_to_keep" "$input_file" > "$output_file"

    else
        cp $input_file $output_file
    fi

    rm $input_file

}


function main_run_q1()
{
    csv_name=$(initial_formatting_q1)
    removing_single_value_fields_q1 "$csv_name" "bash-clean.csv"

}


main_run_q1
