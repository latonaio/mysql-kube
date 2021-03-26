#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ $# -ne 4 ]; then
	echo "Usage:"
	echo "sh create-deployment-yml.sh [project directory] [persitent volume size] [user name] [password]"
	exit 1
fi

PRJ_DIR=$1
PV_SIZE=$2
USER_NAME=$3
PASSWORD=$4

TEMPLATES=$(ls ${SCRIPT_DIR}/../${PRJ_DIR}/*.template)
for template in ${TEMPLATES};
do
	cp ${template} ${template%.*}
	sed -i -e "s/MYSQL_USER_XXX/${USER_NAME}/g" ${template%.*}
	sed -i -e "s/MYSQL_PASSWORD_XXX/${PASSWORD}/g" ${template%.*}
	sed -i -e "s/PV_SIZE/${PV_SIZE}/g" ${template%.*}
	cp ${template%.*} ${SCRIPT_DIR}/..
done

echo "GRANT ALL ON *.* TO '${USER_NAME}'@'%';" > ${SCRIPT_DIR}/../mysql_init/grant.sql
