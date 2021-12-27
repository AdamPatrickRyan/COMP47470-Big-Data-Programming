##------------------Extractor---------------##
## 
##User:     Aryan
##DC:       2021-11-24
##DLM:      2021-11-25
##MC:       COMP47470
##SD:       Assignment 2 solution
##
##------------------Extractor---------------##

Note: This was written and ran on an M1 Mac so slight differences may be required for other machines. Adjust appropriately.

Instructions.

1. For question one open the folder called question_one.

    1. Run q1_part1_cleaning.sh 
    This completes Q1.1. For auditting/tracking the script makes use of some temporary files and then removes them. If you want to view the intermediary parts, then comment out the removal sections.
    --If you're on Windows, change the grep and sed component to remove the '' which is needed on Mac but not on Windows; I don't know about Linux so fix appropriately for your system.


    2. Run q1_mysql.sh 
    This completes the MySQL portion of Q1.2.
    If you need a different configuration for your MySQL instance configure it and adjust the MySQL calls appropriately. This saves the answers to Q1.2.1/2 as max_hair_colour and avg_height respectively.


    3. Run q1_mongodb.sh 
    This completes the MongoDB portion of Q1.3. 

2. For question two open the folder called question_two.

    1. Start your hadoop environment.
    
    2. Setup the Java files and appropriately build them on the server
    
    3. Run each file.
    
    4. Retrieve the outputs by copying from the hdfs dfs to your local intance.
    
3. For question three open the folder called question_three.

    1. Start your spark shell.
    
    2. Locate the code in scala.txt for the answers
    
    3. Import (or don't import) modules as appropriate to your setup (sample given which I required in the script).
    
    4. Paste the code for the answers (note the sparkSession line may not be needed dpeending on your environment/imports/setup) from the df definition (reading the CSV) to end for answers to all parts.
    
4. For question four open the folder called question_four.

    1. Start the spark shell.
    
    2. Locate the code in graphx_ans.txt for the answers
    
    3. Import (or don't import) modules as appropriate to your setup (sample given which I required in the script).
    
    4. Paste the code for the answers.

NOTE: This assumes all files are downloaded and saved in the path where things will be run. If not, do that or adjust paths/file names appropriately.

I used the original graphx edge set which seemingly is different to the new one, so carefully check your set as changes may be needed if different.