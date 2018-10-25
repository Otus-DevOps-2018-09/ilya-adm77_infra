========================================= HOMEWORK 6 =====================================
Основное ДЗ
- Создали конфиг terraform для gcp
- Создали файлы с переменными и проверили, что инстанс формируется при помощи заданных переменных
- Определили input - переменную для приватного ключа
- Определили input - переменную для задания зоны при создании инстанса
- Создали файл terraform.vars.example
дз *

- Добавили ключ appuser1 в метаданные проекта. Проверили - всё в порядке.
- Добавили ключ appuser3 в метаданные проекта. Проверили - ключ appuser1 был заменен на appuser3
- Добавили через web пользователя appuser-web. После команды terraform apply этот ключ затерся на appuser1.
Вывод: пока terraform позволяет корректно работать только с одним ключем в метаданных проекта. Ключ должен быть задан строго
в конфиге terraform.

ДЗ **

в файле lb.tf описаны шаги по созданию балансировщика. Благодаря этому заданию разобрался, как
цепочка действий в облаке на самом деле нужна при создании балансировщика.
Начал от обратного: создал группу инстансов (нединамическую) -> потом health-check ->
backend service -> url map -> Target proxy -> Global forwarding rule

Балансировка работает корректно, однако подобная схема годится только для тестов доступа, так
как отсутствует репликация между БД виртуалок.

Схему с добавлением новой виртуалки через count также протестировал.






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





