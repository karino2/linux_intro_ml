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

### 基本コマンドのツアー

世の中の基本コマンドのチュートリアルは機械学習をやるだけの人には不要なのが多いので、私が適当にピックアップする。

上から順番にやってください。リンク先だけで良いです（次のセクションに行ったりはしなくてOK)。

**pwd, ls, cd に関して**

以下をやる。

- [UNIX Tutorial - 3. Looking around - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section3.html)


**mkdir, rmdir, cp, mv, rm, chmod**

chmodはdockerで-vの下にrootのファイルが出来たりしがちなので、覚えておく。

- [UNIX Tutorial - 4. Managing files and folders - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section4.html)



**cat, more, less**

- [UNIX Tutorial - 5. Viewing and editing files - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section5.html)
  - 最後のpicoは無視してください。あとでどうせviを最低限覚えるので


TODO: ここにパイプの奴を挟む。このサイトはmailコマンドでイマドキじゃないのでもうちょっと普通な奴に直す。


**jobsとかpsとかfgとかbgとか、プロセスのコントロール関連**

- [UNIX Tutorial - 11. Viewing processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section11.html)
- [UNIX Tutorial - 12. Controlling processes - UC Berkeley School of Information](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/section12.html)
   - niceは使わないのでExercise 12.4まででいいです。


TODO: echoが無い。エラー回りのリダイレクトや、ヒストリ、C-aやC-eなどが欲しい。
TODO: かけてるもの

  - pushd, popd
  - バッククォートとかhistoryとか
  - find（ファイル名探すだけ。中身はag使えという事で）
  - tar
  - diff
  - xargs


### 環境変数とか(あとの方がいいか)

環境変数とは何か、とか、子プロセスがどうなるか、とか変数とかの話とか。バッククォートもこの辺か。
.bashrcとかの話もここでしておく。

### モードとかユーザーとか

chownとかchmodとかwo am iとかユーザーとか。
コンテナ上でルートで作業した時にvmountしているファイルのパミッションが変わる話とかをする。
xargsとか使って一気にchmodしたり。

### 良く使うコマンド一覧

使うコマンドと簡単な解説と例を列挙。テキスト処理関連は別にする。

### 簡単なシェルスクリプト

基本的にはPythonでやる事を推奨し、ここではコマンドを並べてファイルに入れる程度の事にとどめておく。