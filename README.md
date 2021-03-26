## how to setup

[1] mysql_init内に初期データ挿入用のSQLファイルを配置してください

```
$ mkdir mysql_init
$ cp 初期データ挿入用のSQLファイルパス mysql_init/
```

[2] 以下コマンドを実行してください

```
$ make install-default PV_SIZE=1Gi USER_NAME=${MYSQL_USER} USER_PASSWORD=${MYSQL_PASSWORD}
PV_SIZE 任意のストレージサイズ
MYSQL_USER: 任意の「MySQLユーザ名」
MYSQL_PASSWORD: 任意の「MySQLパスワード」
```

[3] 以下コマンドでMySQLのPodが正常に起動している事を確認してください

```
$ kubectl get po | grep mysql
```
