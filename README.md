# 1. 목적

데이터를 저장하고 있는 Elasticsearch가 클러스터링 되어있는 경우, 네트워크 단절이 발생하기 전 샤드 할당 관리와 일정시간 이후 엘라스틱서치를 자동으로 재기동시키기 위한 프로그램입니다.

# 2. 설치 위치
...


# 3. 사용 방법

### 3.1 elasticsearch_rolling_restart 설정

- 설정 파일 위치 : %ERR_HOME%/config/env.sh
- 설정 항목 (전부 필수 항목)
  1. ELASTICSEARCH_HOST : elasticsearch host 정보
  2. ELASTICSEARCH_PORT : elasticsearch port 번호
  3. ELASTICSEARCH_PATH : elasticsearch home path
  4. SLEEPING_HOUR : elasticsearch가 정지되어 있을 시간 (예, 1이면 1시간 후 재기동, 8이면 8시간 후 재기동)

```bash
#!/bin/sh

# Set Elasticsearch Info(required)
export ELASTICSEARCH_HOST=127.0.0.1
export ELASTICSEARCH_PORT=9200
export ELASTICSEARCH_PATH=/home/elasticsearch

# Set Hours(required)
# 실행 시간으로부터 얼마나 엘라스틱서치가 정지되어 있을지 설정.
export SLEEPING_HOUR=1
```

### 3.2 elasticsearch_rolling_restart 실행 방법

- 실행 파일 위치 : %ERR_HOME%/bin/start.sh

```bash
$ ./start.sh
```

- 스케줄을 걸어 실행 할 경우 (crontab)

  1. crontab 설정 방법

     [분] [시] [일] [월] [요일] [실행파일]

  2. crontabl 설정 예시

     45 22 \* \* \* : 매일 22시 24분에 실행

     0 17 \* \* 1 : 매주 월요일 17시에 실행

     36 19 11 1 \* : 1월 11일 19시 36분에 실행

     30 23 13 1 \* : 1월 13일 23시 30분에 실행

```bash
# crontab -l

30 23 13 1 * %ERR_HOME%/bin/start.sh
```

# 4. 로그 확인 방법

- 로그 파일 위치 : %ERR_HOME%/logs/\*.log
- 로그 이름 형식
  1. out_YYMMDD.log : 실행 내역 모두 기록
  2. err_YYMMDD.log : 에러 로그만 기록

### 4.1 정상적으로 실행되었을 때

- CHECK POINT

  1. 로그가 "END"로 정상 종료 되었는지 확인한다.
  2. "END"의 "CURRENT_NODE_NUM"가 "START"의 "CURRENT_NODE_NUM"과 일치하는 지 확인 한다.
  3. "END"의 "CLUSTER_STATUS"가 "green"인지 확인한다.
  4. logs 디렉토리 안에 err\_\*.log 에러 로그 파일이 생성되어있는지 확인한다.(에러 로그 파일이 없어야 정상적으로 실행 한 것)

- %ERR*HOME%/logs/out*\*.log 샘플

```
************************ START ***************************
* START_TIME :  2021-01-11T17:57:04
* ELASTICSEARCH_HOST : 127.0.0.1
* ELASTICSEARCH_PORT : 9200
* ELASTICSEARCH_PATH : /home/elasticsearch
* CURRENT_NODE_NUM : 2
* CLUSTER_STATUS : "green"
* ELASTICSEARCH_PID : 60104
* SLEEPING_HOUR : 1hr
**********************************************************

[2021-01-11T17:57:04][INFO][Elasticsearch Connection] Checking elasticsearch connection...
[2021-01-11T17:57:04][INFO][Elasticsearch Connection] Elasticsearch is on connection to 127.0.0.1 port 9200
[2021-01-11T17:57:04][INFO][Elasticsearch Status] { "name" : "node-1", "cluster_name" : "test-cluster", "cluster_uuid" : "jGfNfABEQD6xRY8gkJMq9g", "version" : { "number" : "6.8.5", "build_flavor" : "default", "build_type" : "tar", "build_hash" : "78990e9", "build_date" : "2019-11-13T20:04:24.100411Z", "build_snapshot" : false, "lucene_version" : "7.7.2", "minimum_wire_compatibility_version" : "5.6.0", "minimum_index_compatibility_version" : "5.0.0" }, "tagline" : "You Know, for Search" }
[2021-01-11T17:57:04][INFO][Elasticsearch Status] _cluster/settings : {"persistent":{"cluster":{"routing":{"allocation":{"enable":"primaries"}}}},"transient":{}}
[2021-01-11T17:57:04][INFO][Allocation Setting] Disable shard allocation..
[2021-01-11T17:57:04][INFO][Allocation Setting] Disable shard allocation success : {"acknowledged":true,"persistent":{"cluster":{"routing":{"allocation":{"enable":"primaries"}}}},"transient":{}}
[2021-01-11T17:57:04][INFO][Allocation Setting] sleeping for 30s..
[2021-01-11T17:57:14][INFO][Elasticsearch PID] Elasticsearch process ID check... PID is [60104]
[2021-01-11T17:57:14][INFO][Elasticsearch PID] Elasticsearch will be killed.
[2021-01-11T17:57:14][INFO][Elasticsearch PID] Elasticsearch process [60104] is successfully killed
[2021-01-11T17:57:14][INFO][Sleeping] Sleeping for 1hrs before restart elasticsearch...
[2021-01-11T17:57:15][INFO][Elasticsearch Restart] Starting elasticsearch...
[2021-01-11T17:57:16][INFO][Elasticsearch Restart] Waiting for 30s until elasticsearch is on process
[2021-01-11T17:57:46][INFO][Elasticsearch Connection] Checking elasticsearch connection...
[2021-01-11T17:57:46][INFO][Elasticsearch Connection] Elasticsearch is on connection to 127.0.0.1 port 9200
[2021-01-11T17:57:46][INFO][Elasticsearch Status] { "name" : "node-1", "cluster_name" : "test-cluster", "cluster_uuid" : "jGfNfABEQD6xRY8gkJMq9g", "version" : { "number" : "6.8.5", "build_flavor" : "default", "build_type" : "tar", "build_hash" : "78990e9", "build_date" : "2019-11-13T20:04:24.100411Z", "build_snapshot" : false, "lucene_version" : "7.7.2", "minimum_wire_compatibility_version" : "5.6.0", "minimum_index_compatibility_version" : "5.0.0" }, "tagline" : "You Know, for Search" }
[2021-01-11T17:57:46][INFO][Elasticsearch Status] _cluster/settings : {"persistent":{"cluster":{"routing":{"allocation":{"enable":"primaries"}}}},"transient":{}}
[2021-01-11T17:57:46][INFO][Allocation Setting] Enable shard allocation..
[2021-01-11T17:57:46][INFO][Allocation Setting] Enable shard allocation success
[2021-01-11T17:57:46][INFO][Allocation Setting] Let me sleep for 30s..
[2021-01-11T17:58:16][INFO][Allocation Setting] _cluster/settings : {"persistent":{},"transient":{}}
************************* END **************************
* END_TIME :  2021-01-11T17:58:16
* CURRENT_NODE_NUM : 2
* CLUSTER_STATUS : "green"
* ELASTICSEARCH_PID : 60280
********************************************************
```

### 4.1 실행 중 에러가 발생했을 때

- logs 디렉토리에 err-\*.log가 생성되어 있으면 실행 중 에러가 발생한 것을 의미한다.
- %ERR_HOME%/logs/err-\*.log 샘플

  ```
  [2021-01-13T17:11:41][ERROR][Elasticsearch Connection] Failed to connect to 127.0.0.1 port 9200: Connection refused
  [2021-01-13T17:11:41][ERROR][Elasticsearch Connection] curl result [], pid result []
  [2021-01-13T17:11:41][EXIT][Elasticsearch Connection] Elasticsearch has no connection.. Process stopped...
  ```

# 5. ERROR 정의

- [ERROR][config validation] "SLEEPING_HOUR" in "config/env.sh" must to be number

  - env.sh의 SLEEPING_HOUR은 반드시 숫자여야 하는데 숫자가 아닌 값이 설정되었을 때 발생하는 에러
  - 불가능 : abc, d3g, 1HR

- [ERROR][config validation] "ELASTICSEARCH_PATH" is not validated

  - env.sh에 기입된 ELASTICSEARCH_PATH가 올바르지 않을 때 발생하는 에러
  - 엘라스틱서치를 중지 후 재기동에 반드시 필요하기 때문에 정확히 확인해주어야 한다.

- [ERROR][config validation] Everything in "./config/env.sh" must be setted up

  - [env.sh](http://env.sh) 설정값이 하나라도 빠져있으면 발생하는 에러 로그
  - ELASTICSEARCH_HOST, ELASTICSEARCH_PORT, ELASTICSEARCH_PATH, SLEEPING_HOUR 모두 설정값이 있는지 확인한다.

- [ERROR][elasticsearch connection] Failed to connect to 127.0.0.1 port 9200: Connection refused

  - env.sh에 설정되어 있는 정보로 Elasticsearch에 연결이 불가 할때 발생하는 에러

- [ERROR][allocation setting] Disable allocation failed. allocation result []

  - disable allocation 명령이 실패했을 때 발생하는 에러

- [ERROR][elasticsearch pid] Expect PID is not empty but it's empty..
  - 원인 : 엘라스틱서치 프로세스를 죽이기 위해 PID를 얻는 과정에서 조회되지 않아 발생하는 에러
  - 조치 : 프로세스가 정상적으로 작동하고 있는지 확인
