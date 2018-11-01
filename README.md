========================================= HOMEWORK 7 =====================================
Основное ДЗ

- Научились выносить конфигурацию в отдельные модули: app, vpc и db;
- Научились передавать переменные из одних модулей в другие;
- Освоили подключение модулей, создающих инстансы и правила брандмауэра, к главному файлу конфигурации;
- Создали две конфигурации: stage и prod;
- Подключили модуль storage-buckets из реестра модулей.

дз *

- Подключили удаленный backend в storage-bucket для хранения стейта конфигурации;
- Проверили одновременное применение конфигураций - не работает, стейт блокируется в бакете;
- Удалили локальные стейт и проверили, что Терраформ работает со стейтом в бакете;

ДЗ **

- В модуль app добавили провижионер для загрузки файла deploy.sh и провижионер для загрузки шаблона puma;
- В файл puma передается переменная, содержащая внутренний ip - adress инстанса с БД;
- Чтобы инстанс с БД принимал внешние подключения к базе, пришлось отредактировать конфиг mongod.conf,
  хотя можно и этот процесс автоматизировать через провижионеры. 


========================================= HOMEWORK 6 =====================================
Основное ДЗ
- Создали конфиг terraform для gcp
- Создали файлы с переменными и проверили, что инстанс формируется при помощи заданных переменных
- Определили input - переменную для приватного ключа
- Определили input - переменную для задания зоны при создании инстанса
- Создали файл terraform.vars.example
дз *

- Добавили ключи appuser1,appuser2,appuser3 в метаданные проекта. Проверили - всё в порядке.
- Добавили через web пользователя appuser-web. После команды terraform apply этот ключ затерся на appuser1.
Вывод: пока terraform позволяет корректно работать только с ключами, заданными в конфигурации самого
terraform.

ДЗ **

в файле lb.tf описаны шаги по созданию балансировщика. Благодаря этому заданию разобрался, какая
цепочка действий в облаке на самом деле нужна при создании балансировщика.
Начал от обратного: создал группу инстансов (нединамическую) -> потом health-check ->
backend service -> url map -> Target proxy -> Global forwarding rule

Балансировка работает корректно, однако подобная схема годится только для тестов доступа, так
как отсутствует репликация между БД виртуалок.
Также при создании нового инстанса придется править конфиги, добавлять IP новой виртуалки в 
output. Это не добавляет автоматизации.

Схему с добавлением новой виртуалки через count также протестировал. Добавл переменную и цикл.






========================================= HOMEWORK 5 =====================================


# Create ubuntu16.json packer GCP image for reddit base installation

# Create immutable.json packer GCP image for reddit full installation

# Define variables in variables.json. Put it to .gitignore

# Fast create VM instance by using gcloud console and reddit-full gcp image


================================================= HOMEWORK 4 ==================================================

testapp_IP = 35.204.153.218
testapp_port = 9292

# Applying startup script when creating instance via gcloud console

gcloud compute instances create test0  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata-from-file startup-script=/home/ilya0/study/scripts/startup_script.sh

# Applying startup script via url

gcloud compute instances create test0  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata startup-script-url=https://www.dropbox.com/s/os1hvjubzpypru0/startup_script.sh

# Applying firewall rules 

gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --source-tags=default --source-ranges=0.0.0.0/0 --description="open reddit app web"


=========================================== HOMEWORK 3===================================================

ilya-adm77_infra
ilya-adm77 Infra repository

bastion_IP = 35.210.243.4 someinternalhost_IP = 10.132.0.3

connect to internal instance via bastion directly
ssh -i ~/.ssh/appuser -t ilya-adm77@35.210.243.4 -A ssh 10.132.0.3

Modify ~/.ssh/config file for someinternalhost direct ssh connect via 'ssh someinternalhost' alias
Host bastion
Hostname 35.210.243.4 User ilya-adm77

Host someinternalhost
User ilya-adm77 ProxyCommand ssh -q bastion nc -q0 10.132.0.3 22





