# cluster-run-script

This crtipt allows you to change ip address of your cluster in ~/.kune/config file each time you run your ec2  instances

How does it works:
in script file you need to provide ID of ec2 instaces
Thas how command will know wich ec2 instaces it should start
After starting ec2 instances it waits until they will be ready
Then it retrieves IP of master node and places it into newip.txt and ~/.kune/config
After you finish to work with your Cluster you are running clusterstop command and it will stop ec2 instances
and writes ip to oldip.txt
The last part done because we need IP that later we will be replasing with new one in cofig file 

How to set it up:
1. Copy your config settings from file on your Master ec2 /root/.kube/config
2. Put config file in ~/.kube
3. Change context of config file
    replace line:
      certificate-authority-data: ****
    with:
      insecure-skip-tls-verify: true
4. Copy IP address from line:
    server: https://*.*.*.*:6443
6. You need to change in both script files ID of your master and worker ec2 instances from AWS cloud
7. Insert IP from config file into oldip.txt
    (inside of file should be only opne ip adres and nothing more, one line of text)

To make it to work you need to copy files into ~/.script folder

Add this allias to your .bashrs file

alias clusterstart="~/.script/clusterstart.sh"
alias clusterstop="~/.script/clusterstop.sh"
