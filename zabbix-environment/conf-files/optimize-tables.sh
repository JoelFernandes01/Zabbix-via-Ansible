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
mysqldump -u"$mysql_root_user" -p"$mysql_root_pass" "$mysql_zbx_mdb" --single-transaction --skip-lock-tables --routines --triggers --no-create-info --no-create-db \
    --ignore-table "$mysql_zbx_mdb".auditlog \
    --ignore-table "$mysql_zbx_mdb".auditlog_details \
    --ignore-table "mysql_zbx_mdb".escalations \
    --ignore-table "mysql_zbx_mdb".events \
    --ignore-table "mysql_zbx_mdb".history \
    --ignore-table "mysql_zbx_mdb".history_log \
    --ignore-table "mysql_zbx_mdb".history_str \
    --ignore-table "mysql_zbx_mdb".history_str_sync \
    --ignore-table "mysql_zbx_mdb".history_sync \
    --ignore-table "mysql_zbx_mdb".history_text \
    --ignore-table "mysql_zbx_mdb".history_uint \
    --ignore-table "mysql_zbx_mdb".history_uint_sync \
    --ignore-table "mysql_zbx_mdb".dhosts \
    --ignore-table "mysql_zbx_mdb".dservices \
    --ignore-table "mysql_zbx_mdb".proxy_history \
    --ignore-table "mysql_zbx_mdb".proxy_dhistory \
    --ignore-table "mysql_zbx_mdb".trends \
    --ignore-table "$mysql_zbx_mdb".trends_uint > Diario.$mysql_zbx_mdb.$today.sql
echo =======================================================================================
echo 				Fim do backup do dia $today 
echo =======================================================================================

sleep 5
echo =======================================================================================
echo 	    "Copiando o arquivo "Diario.$mysql_zbx_mdb.$today.sql" para o servidor remoto !" 
echo =======================================================================================
sleep 5
scp Diario.$mysql_zbx_mdb.$today.sql $bkp_root_user@$bkp_srv_addr:$bkp_srv_rem

echo =======================================================================================
echo 	    "Copiando o arquivo "Diario.$mysql_zbx_mdb.$today.sql" para a pasta $bkp_srv_loc !" 
echo =======================================================================================
sleep 5
mv /root/$mysql_zbx_mdb.$today.sql $bkp_srv_loc
ls -la $bkp_srv_loc
