#!/bin/sh
if [ "$1" == "adduser" ]; then
    cat - >> /home/git/.ssh/authorized_keys
else
    crontab /etc/cron.d/mycrontab
    crond -b -L /var/log/mycronlog
    tcpserver -HRDl0 0.0.0.0 22 /usr/sbin/tinysshd -v /etc/tinyssh/sshkeydir
fi

