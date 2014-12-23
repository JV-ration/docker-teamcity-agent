FROM sadovnikov/container-base
MAINTAINER Viktor Sadovnikov <viktor@jv-ration.com>

ADD setup-agent.sh /setup-agent.sh
RUN adduser teamcity

EXPOSE 9090
CMD sudo -u teamcity -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"