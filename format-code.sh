#!/usr/bin/env bash

JAR_VERSION="1.7"
JAR_FILE="google-java-format-${JAR_VERSION}-all-deps.jar"
JAR_URL="https://github.com/google/google-java-format/releases/download/google-java-format-${JAR_VERSION}/${JAR_FILE}"

mkdir -p .cache

if [ ! -f "${JAR_FILE}" ]
then
    curl -sLJ "${JAR_URL}" -o "${JAR_FILE}"
    chmod 755 "${JAR_FILE}"
fi

JAVA_DIFF=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo "${JAVA_DIFF}"
java -jar .cache/"${JAR_FILE}" --replace "${JAVA_DIFF}"