
- インスタンスのセットアップ周辺（ユーザーとかpermissionもここ）
  - wgetかcurl
  - du, df, mount (ボリュームの追加とか)
  - apt
  - chownとか
  - sshと.ssh/configとscpとポートフォワード(Jupyter Notebook用）
  - tmux (計算をSIGHUPを無視して走らせ続ける為専用）
- docker

クラウドのインスタンス上のDockerコンテナの中にJupyterを立ち上げて開発する事を前提に、環境のセットアップや普段の作業で必要となるadmin業務的な事を。
あくまで機械学習で必要になる奴だけで。

ちゃんと実務に耐えるようにDockerの環境は面倒でも頑張って作る。

### モードとかユーザーとか

chownとかchmodとかwo am iとかユーザーとか。
コンテナ上でルートで作業した時にvmountしているファイルのパミッションが変わる話とかをする。
xargsとか使って一気にchmodしたり。

基本コマンドの方のManaging files and foldersに一通りの話があるので補足する感じで。
