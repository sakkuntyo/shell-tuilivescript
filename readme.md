このスクリプトはターミナル上に表示される情報を youtube に配信します。

<img width="1269" height="863" alt="image" src="https://github.com/user-attachments/assets/da9debc9-6634-4565-9543-87743a3f4183" />

# 使い方
1. live.sh の ENV_STREAM_KEY の値を自身のストリームキーに書き換えます。
2. live.sh の glances --disable-plugin fs,diskio 部分を好きなコマンドに置き換えます。
3. live.sh を実行すると、配信されます。

- 2 で指定したコマンドは tmux セッション上で実行され、tmux 上の出力が配信されます。
- コンテナで使う場合は ENV_STREAM_KEY を指定してください。
