#!/bin/bash

#### CORES ####
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Blue='\033[0;34m'         # Blue
White='\033[0;37m'        # White
Yellow='\033[0;33m'       # Yellow


echo -e " $Red
#########################################

       $White By
       $White   H0lmmes
$Red
#########################################

"


#### Tratamento dos argumentos
if [[ $# -lt 1 || $# -gt 1 ]]
  then  
        echo -e "$White Use:$Blue./finder.sh  wwww.site.com.br"

else
    ### Baixando html
    url=$1
    wget $url  -O /tmp/site_temp.txt > /dev/null 2>&1

    ### Encontrando as urls
    cat site_temp.txt | grep "href" | grep "\." | cut -d '/' -f3 | cut -d '"' -f1 | grep -v 'link' | grep -v '<l' >> /tmp/temp.txt

    ### Resolvendo os nomes 
    for i in $(cat /tmp/temp.txt)
        do  
                ips=$(host $i | grep "has address" | cut -d " " -f4)
                if [[ $ips == "" ]]
                then
                        echo -e " $Blue URL:$Green $i  $Blue IP:$Red Not Found "   
                else  
                echo -e " $Blue URL:$Green $i  $Blue IP:$Green $ips "  
                fi

        done            
    
fi


#### Deletando os arquivos temporarios
rm -f /tmp/site_temp.txt   /tmp/temp.txt
