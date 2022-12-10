# 『はじめて学ぶバイナリ解析』実行環境（非公式）

『はじめて学ぶバイナリ解析』[^1]の課題の実行環境を提供します。
Dockerを使っていて、Virtual Boxよりも資材が軽い(~1.7GB)のが特徴です。

[^1]: [『はじめて学ぶバイナリ解析　不正なコードからコンピュータを守るサイバーセキュリティ技術』インプレスR&D、小林 佐保／岡田 怜士／浅部 佑／満永 拓邦著](https://nextpublishing.jp/book/11353.html)

<img width="1680" alt="Screen Shot 2022-12-08 at 9 29 33" src="https://user-images.githubusercontent.com/36561962/206326733-a02cc656-8b3c-432c-8044-98a965835d9b.png">

## 必要なもの

Dockerとdocker composeの運用知識があることを前提とします。また以下のインストールが必要です。

- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## コンテナ内のフォルダ構成

* `/binary-analysis/working`: このレポジトリの`./working`ディレクトリの内容が同期されます。課題のソースコードをここに作成します。

## 注意

* デバッガや状態可視化ツールはホストマシンのCPUアーキテクチャに依存します。Intel系のCPUを推奨します。x86_64で動作確認済み。
* 課題内でカーネルパラメータを変更する手順がありますが、コンテナの設定はホストマシンの設定と連動しているためコンテナからは許可しない設定になっています。変更する場合は影響を理解した上でホストマシンから行ってください。（例: `suod sysctl -w kernel.randomize_va_space=0`）
* バイナリ解析ツールはGDB+gdb-pedaに加えてLLDB[^2]とVoltron[^3]が使えます。
* Visual Studio Code を使っている場合は拡張機能をインストールすることでリモートコンテナ上でソースコードの管理が行えます[^4]。
* 課題のソースコードは含みません（著者や出版社にライセンスの確認が取れていないため）。

[^2]: https://lldb.llvm.org/index.html
[^3]: https://github.com/snare/voltron
[^4]: [Visual Studio Code - Develop on a remote Docker host](https://code.visualstudio.com/remote/advancedcontainers/develop-remote-host#_connect-using-docker-contexts)

## 使い方

### コンテナの起動

#### コンテナイメージのビルド&バックグラウンドでdockerコンテナを立ち上げ
```bash
docker compose up -d --build
```

#### コンテナのTTYにアタッチ

```bash
docker exec -it ubuntu bash
```

### コンテナ内のコマンド

#### LLDB&Voltronペインの起動

```bash
tmuxinator voltron
```

#### tmuxのペインをすべて閉じる

```bash
tmux kill-pane -a
```

## 免責事項

* このリポジトリの資材を利用により生じた一切の損害について作者は責任を負いません。
* このリポジトリの資材は著者および出版社とは無関係です。このリポジトリの資材に関して著者や出版社に問い合わせしないでください。問い合わせにより生じたトラブルに対して作者は責任を負いません。