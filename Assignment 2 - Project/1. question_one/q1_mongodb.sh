#!/bin/bash

#Load
mongoimport --db test --collection bashdm --drop --type csv --headerline --file bashdm-clean.csv

#Note: should be index+1 as row_id starts at 1 while index at 0.
mongo test --eval '

    myCursor = db.bashdm.find({})

    count=0;

    while (myCursor.hasNext()) {
        count+=1;
        db.bashdm.updateOne(
                                {_id: myCursor.next()._id},
                                {"$set":{"row_id": count}}
                            )
    }'

#This is not as efficient as sort, but I assume we were looking for aggregation rather than sorting and taking top 1.
mongo test --eval 'db.bashdm.aggregate(
                                [
                                    {
                                    $group:
                                        {
                                          _id : "1"
                                        ,record: 
                                            {
                                                "$min": 
                                                    {
                                                        minHeight:"$Height",
                                                        row_id:"$row_id",
                                                        index: "$INDEX",
                                                        Age : "$Age", 
                                                        Name : "$Name",
                                                        Country: "$Country",
                                                        Hair_Colour: "$Hair_Colour"
                                                    }
                                            }
                                        }
                                    }
                                ]
                            ).pretty()'
                    