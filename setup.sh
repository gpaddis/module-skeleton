#!/bin/bash
#
# This script customizes the skeleton module files replacing all dummy values
# with the variables provided, then resets the repo history, disconnecting
# it from the skeleton project and starting a fresh git repository.
#
# Author: Gianpiero Addis
# Package: https://github.com/gpaddis/module-skeleton

case `uname -s` in
    Darwin) is_macos=yes ;;
    *) is_macos=no ;;
esac

## Functions ##################################################################
searchAndReplace() {
    source="$1"
    destination="$2"
    if [ "$is_macos" = no ]; then
        grep -Rl "$source" --exclude "$0" | xargs sed -i "s/$source/$destination/g"
    elif [ "$is_macos" = yes ]; then
        grep -Rl "$source" --exclude "$0" . | xargs sed -i '' "s/$source/$destination/g"
    fi
}

## Basic Values ###############################################################
namespace=""
while [[ $namespace = "" ]]; do
   read -p "Type the namespace name in CamelCase, then press [Enter]: " namespace
done

moduleName=""
while [[ $moduleName = "" ]]; do
   read -p "Type the module name in CamelCase, then press [Enter]: " moduleName
done

authorName=""
while [[ $authorName = "" ]]; do
   read -p "Type your first and last name, then press [Enter]: " authorName
done

authorEmail=""
while [[ $authorEmail = "" ]]; do
   read -p "Type your email address, then press [Enter]: " authorEmail
done

lowercaseNamespace=$(echo "$namespace" | tr '[:upper:]' '[:lower:]')
lowercaseModuleName=$(echo "$moduleName" | tr '[:upper:]' '[:lower:]')

uppercaseName="${namespace}_${moduleName}"
lowercaseName="${lowercaseNamespace}_${lowercaseModuleName}"

## Change all references in the files #########################################
echo "Replacing namespace, module name and author information in all files..."

searchAndReplace "Namespace_ModuleName" "$uppercaseName"
searchAndReplace "namespace_modulename" "$lowercaseName"
searchAndReplace "Namespace" "$namespace"
searchAndReplace "ModuleName" "$moduleName"
searchAndReplace "namespace" "$lowercaseNamespace"
searchAndReplace "moduleName" "$lowercaseModuleName"

searchAndReplace "authorName" "$authorName"
searchAndReplace "author@email.net" "$authorEmail"

## Rename files and directories ###############################################
echo "Renaming files and directories..."

mv app/etc/modules/Namespace_ModuleName.xml app/etc/modules/${uppercaseName}.xml

mkdir -p app/code/local/$namespace
mv app/code/local/Namespace/ModuleName app/code/local/$namespace/$moduleName
rmdir app/code/local/Namespace

mv app/locale/en_US/Namespace_ModuleName.csv app/locale/en_US/${uppercaseName}.csv

## Add the module name to README ##############################################
echo "# $lowercaseNamespace/$lowercaseModuleName" > README.md

## Delete this script #########################################################
rm $0

## Remove all references to the skeleton project ##############################
echo "Creating a new git repository..."

rm -rf .git
git init
git add .
git commit -m "Initial commit"

echo "Done! Your new module is ready."
