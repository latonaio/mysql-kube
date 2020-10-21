## how to setup

[1] mysql_init内に初期データ挿入用のSQLファイルを配置してください

```
$ mkdir mysql_init
$ cp 初期データ挿入用のSQLファイルパス mysql_init/
```

[2] 以下コマンドを実行してください（対話式のスクリプトが起動します）

```
$ make install
MYSQL_USER: 「MySQLユーザ名」を入力
MYSQL_PASSWORD: 「MySQLパスワード」を入力
```

[3] 以下コマンドでMySQLのPodが正常に起動している事を確認してください

```
$ kubectl get po | grep mysql
```