#!/bin/bash

# Details
echo 'Install Common ICS Tools on Linux Systems'
echo '   linux_install_ics-tools.sh brought to you by Cutaway Security, LLC.'
echo '   Author: Don C. Weber (@cutaway)'
echo 'WARNING: Automated install of third-party software and tools we do not control.'
echo 'WARNING: No warranty or guarantee these tools are secure or do not contain malicious code.'
echo 'WARNING: Check all installed software on your own before use.'
echo 'WARNING: USE AT YOUR OWN RISK.'
echo
read -n1 -s -r -p $'Press space to continue...\n' key

if [ "$key" = ' ' ]; then
    echo 'Excellent.... Continuing... Enjoy....'
else
    echo 'Exiting....'
    exit 0
fi

# Change to User's Home directory and create Tools Dir
echo 'Generating ICS Tools Directory at ~/Tools/ics-tools'
cd ~
TOOLDIR='~/Tools/ics-tools'
mkdir -p $TOOLDIR

# Update 
echo 'Updating System Packages'
sudo apt update && sudo apt dist-upgrade

# Be sure Python3 Pip and other packages are installed
echo 'Apt Install Required Programs'
PYTHON_MODULES='
    python-pip
    python3-pip
    cmake
    git
    rustc
'

apt install $PYTHON_MODULES

# Install Python Modules
## Requirements
echo 'Pip install Tool Required Python Modules'
PIP_MODULES='
    ipython
    requests
    paramiko
    beautifulsoup4
    pysnmp
    gnureadline
    python-nmap
    nmap
    scapy
    usb
    serial
    cryptography
    lxml
'

pip install $PIP_MODULES
pip3 install $PIP_MODULES

## ICS Tools
echo 'Pip install ICS Tools'
PIP_ICS_TOOLS='
    pymodbus
    bacpypes
    cpppo
    pycomm
    opcua
    opcua-client
    python-snap7
'

pip install $PIP_ICS_TOOLS

# Install Rust Modules
echo 'Rust Cargo install ICS Tools'
RUST_ICS_TOOLS='
    rodbus-client
'
cargo install $RUST_ICS_TOOLS

# Git clone ICS Tools
ICS_GIT_TOOLS ='
    https://github.com/cutaway-security/chaps.git
    https://github.com/cutaway-security/cutsec_tools.git
    https://github.com/mz-automation/libiec61850.git
    https://github.com/smartgridadsc/IEC61850ToolChain.git
    https://github.com/devkid/profinet.git 
    https://github.com/Chowdery/SCADA-Profinet_Network-Attack.git
    https://github.com/atimorin/scada-tools.git
    https://github.com/jpalanco/nmap-scada.git 
    https://github.com/digitalbond/Redpoint.git
    https://github.com/dark-lbp/isf.git 
'

for i in $ICS_GIT_TOOLS; do git clone $i; done 

# Build Compiled Tools
cd  $TOOLDIR/libiec61850/examples
make
cd  $TOOLDIR/IEC61850ToolChain
make

# Added Path Update to ~/.zshrc or ~/.bashrc
SHELL='~/.bashrc'
#SHELL='~/.zshrc'
echo '# Update Path for local software' >> $SHELL
echo 'PATH=~/.local/bin:~/.cargo/bin:$PATH' >> $SHELL

# Complete
echo 'ICS Tools Installed. Happy Hunting....'
echo '   Be sure to double check that the PATH env was updated correctly.'
echo '   Some tools may not run due to Python 2.7 and Python 3 issues. Check each tools and update as necessary.'
echo '   linux_install_ics-tools.sh brought to you by Cutaway Security, LLC.'
echo '   Author: Don C. Weber (@cutaway)'
