#! /usr/bin/env bash

# abort on nonzero exitstatus
set -o errexit

# Lets check on the state of the users. I would invoke severspec myself however
# its a big thing to bring in on a small pull.
id ansibletestuser  | grep --silent "uid=2222(ansibletestuser) gid=2222(ansibletestuser) groups=2222(ansibletestuser),2(bin),100(users)"
id ansibletestuser2 | grep --silent "uid=2223(ansibletestuser2) gid=2223(ansibletestuser2) groups=2223(ansibletestuser2),2(bin),100(users)"
id ansibletestuser3 | grep --silent "uid=2224(ansibletestuser3) gid=4001(ansibletestgroup1) groups=4001(ansibletestgroup1),2(bin),100(users)"
id ansibletestuser4 | grep --silent "uid=2225(ansibletestuser4) gid=100(users) groups=100(users),2(bin)"
id ansibletestuser5 | grep --silent "uid=2226(ansibletestuser5) gid=4000(ansibletestgroup) groups=4000(ansibletestgroup),2(bin),100(users)"
grep --silent "^ansibletestgroup:"  /etc/group
grep --silent "^ansibletestgroup1:" /etc/group
ls -lgd /home/ansibletestuser  | awk '{exit $3!="ansibletestuser"}'
ls -lgd /home/otherdirectory   | awk '{exit $3!="ansibletestuser2"}'
ls -lgd /home/ansibletestuser3 | awk '{exit $3!="ansibletestgroup1"}'
ls -lgd /home/otherdirectory1  | awk '{exit $3!="users"}'
ls -lgd /home/ansibletestuser5 | awk '{exit $3!="ansibletestgroup"}'
ls -lg /home/ansibletestuser/.profile   | awk '{exit $3!="ansibletestuser"}'
ls -lg /home/otherdirectory/.profile    | awk '{exit $3!="ansibletestuser2"}'
ls -lg /home/ansibletestuser3/.profile  | awk '{exit $3!="ansibletestgroup1"}'
ls -lg /home/otherdirectory1/.profile   | awk '{exit $3!="users"}'
ls -lgd /home/ansibletestuser5/.profile | awk '{exit $3!="ansibletestgroup"}'
