#!/usr/bin/env sh

changed_java_files="$@"

VERSION=1.9
NAME=google-java-format-$VERSION
CMD=$NAME-all-deps.jar

mkdir -p .cache
cd .cache
if [ ! -f $CMD ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/$NAME/$CMD"
    chmod 755 $CMD
fi
cd ..

java -jar .cache/$CMD --replace $changed_java_files
