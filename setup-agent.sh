#!/bin/sh -e

AGENT_DIR="${HOME}/agent"

if [ ! -d "$AGENT_DIR" ]; then
    cd ${HOME}
    echo "Setting up TeamCityagent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR

    until $(wget $TEAMCITY_SERVER/update/buildAgent.zip); do
        echo "Waiting for '$TEAMCITY_SERVER' server..."
        sleep 10
    done

    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
	
    echo "serverUrl=${TEAMCITY_SERVER}" > $AGENT_DIR/conf/buildAgent.properties
    echo "name=${HOSTNAME}" >> $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
	
else
    echo "Using agent at ${AGENT_DIR}."
fi

$AGENT_DIR/bin/agent.sh run

