testapp_IP = 35.204.153.218
testapp_port = 9292

# Applying startup script when creating instance via gcloud console

gcloud compute instances create test0  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata-from-file startup-script=/home/ilya0/study/scripts/startup_script.sh

# Applying startup script via url

gcloud compute instances create test0  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata startup-script-url=https://www.dropbox.com/s/os1hvjubzpypru0/startup_script.sh

# Applying firewall rules 

gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --source-tags=default --source-ranges=0.0.0.0/0 --description="open reddit app web"




