# ilya-adm77_infra
ilya-adm77 Infra repository
# connect to internal instance via bastion directly
ssh -i ~/.ssh/appuser -t ilya-adm77@35.210.243.4 -A ssh 10.132.0.3

# Modify ~/.ssh/config file for instance-1 direct ssh connect via 'ssh instance-1' command
Host bastion          
Hostname 35.210.243.4
User ilya-adm77          

Host instance-1     
User ilya-adm77
ProxyCommand ssh -q bastion  nc -q0 10.132.0.3 22
