#!/bin/bash

## Variáveis 
mysqldump=/usr/bin/mysqldump
mysql_root_user=root
mysql_root_pass=123@Mudar
mysql_zbx_mdb=zbxsrvmdb 

bkp_srv_loc=/backups

bkp_root_user=root
bkp_root_pass=connect
bkp_srv_addr=ansible-server-01.connect.local
bkp_srv_rem=/ansible-roles/ansible-lab/conf-files

today=$(date +'%d-%m-%y-%Hh-%Mm')
echo =======================================================================================
echo 				Início do backup do dia $today 
echo =======================================================================================

sleep 5
$mysqldump -u$mysql_root_user -p$mysql_root_pass $mysql_zbx_mdb > Semanal.$mysql_zbx_mdb.$today.sql
echo =======================================================================================
echo 				Fim do backup do dia $today 
echo =======================================================================================

sleep 5
echo =======================================================================================
echo 	    "Copiando o arquivo "Semanal.$mysql_zbx_mdb.$today.sql" para o servidor remoto !" 
echo =======================================================================================
sleep 5
scp Semanal.$mysql_zbx_mdb.$today.sql $bkp_root_user@$bkp_srv_addr:$bkp_srv_rem

echo =======================================================================================
echo 	    "Copiando o arquivo "Semanal.$mysql_zbx_mdb.$today.sql" para a pasta $bkp_srv_loc !" 
echo =======================================================================================
sleep 5
mv /root/Semanal.$mysql_zbx_mdb.$today.sql $bkp_srv_loc
ls -la $bkp_srv_loc
