#!/bin/bash

RESULT_FILE_PATH="./result.json"
INPUT_FILE_PATH="./url.txt"

function init () {
    echo -n "" > ${RESULT_FILE_PATH}
}

function scan () {
    echo "Taget URL: $1"
    docker run public.ecr.aws/risken/osint/website-base:v0.0.1 /opt/wappalyzer/src/drivers/npm/cli.js $1 >> ${RESULT_FILE_PATH}
}

init
while read url
do
  # call scan
  if [[ ${url} == "http"* ]]
  then
    scan $url
  else 
    scan http://${url}
    scan https://${url}
  fi
done < ${INPUT_FILE_PATH}

cat ${RESULT_FILE_PATH}
