FROM alpine:3.10

RUN apk add --no-cache git tinyssh ucspi-tcp &&\
    tinysshd-makekey /etc/tinyssh/sshkeydir &&\
    adduser git --disabled-password --shell /usr/bin/git-shell &&\
    mkdir /home/git/.ssh &&\
    chown git:git /home/git/.ssh
    
RUN mkdir /mycronlog.git &&\
    git init --bare /mycronlog.git &&\
    mkdir /mycronlog &&\
    cd /mycronlog &&\
    git init &&\
    git config --local user.name mycron &&\
    git config --local user.email mycron &&\
    touch syslog &&\
    git add syslog &&\
    git commit -m "mycron init" &&\
    git remote add origin /mycronlog.git &&\
    git push -u origin master

VOLUME ["/home/git/.ssh"]
COPY mycrontab /etc/cron.d/
COPY entrypoint.sh /
COPY mycronjob.sh /
COPY yours.sh /
RUN chmod +x /entrypoint.sh mycronjob.sh
ENTRYPOINT ["/entrypoint.sh"]

