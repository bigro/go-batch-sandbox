# go-batch-sandbox
[![deployment](https://github.com/bigro/go-batch-sandbox/actions/workflows/deploy.yaml/badge.svg)](https://github.com/bigro/go-batch-sandbox/actions/workflows/deploy.yaml)

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

## ECRへpush
[【AWS】ECRの使い方とは？DockerイメージをECRにpushしてみる](https://engineer-ninaritai.com/aws-ecr-use/)

`aws ecr get-login-password` コマンド実行時に以下のエラーが出た場合
```
An error occurred (AccessDeniedException) when calling the GetAuthorizationToken operation: User: arn:aws:iam::XXXXXXXXX:user/XXXXX is not authorized to perform: ecr:GetAuthorizationToken on resource: * because no identity-based policy allows the ecr:GetAuthorizationToken action
```
[AWS ECRでAccessDeniedExceptionが発生したときの解決法 - Qiita](https://qiita.com/yuki_0920/items/d78f5bd3c14c4dd12774)

IAMのユーザーグループに `AmazonEC2ContainerRegistryPowerUser` のポリシーを追加して `aws configure` でIAMのアクセスキー情報を設定した。

### Github Actionsで自動化
GithubSecretsに以下の値を設定する。
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_ECR_REGION
- AWS_ECR_REPO_NAME

## TerraformでAWSサービスの構築
最初に1回だけ実行
```
cd terraform
terraform init
```
更新毎に
```
cd terraform
terraform plan
terraform apply
```
