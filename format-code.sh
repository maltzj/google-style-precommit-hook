#!/usr/bin/env sh

exit_whit_error_message() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

show_warning_message() {
  printf 'WARN: %s\n' "$1" >&2
}

show_help() {
  echo "The script to format all changed Java files, using the Google formatter."
  echo
  echo "Usage: ./format-code.sh [OPTIONS]"
  echo 
  echo "Options:"
  echo "--version string       The version of the google java style formatter being used by the script. By default, the script uses the 1.7 version, " \ 
       "to check the available versions, please, visit the google formatter repository at https://github.com/google/google-java-format"
  echo "  Example: ./format-code.sh --version 1.7   # The script will execute using the 1.7 version of the formatter"
  echo "           ./format-code.sh --version 1.10  # The script will execute using the 1.10 version of the formatter"
  echo "--jvm-flags string  The flags to be defined when executing the JVM in the script. By default no flags are defined. "
  echo "  Example: ./format-code.sh --jvm-flags \"-Xms1024M -Xmx2048M\"  # The JVM will execute with 1G of minimum heap memory and 2G at maximum"
  echo
}

# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
VERSION=1.7
JVM_FLAGS=

while :; do
  case $1 in
    -h|-\?|--help)
      show_help
      exit
      ;;
    --version)
      if [ "$2" ]; then
        VERSION=$2
        shift
      else
        exit_whit_error_message '"--version" requires a non-empty option argument.'
      fi
      ;;
    --version=?*)
       # Delete everything up to "=" and assign the remainder.
      VERSION=${1#*=}
      ;;
    --version=) # Handle the case of an empty --version=
      exit_whit_error_message '"--version" requires a non-empty option argument.'
      ;;
    --jvm-flags)
      if [ "$2" ]; then
        JVM_FLAGS=$2
        shift
      else
        show_warning_message 'It was not defined any option for the --jvm-flags'
      fi
      ;;
    --jvm-flags=?*)
       # Delete everything up to "=" and assign the remainder.
      JVM_FLAGS=${1#*=}
      ;;
    --jvm-flags=) # Handle the case of an empty --jvm-flags=
      show_warning_message 'It was not defined any option for the --jvm-flags'
      ;;
    -?*)
      show_warning_message "Unknown option (ignored): $1"
      ;;
    *)
      # Default case: No more options, so break out of the loop.
      break
  esac

  shift
done


mkdir -p .cache
cd .cache
if [ ! -f google-java-format-${VERSION}-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/google-java-format-${VERSION}/google-java-format-${VERSION}-all-deps.jar"
    chmod 755 google-java-format-${VERSION}-all-deps.jar
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
java $JVM_FLAGS -jar .cache/google-java-format-${VERSION}-all-deps.jar --replace $changed_java_files
