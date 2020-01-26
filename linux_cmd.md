---
title: "基本コマンドとコマンドライン操作"
layout: page
---

シェルスクリプトとかあんまり頑張らずにシェルマジックで乗り切る。
データを引き上げたりdockerのvolumeでuid 0のファイルが出来ちゃった時に困らない程度の操作。

- Linuxの基本的な操作やコマンド
  - pwd
  - pushd, popd
  - top, kill, jobs
  - bgとかリダイレクトとかバッククォートとかhistoryとか
  - pushd, popd
  - find（ファイル名探すだけ。中身はag使えという事で）
  - tar
  - diff
  - xargs
  - ag
  - vim(ターミナルでの作業用の最低限だけ。基本はVSCode推奨という立場）
  - Invoke (Pythonの。makeの代わり)


### 背景

機械学習が特徴的な所として、クラウド上での作業が多い、という事が挙げられる。
その副作用として、環境はすぐに潰して作り直す事が多くなる。
また再現する論文によって必要なライブラリが異なる為、Dockerでの作業に最初から統一しておく方が良いが、
その都合でコンテナもしょっちゅう作り直す事になる。

ローカルマシンはまぁまぁ同じ環境を使い回す事も多いが、リモートのホストとコンテナはしょっちゅう作り直す物、という前提で環境を考えるのが機械学習向きだ。
結果として、なるべく設定はしない環境で使う方が望ましい。
このなるべく設定無しで作業する、ということを踏まえて、Linuxのコマンドの勉強もなるべく省エネでやっていくのが良い。

# 基本コマンドのツアー

世の中の基本コマンドのチュートリアルは機械学習をやるだけの人には不要なのが多いので、私が適当にピックアップする。

上から順番にやってください。リンク先だけで良いです（次のセクションに行ったりはしなくてOK)。

### pwd, ls, cd に関して

以下をやる。

- [UNIX Tutorial - 3. Looking around - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section3.html)


### mkdir, rmdir, cp, mv, rm, chmod（ファイルのモードとかも）

chmodはdockerで-vの下にrootのファイルが出来たりしがちなので、覚えておく。

- [UNIX Tutorial - 4. Managing files and folders - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section4.html)



### cat, more, less

- [UNIX Tutorial - 5. Viewing and editing files - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section5.html)
  - 最後のpicoは無視してください。あとでどうせviを最低限覚えるので

### パイプとリダイレクト

UCバークレーの奴はリダイレクト回りがmailコマンドでイマドキじゃないので以下で。
（誰かもっと広告少ない似たような内容のサイト知ってたら教えてください）

javatpointという所のRedirectionという項目を順番にやっていくのが良さそう。

- [Linux I/O Redirection - javatpoint](https://www.javatpoint.com/linux-input-output-redirection)
- [Linux Input Redirection - javatpoint](https://www.javatpoint.com/linux-input-redirection)
- [Linux Output Redirection - javatpoint](https://www.javatpoint.com/linux-output-redirection)
- [Linux Error Redirection - javatpoint](https://www.javatpoint.com/linux-error-redirection)


### jobsとかpsとかfgとかbgとか、プロセスのコントロール関連

- [UNIX Tutorial - 11. Viewing processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section11.html)
- [UNIX Tutorial - 12. Controlling processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section12.html)
   - niceは使わないのでExercise 12.4まででいいです。

# 応用辺

上記で漏れてる奴を補足します。
コマンドはオプションが多いですが、まずは良く使う奴だけを覚えて使っていって、必要に応じて調べていくのがオススメです。

## コマンドライン操作

`Ctrl`を押しながら何かをする事を`C-`と書きます。例えば`C-a`はCtrlキーを押しながらaを押す、という意味です。

ここではbashのコマンドライン回りの操作を書いて行きます。
いろいろなショートカットがありますが、良く使うのはとりあえず以下です。

### カーソル移動、行編集

- C-a 行の先頭に戻る
- C-e 行の最後に移動する
- C-k 現在のカーソルよりあとを削除する

C-aやC-eに関しては、例えば

```
$ echo "Hello Wo
```

くらいをタイプした状態でC-a押したりC-e押したりしてみて下さい。


### ヒストリ関連

- C-p(または矢印の上) 一つ前のコマンドを選択（何回も押せばその都度どんどん戻っていく）
- C-n(または矢印の下) 一つ次のコマンドを選択。上記のC-pなどのあとにやらないと意味が無い
- C-r ヒストリから検索する

ヒストリ関連は、まずコマンドを実行しておかないと説明が難しいので、最初に以下のようなコマンドを実行しておくとします。

```
$ cd /etc
$ echo Hello
Hello
$ echo World
World
```

上記二つを実行したあとに、C-pを二回とか押して、C-nを一回押したりしてみてください。
これでC-pとC-nは分かると思います。

### C-rとその周辺

`C-r`はちょっと補足が居ると思います。
まず、`C-r`を押すと検索状態になるので、過去に入力したコマンドに一致しそうな文字を入れると、一致する最新のコマンドが表示されます。

C-rを押すと、まずchoと入力すると、`echo World`が一致するはずです。

```
(reverse-i-search)`cho': echo World
```

このあと、スペースを押してHまで入力するとこう変わるはずです。

```
(reverse-i-search)`echo H': echo Hello
```

このように、入力した物がマッチする中で一番新しいコマンドが表示されます。
これで実行したいコマンドにマッチしているのを確認したら、Enterで実行出来ます。
やってみてください。

`C-r`は行のどこにでもマッチするのでコマンド名じゃなくてもOKです。
例えば`C-r`したあとにHelloと入力すれば`echo Hello`にマッチするはずです。これもやってみてください。

次に選択途中からキャンセルして元に戻りたい場合は`C-g`です。`C-r`して`echo H`と入力したあとに`C-g`を入力してみてください。

選択途中の状態でそれを選ぶ場合はESCです。
なお、ESCが無いキーボードの場合は`C-[`でも同じ効果があります。
`C-r`と押して`World`と入力したあとに、ESCを押してみてください。
これは過去に実行したコマンドの一部を編集したい時に使います。

### historyコマンド

過去に実行した物はhistoryというコマンドで一覧が見れます。

```
$ history
... だーっと一杯出る ...
 1763  echo Hello
 1764  echo World
```

これはあとで一部を絞りたい時などに使ったり、これをファイルにリダイレクトしてどこかに保存しておいて、作業の記録としたりする時に使います。

tailやgrepは[テキスト処理関連（grep, sed, awkなど)](https://karino2.github.io/linux_intro_ml/text_op.html)で解説するので、この時点では何も考えずに以下を実行してみてください。

```
$ history | tail 
```

```
$ history | grep -e Wor
```

一応ヒストリに出てくる数字が分かれば、エクスクラメーションマークでこれを実行出来ますが、あんまり使いません。（数字は皆さんのhistoryコマンドの結果を入力してください）

```
$ !1764
echo World
World
```

出力の一行目は実行するコマンド、二行目が結果です。

ヒストリ回りはもっと便利な事がいろいろ出来るのですが、
機械学習ではそんなに使わないのでこの位でいいでしょう。

もっと詳しく知りたい人は以下が良く書けています。
[15 Linux Bash History Expansion Examples You Should Know](https://www.thegeekstuff.com/2011/08/bash-history-expansion/)



### 漏れているもの（メモ）
  - top
  - pushd, popd
  - バッククォートとか
  - find（ファイル名探すだけ。中身はag使えという事で）
  - xargs
  - tar
  - diff
  - vimの基本


### 環境変数とか(あとの方がいいか)

環境変数とは何か、とか、子プロセスがどうなるか、とか変数とかの話とか。バッククォートもこの辺か。
.bashrcとかの話もここでしておく。

### モードとかユーザーとか

chownとかchmodとかwo am iとかユーザーとか。
コンテナ上でルートで作業した時にvmountしているファイルのパミッションが変わる話とかをする。
xargsとか使って一気にchmodしたり。

上記の4. Managing files and foldersに一通りの話があるので補足する感じで。

### 良く使うコマンド一覧

使うコマンドと簡単な解説と例を列挙。テキスト処理関連は別にする。

### 簡単なシェルスクリプト

基本的にはPythonでやる事を推奨し、ここではコマンドを並べてファイルに入れる程度の事にとどめておく。