## Part 1
install


`curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"`

`dpkg -i gitlab-runner_amd64.deb`


sudo gitlab-runner register

URL, token
description

exector: shell


`touch .gitlab-ci.yml`

        stages:
        - build
        - test

        job_build:
        stage: build
        script:
            - echo "Building the project"

        job_test:
        stage: test
        script: 
            - echo "Running tests"

git add 
git commit 
git push


## Part 5

Связать виртуалки как в Network

1 Пробросить порты 
2223 10.0.2.2223 22

2 Пробросить порты 
2222 10.0.2.2222 22

Сделать внутреннюю сеть
Виртуалки должны лежать в одной сети

        network:
          version: 2
          ethernets:
              enp0s3:
                  dhcp4: true
              enp0s8:
                  dhcp4: no
                  addresses: [192.168.100.10/16]

        network:
          version: 2
          ethernets:
              enp0s3:
                  dhcp4: true
              enp0s8:
                  dhcp4: no
                  addresses: [192.168.100.11/16]


 __Первая машина__

Пользователь gitlab-runner
`sudo su gitlab-runner`
`ssh-keygen`
`cat .ssh/id_rsa.pub`

Скопировать ключ

__Вторая машина__

Поменять пользователя на рута
`sudo su`

Скопировать туда

`vim .ssh/authorized_keys`

Связь установлена!

Можно передавать файлы
stages:
  - build
  - style
  - test
  - deploy

job_build:
  stage: build
  script:
    - cd src/cat && make && cd ../..
    - cd src/grep && make
  artifacts:
    paths:
       - src/cat/s21_cat
       - src/grep/s21_grep
    expire_in: 30 days
  after_script:
    - chmod 777 src/notify.sh
    - sh src/notify.sh

job_style:
  stage: style
  script:
    - cp materials/linters/.clang-format src
    - cd src/cat
    - clang-format -n --Werror *.c
    - cd ../grep
    - clang-format -n --Werror *.c
  after_script:
    - chmod 777 src/notify.sh
    - sh src/notify.sh

job_test:
  stage: test
  script:
    - cd src/cat && make test && cd ../..
    - cd src/grep && make test && cd ../..
  after_script:
    - chmod 777 src/notify.sh
    - sh src/notify.sh

job_deploy:
  stage: deploy
  script:
    - chmod 777 src/deploy.sh
    - sh src/deploy.sh  
  after_script:
    - chmod 777 src/notify.sh
    - sh src/notify.sh
  when: manual


after_script - 
