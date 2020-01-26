---
title: "基本コマンドとコマンドライン操作"
layout: page
---

機械学習屋はシェルスクリプトとかあんまり頑張らずに、そういう操作はJupyterのシェルコマンドでなるべく行うべき。

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
   - mdirはpオプションも使います。以下の応用編の「コマンドをつなげてみよう」を参考のこと。



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


### jobsとかpsとかtopとかfgとかbgとか、プロセスのコントロール関連

- [UNIX Tutorial - 11. Viewing processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section11.html)
- [UNIX Tutorial - 12. Controlling processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section12.html)
   - niceは使わないのでExercise 12.4まででいいです。

# 応用辺

上記で漏れてる、機械学習の実務をしてて自分（や菊田さん）が使った奴を補足します。
コマンドはオプションが多いですが、まずは良く使う奴だけをセットで覚えて使っていくのがオススメです。
必要に応じておいおい調べていきます。

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

選択中の良く使うコマンド

- `C-g` キャンセル
- `ESC` (または`C-[`) 現在のマッチしているコマンドを選択
- `C-a`または`C-e` 現在マッチしているコマンドを選択し、カーソルを移動

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

また、`ESC`で明示的に選択しなくても検索の途中に`C-e`などをやっても似たような結果になります。やってみてください。

### historyコマンド

過去に実行した物はhistoryというコマンドで一覧が見れます。

```
$ history
... だーっと一杯出る ...
 1763  echo Hello
 1764  echo World
```

これはあとで一部を絞りたい時などに使ったり、これをファイルにリダイレクトしてどこかに保存しておいて、作業の記録としたりする時に使います。

tailやgrepはあとで解説するので、この時点では何も考えずに以下を実行してみてください。

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

## コマンドをつなげてみよう

複数のコマンドをつなげて一度に実行出来るのがコマンドラインの良い所です。
一方でやりすぎるとあとから再現したい時に困るので、
機械学習のような作業の再現性が重要な分野では、一定以上はなるべくJupyter上で行って、
この辺を頑張りすぎないのも重要です。

その辺を踏まえて、必要な程度を解説します。やりすぎ注意！

### mkdirのpオプション

一般の入門ではあまり出てこないけどJupyterで良く使う物として、mkdirのpオプションがあります。
これは、例えば`hoge/ika/fuga/`というネストしたディレクトリを一気に使うのに使います。
また、既にディレクトリがあった時にエラーになりません。

作業の最初にモデルやデータのディレクトリを掘る、みたいな時に便利です。

```
$ mkdir -p hoge/ika/fuga/
```

これでhogeというディレクトリの下にikaというディレクトリが出来、その中にfugaというディレクトリが出来ます。

### pushd, popd, dirsとディレクトリスタック

pushdというのは、あとで現在のディレクトリに戻ってこれるcdです。

pushdを実行した時に、その場所を覚えておきつつcdして、用事が終わったらpopdで元に戻ってこれます。

例を見て見ましょう。

```
~$ mkdir -p hoge/ika/fuga/
~$ pushd hoge/ika
~/hoge/ika $ pwd
/homge/karino2/hoge/ika
```

（pwdの結果はユーザー名は違うはずです）。

これでhoge/ikaに移動してあります。

このあと何か作業をして、終わったらpopdというのを実行すると、最後にプッシュされたディレクトリに戻ります。

```
~/hoge/ika $ cd fuga
~/hoge/ika/fuga $ popd
~$
```

一度popdするとプッシュした情報は失われます。一回しか実行出来ません。

このコマンドを利用して、以下のようなイディオムで作業をする事が多いです。

```
pushd [目的のフォルダ] && [何か作業をいろいろ] && popd
```

たとえば以下のように使います。

```
$ pushd hoge/ika/fuga && echo "Hello World" > hello.txt && popd
```

### `&&`と`;`の違い

コマンドを複数実行する場合、セミコロンとアンパサンド二つの二つのつなげ方があります。
どちらでも良い事も多いのですが、違いとしてはエラー時の振る舞いがあります。

`&&`は途中でエラーだとそこで実行が止まり、`;`は途中がエラーでもそのまま実行されます。

上記のケースだと、例えばディレクトリ名にtypoがあって、hogeをwronghogeという存在しないディレクトリにしてしまった場合、

```
$ pushd wronghoge/ika/fuga && echo "Hello World" > hello.txt && popd
```

これでは最初のpushdが失敗した段階で実行が終わりますが、以下では

```
$ pushd wronghoge/ika/fuga ; echo "Hello World" > hello.txt ; popd
```

最初のpushdが失敗したあとも実行が続き、hello.txtが現在のディレクトリに出来ます。
どっちが良いかはケースバイケースで、だいたいはエラーが出てる時点でどっちもダメです。
トラブルシュートがしやすい方を選べばOK。

### ディレクトリスタックの補足

以下は知らなくても良いのですが、一応解説しておきます。読み飛ばしてもOK。

pushdは、実行した時にその時点のディレクトリをディレクトリスタックという場所に保存します。
スタックとは先入れ後だしのデータ構造です。イメージとしては本を床に積んだり、一番上の本を取り戻したりする時の順番になります（いつも最後に積んだ物だけが取れる）。

スタックなので、複数積む事が出来ます。
たとえば

```
~$ cd hoge/ika/fuga
~/hoge/ika/fuga $ pushd ..
~/hoge/ika $ cd ..
~/hoge $ pushd ~/
~$
```

この状態で、スタックには

1. `~/hoge/ika/fuga`
2. `~/hoge/ika`

の二つが乗っています。ディレクトリスタックの内容は`dirs`コマンドで確認出来ます。

```
~$ dirs
~ ~/hoge ~/hoge/fuga/ika
```

ここで一番左は現在のディレクトリなので無視してください（見づらいですね）。
例えば/etcに行くと/etcになります。

```
~$ cd /etc
/etc$ dirs
/etc ~/hoge ~/hoge/fuga/ika
```

この状態でpopdを実行すると、スタックの先頭の`~/hoge`に戻ってこれが取り除かれます。

```
/etc$ popd
~/hoge$
```

もう一回実行すると`~/hoge/fuga/ika`に戻ります。
せっかくなので別の場所にいったあとに実行してみましょう。

```
~/hoge$ cd /usr/bin
/usr/bin$ popd
~/hoge/fuga/ika$
```

### find

ディレクトリの中を再帰的にファイルを探す時に使うのがfindです。
良く使うのは名前が一致するファイルです。

```
find 開始するディレクトリ -name 名前のパターン
```

が基本的な使い方で、「開始するディレクトリ」より下を再帰的に探します。

例えば`/etc`の下の、拡張子が`.sh`なファイルを探すには以下。

```
$ find /etc -name "*.sh"
/etc/console-setup/cached_setup_font.sh
/etc/console-setup/cached_setup_keyboard.sh
/etc/console-setup/cached_setup_terminal.sh
...
```

（なお、幾つか開けないディレクトリのエラーも出ると思います）

このように、特定のディレクトリの下のファイルを探し出すのに使うのがfindです。
ちなみに.shの拡張子のファイルはシェルスクリプトです。

なお、「いつ以降に作られたファイル」とかいう条件でも探せますが、機械学習ではあんまり使わないので必要になったらググりましょう。

### xargsと組み合わせる

findのもう一つ良く使う使い方としては、xargsと組み合わせて特定のファイルに大して何かを実行する、というのがあります。

例えば、/etcの下の各シェルスクリプトの先頭10行を表示したいとします。
つまり、

```
$ find /etc -name "*.sh"
/etc/console-setup/cached_setup_font.sh
/etc/console-setup/cached_setup_keyboard.sh
/etc/console-setup/cached_setup_terminal.sh
...
```

となるなら、`/etc/console-setup/cached_setup_font.sh`にheadをして、
次に`/etc/console-setup/cached_setup_keyboard.sh`にheadをして、、、とやっていきたい訳ですね。

`find /etc -name "*.sh"`でファイルの一覧が表示されるのだからheadをパイプでつなげれば良いか？と`find /etc -name "*.sh" | head`とすると、

```
$ find /etc -name "*.sh" | head
/etc/console-setup/cached_setup_font.sh
/etc/console-setup/cached_setup_keyboard.sh
/etc/console-setup/cached_setup_terminal.sh
/etc/init.d/console-setup.sh
/etc/init.d/hwclock.sh
/etc/init.d/keyboard-setup.sh
/etc/profile.d/01-locale-fix.sh
/etc/profile.d/Z97-byobu.sh
/etc/profile.d/Z99-cloud-locale-test.sh
/etc/profile.d/Z99-cloudinit-warnings.sh
```

と、findの結果の先頭10行が表示されてしまいました。（エラー出力が混ざって見づらいかもしれないので`find /etc -name "*.sh" 2>/dev/null | head`とする方がいいかも）

やりたいのは、`/etc/console-setup/cached_setup_font.sh`にheadをして`/etc/console-setup/cached_setup_keyboard.sh`にheadをして、、、とそれぞれの行を「コマンドライン引数」にheadを呼びたい。

でもパイプではfindの結果を「標準入力」にheadが呼ばれてしまいます。

「標準入力」の各行をコマンドライン引数として渡してくれるコマンドをxargsといいます。
以下のように実行すると、

```
$ find /etc -name "*.sh" | xargs head
```

findの結果を一行読んでheadを呼び出し、次の行を読んでまたheadを呼び出し、、、という事を繰り返してくれます。つまり以下のような事をしてくれます。

```
$ head /etc/console-setup/cached_setup_font.sh
$ head /etc/console-setup/cached_setup_keyboard.sh
$ head /etc/console-setup/cached_setup_terminal.sh
$ head /etc/init.d/console-setup.sh
....
```

なお、最初の5個のファイルに対してtailを呼び出す、なら以下のようにすれば良い。

```
$ find /etc -name "*.sh" | head -n 5 | xargs tail
```

やってみてください。

ちなみに、grepと組み合わせるのも良く使います。
上記のシェルスクリプトの中からexportを探してみましょう。

```
$ find /etc -name "*.sh" | xargs grep export
```

grepについてはあとでやります。上記のxargsは

```
$ grep export /etc/console-setup/cached_setup_font.sh
$ grep export /etc/console-setup/cached_setup_keyboard.sh
$ grep export /etc/console-setup/cached_setup_terminal.sh
$ grep export /etc/init.d/console-setup.sh
...
```

のように最後に各行をつけて呼んだのと同じ結果になります。

ただこの辺であんまり凝った事をやりたい、と悩み始めたら、もうJupyterのPython上でやる事を検討すべき領域に踏み込んでいます。Jupyter上でglobとシェルコマンドを組み合わせる方がきっと良い選択でしょう。

また、ちょっとしたサイズなら何も考えずに後述のagを使って全部検索してしまう方が手軽と思います。

実用的な例はテキスト処理でsedが終わったあとに幾つか説明します（たぶん）。

## その他の雑多なコマンド

以上に含まれない、単純だがとりあえず知っておいた方がいいコマンドを並べておきます。

### head, tail

ファイルの先頭10行を表示するのがheadで、最後の10行を表示するのがtailです。

```
# ヒストリの先頭10行を表示
$ history | head -n 3
```

また、この10行というのはnオプションで変えられます。

```
# ヒストリの先頭3行を表示
$ history | head -n 3
```

```
# ヒストリの最後5行を表示
$ history | tail -n 5
```

また、機械学習で良く使うtailの使い方に、-Fオプションというのがあります。
これはファイルを開きっぱなしにして、変更があったら最後の数行を表示する、という物です。
長い初期化が走る学習などで、ログファイルをtail -Fで開いたまま待つ、というのが良くやられます。

Fオプションの具体例はtmuxを説明したあとに解説します。

### tar

ディレクトリを圧縮して一つのファイルにするのに使います。本当は圧縮じゃなくてアーカイブだとかうるさい事言う人は適当にスルーしておきます。


圧縮
```
$ tar cvzf ファイル名.tgz ターゲットディレクトリ
```

これで「ターゲットディレクトリ」を圧縮して「ファイル名.tgz」というファイルにします。
ここで「ファイル名.tgz」の指定を忘れると「ターゲットディレクトリ」の中身が壊れるという酷い罠のあるコマンドなので慎重に使ってください。

例としては以下みたいな使い方です。
まず圧縮するディレクトリを適当に作ります。

```
$ mkdir -p data/hoge/ika/fuga
$ pushd data/hoge/ika/fuga; echo hello > data.txt; popd
```
そして以下のようなコマンドを実行します。

```
$ tar cvzf data.tgz data/
```

こうして固めたdata.tgzを後述するscpなどで送ったりします。

解凍はcの代わりにxを使います。

```
$ tar xzvf data.tgz
```

各オプションの意味とかは知らなくていいです。圧縮はcvzf、解凍はxzvf。圧縮の時にはファイル名の指定を忘れないように気を付けましょう。

### diff

二つのテキストファイルのうち、違う行だけを表示します。
ちょっと例を作るのが面倒なので使い方だけ。

```
$ diff file1 file2
```

これでfile1とfile2を一行ずつ比較して、違う行だけ表示します。

### wc

行数を数えます。単語数とかも数えますが行数しか使いません。

```
$ history | wc
   1000    3856   31200
```

一番左が行数。オプションで-lをつけると行数だけになります。

### ln

シンボリックリンクとハードリンクを作ります。
コマンドの詳細は以下を参照の事。

[【 ln 】コマンド――ファイルのハードリンクとシンボリックリンクを作る：Linux基本コマンドTips（16） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1605/30/news022.html)


シンボリックリンクは、ファイルの別名を作るのに使います。
機械学習だとそんなには使いません。

最近朝会社に来るといつも同じディレクトリにcdする所から始まるなぁ、という時に、そこへのディレクトリをホームディレクトリにシンボリックリンクを貼る、というのが自分が良く使うシンボリックリンクの使い方です。

私はworkという名前にする事が多いですが好きな名前にしてください（mという名前にしている人を見た）。
例えばさきほどのtarと同じdataというディレクトリがあるとすると、

```
$ ln -s data/hoge/ika/fuga work
```

とすると、workというシンボリックリンクが出来て、この中にcd出来ます。

```
$ ls -l
drwxrwxrwx 1 karino2 karino2 512 Jan 26 19:22 data
lrwxrwxrwx 1 karino2 karino2  18 Jan 26 19:31 work -> data/hoge/ika/fuga

$ cd work
~/work$ ls
data.txt
```

エイリアスを作る人もいるのですが、インスタンスをつぶす事が多いので基本コマンド自体は揃えておかないと無意識に打ってしまってストレスフルなので、シンボリックリンクを作るくらいがいいんじゃないか、というのが自分の結論。

次にハードリンク。

ハードリンクの方が機械学習では出番が多いでしょう。
ハードリンクは上記の-sがついていないバージョンです。

```
ln ファイル名 リンク名
```

たとえば

```
$ echo 1 > 1.txt
$ ln 1.txt othername.txt
```

とすると、othername.txtと1.txtというのは、同じデータに対する二つのファイルになります。
たとえばothername.txtに値を追加すると、1.txtの方にもそれが反映されています。

```
$ echo 3 >> othername.txt
$ cat 1.txt
1
3
```

1.txtを消してもハードディスクからはデータは削除されず、othername.txtも削除して初めてハードディスクから消えます。

ハードリンクとは、同じデータに二つのファイル名をつける、という事になります。
シンボリックリンクと違ってどっちが元のファイルか、という区別はありません。
一つのデータに完全に同等の、別のパスが作られる事になります。
どちらを開いても良いし、片方を変更したらもう片方も変更されます（というより同じデータを指しているという方が言い方としては正しい）。

機械学習での使い方としては、だいたいどこかのディレクトリにpngファイルとかが何万枚もあって、これをカテゴリごとにカテゴリidのついたディレクトリに分けたい、という時に使います。
コピーと違って一瞬で終わるので大量のデータがある時に便利。

kerasのImageDataGeneratorでflow_from_directoryを使う為にデータをカテゴリのディレクトリに分ける、という場合に使います。（flow_from_directoryを知らない人はlnの使い方だけひとまず見ておけば良いでしょう。画像のカテゴリ分類する時に使います）

複数のカテゴリの分け方で実験したい事は結構あるので、ハードリンクを使うのが良い。

例はちょっと人工的な例になりますが、以下みたいな感じです。

データセットアップ。

```
$ mkdir text_data
$ cd text_data
~/text_data $ echo a > a.txt
~/text_data $ echo b > b.txt
~/text_data $ echo c > c.txt
~/text_data $ echo d > d.txt
~/text_data $ echo e > e.txt
~/text_data $ ls
a.txt  b.txt  c.txt  d.txt  e.txt
```

次に、カテゴリ1がa.txt, c.txt、カテゴリ2がb.txt、 カテゴリ3がd.txtとe.txtとすると、
以下のような操作をします。
```
~/text_data $ mkdir 1
~/text_data $ mkdir 2
~/text_data $ mkdir 3
~/text_data $ ln a.txt 1/a.txt
~/text_data $ ln c.txt 1/c.txt
~/text_data $ ln b.txt 2/b.txt
~/text_data $ ln d.txt 3/d.txt
~/text_data $ ln e.txt 3/e.txt
```

こうすると、1にa.txtとc.txtが、2にb.txtが、3にd.txtとe.txtが入ります。
これはコピーと異なりハードディスクの容量も消費しないし、コピーと違って容量によらず一瞬で終わります。
消すのも一瞬です。
画像が数十万枚とかある機械学習ではこの差はでかいのです。

大き目の同じ内容の学習データのファイルがいろんな所に散らばる場合は、cpじゃなくてlnに出来ないかな？と考えてみてください。