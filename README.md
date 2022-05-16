This Project is a prototype on how to use nebula to create a private network to connect different  machines.  In this case there are two hosts and one lighthouse.
There are few step to go through before building this project. 

0. Preconditions:
   - make sure your local computer/ or the where the programm will be built can access the 3 Machines(Lightouse, 2 Hosts) via ssh
1. First you have to perform some modifications:
   - update the `inventory`file.
   - you can change the name of your hosts in the `installations.sh` file. 
   - update the Ip-address of your lighthouse in the `config.yaml` file.
   ```
   static_host_map:
        "10.0.0.1": ["<your-IP>:4242"]
   ```
   - In the `run_playbook.sh` file, make sure that you are linking the right ssh key to access the machines.
2. The installations are done you can now build the project. This is done in two steps.
   - run the `installations.sh` script to install all needed packages and create your network credentatials for your nodes.
   - run the `run_playbook.sh` to configure all 3 nodes (lighthouse+ 2 hosts)
   - copy the public of server-1 and paste it in the /etc/nebula/config.yml in the hostkeys section under sshd (if you want to access the nebula cli from the server-1).
      - the ssh key is stored on the server-1 at /etc/nebula/ssh_user.key.pub
     ```
        sshd:
        # Toggles the feature
          enabled: true
          # Host and port to listen on, port 22 is not allowed for your safety
          listen: 10.0.0.1:12222
          # A file containing the ssh host private key to use
          # A decent way to generate one: ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N "" < /dev/null
          host_key: /etc/nebula/ssh_host_ed25519_key
          # A file containing a list of authorized public keys
          authorized_users:
            - user: root
              # keys can be an array of strings or single string
              keys:
                - "your public key"
      ```
   -  get the nebula services up and running. by running this commands on each nodes:
      - `cd ~/nebula` and ` sudo ./nebula -config /etc/nebula/config.yaml`
 
3. Test the Network:
   - ping:
     - from host-1 ping the host-2 using `ping 10.12`  or the lighthouse using `ping 10.1`
   - dns:
     - from the host-1 run the following command: `dig @10.1 +short server-2 A`. This will return the nebula IP-address of the second host. replace "server-2" with the name of your second host(if you changes it).
   - sshd:
     - from the host-1 try to connect to the nebula CLI (on the lighthouse): `sudo ssh -i /etc/nebula/ssh_user.key -p 12222 root@10.1`
4. Stop the service in a machine runing `sudo killall nebula`
