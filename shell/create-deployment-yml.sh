#!/bin/bash

DEPLOYMENT_YML=$1

sudo cp ${DEPLOYMENT_YML}.example $DEPLOYMENT_YML

echo -n "MYSQL_USER: "
read input
sed -i -e "s/MYSQL_USER_XXX/${input}/g" $DEPLOYMENT_YML

echo "GRANT ALL ON *.* TO '${input}'@'%';" > mysql_init/grant.sql

echo -n "MYSQL_PASSWORD: "
read input
sed -i -e "s/MYSQL_PASSWORD_XXX/${input}/g" $DEPLOYMENT_YML