# mixi-ios-swiftui-training

MIXI の 2022 新卒 iOS 研修をやるリポジトリ。MVVM + UseCase + Repository アーキテクチャで実装してみた。

- リンク
  - ブログ
    - (2022) https://mixi-developers.mixi.co.jp/22-technical-training-5fc362a9dc41#25a3
    - (2021) https://mixi-developers.mixi.co.jp/2021-ios-mixi-training-d981b62e680f
  - リポジトリ兼ハンズオン資料
    - https://github.com/mixigroup/ios-swiftui-training
  - YouTube の講義動画
    - https://youtu.be/u5SzwEAydYo

## 成果物

GitHub クライアントアプリ。自分の public なリポジトリを取得して表示することができるシンプルなアプリ。

<img src="https://user-images.githubusercontent.com/42367320/227807006-45f4ae6b-06e4-408a-a9b0-4739a04d9aff.jpeg" width="300" />

## 目次

- [x] 0. Swift 言語の基本
- [x] 1. SwiftUI の基本
  - 前準備
  - 1.1. 簡単なレイアウトを組む
  - 1.2. 画像を表示
  - 1.3. リスト表示
  - 1.4. ナビゲーション
  - 1.5. ライフサイクルと状態管理
- [x] 2. Web API との通信
  - 2.1. Swift Concurrency による非同期処理
  - 2.2. URLSession による通信
  - 2.3. エラーハンドリング
- [x] 3. 設計とテスト
  - 3.1. MVVM アーキテクチャ
  - 3.2. XCTest
  - 3.3. Xcode Previews の再活用

## 勉強メモ

### なぜ設計が必要なのか？

設計により、コードの可読性・保守性を高め、サービスを成長させていくためである。

例えば、View ファイルの中に通信処理やビジネスロジックを書いていくとする。アプリケーションのロジックや画面数が増えるほど管理される状態が煩雑になり、管理コストが増していく。この状況が続くと、既存のコードを修正する際に、どこを修正すれば良いのかがわからなくなってしまう。また、新しい機能を追加する際に、既存のコードを壊さないまま機能を実装するのが徐々に難しくなっていく。そして、サービスの成長に伴い機能の追加や修正を行うための開発コストが増大し、サービスの成長が阻害されてしまう。

こうならないためにも、設計を行い、コードに規約を課し、コードの可読性・保守性を高めていく必要がある。

### Swift UI のデータフロー

- コンセプト
  - 単方向データフロー
  - Single source of truth：View に反映されるデータは常に一意である
  - View は State を引数にしてレイアウトを計算する関数である

![SwiftUI のデータフロー](https://user-images.githubusercontent.com/8536870/115537484-cf9f7600-a2d5-11eb-8b60-0847e186f288.png)

引用元：[Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226)

### MVVM アーキテクチャ

モバイル界隈では、MVVM アーキテクチャが広く採用されている。ただし、MVVM のメリット・デメリットは様々な意見があるため、これを採用するかどうかは各チームで判断する必要がある。単に数ある設計パターンの一つであるため、モバイルだからといって必ず採用する必要はない。（そうはいってもベストプラクティスにはベストプラクティスたりうる良さがあるので、理解して使うのが良い。）

MVVM は Model-View-ViewModel の 3 つの要素の頭文字をとったもので、それぞれ以下の責務を持つ。

- Model
  - アプリケーションのドメインを表すデータの定義
  - DB、外部システム（Web API など）とのインタフェース
- View
  - UI のレイアウト
  - ユーザーのアクションを ViewModel へ Input
  - ViewModel の Output を UI へバインド
- ViewModel
  - View の Input に応じて Model を呼び出して View の State を管理
  - State を加工して View へ Output

![MVVM アーキテクチャ](https://user-images.githubusercontent.com/8536870/115537612-f2ca2580-a2d5-11eb-937a-98ea74da920f.png)

上記だけだと Model 部分が不明瞭。具体的な実装を考えるには Android アプリの推奨アーキテクチャを参考にすると良い。[Android アプリでは MVVM が推奨されている](https://developer.android.com/jetpack/guide#recommended-app-arch)。

![Android アプリ MVVM アーキテクチャ](https://user-images.githubusercontent.com/8536870/115537744-18572f00-a2d6-11eb-8d24-1e4f22d2701b.png)

Model 部分は、Repository + Model / Remote Data Source で構成されている。

### MVVM + UseCase + Repository

（あくまでアーキテクチャの選定はケースによるとしか言えないという前置きをした上で、）個人的にモバイルアプリに適したアーキテクチャ は MVVM + **UseCase** + Repository（+ Model / Remote Data Source）だと考えている。

MVVM + Repository というアーキテクチャでは、ViewModel から直接 Repository を呼び出すのに対し、MVVM + UseCase + Repository アーキテクチャでは UseCase 層を ViewModel と Repository の間に追加し、ViewModel からは UseCase を呼び出すようにしている。UseCase はその名の通り、アプリケーションのユースケースであり、アプリケーションを使って「ユーザが何をしたいのか」、つまり「ビジネスロジック」を表す。

なぜ UseCase 層を追加したこのアーキテクチャが良いかを整理する。結論としては、UseCase 層を追加することで、各層の責務が明確になり、結果としてコードの品質が上がるためである。

MVVM + Repository アーキテクチャでは、ViewModel がユーザからのインプットを受け取り、ViewModel から直接 Repository を呼び出している。アプリケーションのビジネスロジックは ViewModel または Repository 層のどちらかに寄せて記述されることになる。ViewModel はユーザからのインプットをモデルに伝え、状態を管理する責務のみを持つべきで、Repository 層もデータの操作を抽象化するという責務に留めるべきであり、このアーキテクチャでは ViewModel または Repository のコード、責務の肥大化、煩雑化が問題となる。「ビジネスロジック」と「ソースコード」の対応が取れなくなりコードの可読性、保守性が下がるなどの問題が起き、開発コストが増大する。まとめると、MVVM + Repository アーキテクチャではビジネスロジックの置き場がないことが問題であると考えれる。

この問題は UseCase 層を加えることで解決する。UseCase 層を加えると、ビジネスロジックの置き場が生まれ、上記の問題が軽減される。UseCase 層を加えたアーキテクチャでは、ViewModel は View と UseCase をつなぐ立ち位置であり、ビジネスロジックが入り込みづらくなっている。同様に、UseCase 層にビジネスロジックを寄せることができるため、Repository 層の責務もデータの操作のみに集中しやすくなる。

結論として、MVVM + UseCase + Repository というアーキテクチャにより、ビジネスロジックの置き場が生まれ、各層の責務が明確になり、結果としてコードの品質を上げることができると考えられる。

（薄い感が否めない...もうちょっと深いところまで掘れるようになると良いね。）

上記の MVVM + UseCase + Repository 今現在での自分の理解を何も見ずに書いた。以前に MVVM + UseCase + Repository の開発をしたことがあったので、そのときの理解とこの資料の勉強を元に書いてみた。色々検索していたら、以下の記事を見つけたが、これを見ると「なぜ良いのか」の言語化が自分はまだまだだし経験も足りないなあと感じた。

- [(logmi, 2021/08) 「minne」はなぜ「MVVM ＋ UseCase ＋ Repository」なのか - 3 つのアーキテクチャを選んだ 5 つの理由 - 中〜大規模アプリの minne はどうアーキテクチャを選定したか](https://logmi.jp/tech/articles/325433)
