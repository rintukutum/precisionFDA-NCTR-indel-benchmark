#!/bin/bash
filename='panelA.txt'
while read p; do 
    ./pfda download --file-id $p --output /mnt/d/'Ashoka Internship'/FDA  
done < "$filename"