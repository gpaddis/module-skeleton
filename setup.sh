#!/bin/bash
# Script to reset the repo history, disconnect it from the
# skeleton project and customize the existing files.

## Basic Values ###############################################################
namespace=""
while [[ $namespace = "" ]]; do
   read -p "Type the namespace name in CamelCase, then press [Enter]: " namespace
done

moduleName=""
while [[ $moduleName = "" ]]; do
   read -p "Type the module name in CamelCase, then press [Enter]: " moduleName
done

lowercaseNamespace=$(echo "$namespace" | tr '[:upper:]' '[:lower:]')
lowercaseModuleName=$(echo "$moduleName" | tr '[:upper:]' '[:lower:]')

uppercaseName="${namespace}_${moduleName}"
lowercaseName="${lowercaseNamespace}_${lowercaseModuleName}"


## Change all references in the files #########################################
echo "Replacing namespace and module name in all files..."

sed -i "s/Namespace/$namespace/g" modman
sed -i "s/ModuleName/$moduleName/g" modman

sed -i "s/namespace/$lowercaseNamespace/g" composer.json
sed -i "s/moduleName/$lowercaseModuleName/g" composer.json

sed -i "s/Namespace_ModuleName/$uppercaseName/g" app/etc/modules/Namespace_ModuleName.xml
sed -i "s/Namespace_ModuleName/$uppercaseName/g" app/code/local/Namespace/ModuleName/Helper/Data.php
sed -i "s/Namespace_ModuleName/$uppercaseName/g" app/code/local/Namespace/ModuleName/Model/Foo.php
sed -i "s/Namespace_ModuleName/$uppercaseName/g" app/code/local/Namespace/ModuleName/etc/config.xml
sed -i "s/namespace_modulename/$lowercaseName/g" app/code/local/Namespace/ModuleName/etc/config.xml

## Rename files and directories ###############################################
echo "Moving the files to the new directory..."

mv app/etc/modules/Namespace_ModuleName.xml app/etc/modules/${namespace}_${moduleName}.xml

mkdir -p app/code/local/$namespace
mv app/code/local/Namespace/ModuleName app/code/local/$namespace/$moduleName
rmdir app/code/local/Namespace

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
