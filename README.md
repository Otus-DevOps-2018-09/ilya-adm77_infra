# ilya-adm77_infra
ilya-adm77 Infra repository
# connect to internal instance via bastion directly
ssh -i ~/.ssh/appuser -t ilya-adm77@35.210.243.4 -A ssh 10.132.0.3

# modify /.bashrc for instance-1 alias the launch 'source /.bashrc' command to update bash config
alias instance-1='ssh -i ~/.ssh/appuser -t ilya-adm77@35.210.243.4 -A ssh 10.132.0.3'
