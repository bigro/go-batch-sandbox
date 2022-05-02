# go-batch-sandbox
ECS on Fargateでバッチを起動させStep Functionsで管理するのを試すためのリポジトリ

## フレームワーク
CLIフレームワークの[Cobra](https://cobra.dev/)を使用してCLIを作成してる。

コマンド追加方法
```
cobra-cli add XXX
```

## Dockerイメージ化
Dockerイメージ化して以下のように使用できる。
```
docker image build -t kit/sample-batch:latest .
docker run kit/sample-batch:latest hello
```
Dockerイメージはマルチステージビルドで軽量化した。  
[Go製ツールをDockerイメージ化する](https://zenn.dev/kyoh86/articles/0561dd14d9dc1e572427)
