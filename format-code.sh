#!/usr/bin/env sh
GJF_VERSION=1.8
mkdir -p .cache
cd .cache
if [ ! -f google-java-format-$GJF_VERSION-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/google-java-format-$GJF_VERSION/google-java-format-$GJF_VERSION-all-deps.jar"
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
java -jar .cache/google-java-format-$GJF_VERSION-all-deps.jar --replace $changed_java_files
