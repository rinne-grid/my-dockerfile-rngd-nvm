### Docker勉強用

#### ユーザ
  * dev

#### 導入パッケージ
  * mongodb
  * sudo
  * git
  * vim
  * gcc
  * gcc-c++ 
  * kernel-devel
  * kernel-headers
  * dkms

#### GitHubから取得するプロジェクト
  * crowi


#### 使い方

```shell
$ docker pull centos
$ docker build -t rngd/nvm-node6.x .
$ docker run --privileged --name rngd/nvm-node6.x -d rngd/nvm-node6.x /sbin/init
$ docker exec -it {{CONTAINER_ID}} bash
```