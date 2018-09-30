# module-skeleton
[![Build Status](https://travis-ci.org/gpaddis/module-skeleton.svg?branch=master)](https://travis-ci.org/gpaddis/module-skeleton)

This repo contains a basic module skeleton for Magento 1.x and a bash script to reinitialize it with a custom namespace and module name.

* Clone this repository in a new directory: `git clone https://github.com/gpaddis/module-skeleton.git my-module`
* Cd in the directory and run the script: `cd my-module && ./setup.sh`
* Enter namespace and module name when prompted

The script will change files and directories and init a clean git repo for your module. It is compatible with linux and mac systems.

## Integration with Travis-CI
Thanks to the package [MageTestStand](https://github.com/AOEpeople/MageTestStand) by AOEpeople, all the tests in the module can be run automatically on Travis-CI. A basic .travis.yml file is already included in the repository, you can customize it to run your unit tests on specific Magento or PHP versions.