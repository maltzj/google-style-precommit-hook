#!/usr/bin/env sh
mkdir -p .cache
cd .cache
if [ ! -f google-java-format-1.13.0-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v1.14.0/google-java-format-1.14.0-all-deps.jar"
    chmod 755 google-java-format-1.14.0-all-deps.jar
fi
cd ..

java \ 
--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED \
--add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED \
--add-opens jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED \
--add-opens jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED \
-jar .cache/google-java-format-1.13.0-all-deps.jar --replace $@
