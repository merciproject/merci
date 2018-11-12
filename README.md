What is Merci?
-------------

Merci is a decentralized blockchain project built on Bitcoin's UTXO model secured by a proof of stake consensus model, and made for donation and service purpose. For more general information about Merci as well as links to join our community, go to https://mercibq.com

Welcome to the Merci Main Network. This is the main network where the tokens hold value and should be guarded very carefully. If you are testing the network, or developing unstable software on Merci, we highly recommend using either testnet or regtest mode. 

Note: Merci Core is considered beta software. We make no warranties or guarantees of its security or stability.

Merci Documentation and Usage Resources
---------------

These are some resources that might be helpful in understanding Merci. Note that the unofficial documents are not created by the Merci team.

Basic usage resources:

* [Block explorer](https://info.mercibq.com)

What is Merci Core?
------------------

Merci Core is our primary mainnet wallet. It implements a full node and is capable of storing, validating, and distributing all history of the Merci network. Merci Core is considered the reference implementation for the Merci network. 

Merci Core currently implements the following:

* Sending/Receiving Merci
* Staking and creating blocks for the Merci network
* Running a full node for distributing the blockchain to other users
* "Prune" mode, which minimizes disk usage
* Regtest mode, which enables developers to very quickly build their own private Merci network for Dapp testing
* Compatibility with the Bitcoin Core set of RPC commands and APIs


Building Merci Core
----------

### Build on Ubuntu

    This is a quick start script for compiling Merci on  Ubuntu


    sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:bitcoin/bitcoin
    sudo apt-get update
    sudo apt-get install libdb4.8-dev libdb4.8++-dev

    # If you want to build the Qt GUI:
    sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler qrencode

    git clone https://github.com/merciproject/merci --recursive
    cd merci

    # Note autogen will prompt to install some more dependencies if needed
    ./autogen.sh
    ./configure 
    make -j2
    
### Build on CentOS

Here is a brief description for compiling Merci on CentOS, for more details please refer to [the specific document](https://github.com/merciproject/merci/blob/master/doc/build-unix.md)

    # Compiling boost manually
    sudo yum install python-devel bzip2-devel
    git clone https://github.com/boostorg/boost.git
    cd boost
    git checkout boost-1.66.0
    git submodule update --init --recursive
    ./bootstrap.sh --prefix=/usr --libdir=/usr/lib64
    ./b2 headers
    sudo ./b2 -j4 install
    
    # Installing Dependencies for Merci
    sudo yum install epel-release
    sudo yum install libtool libdb4-cxx-devel openssl-devel libevent-devel
    
    # If you want to build the Qt GUI:
    sudo yum install qt5-qttools-devel protobuf-devel qrencode-devel
    
    # Building Merci
    git clone --recursive https://github.com/merciproject/merci.git
    cd merci
    ./autogen.sh
    ./configure
    make -j4

### Build on OSX

The commands in this guide should be executed in a Terminal application.
The built-in one is located in `/Applications/Utilities/Terminal.app`.

#### Preparation

Install the OS X command line tools:

`xcode-select --install`

When the popup appears, click `Install`.

Then install [Homebrew](https://brew.sh).

#### Dependencies

    brew install cmake automake berkeley-db4 libtool boost --c++11 --without-single --without-static miniupnpc openssl pkg-config protobuf qt5 libevent imagemagick --with-librsvg qrencode

NOTE: Building with Qt4 is still supported, however, could result in a broken UI. Building with Qt5 is recommended.

#### Build Merci Core

1. Clone the merci source code and cd into `merci`

        git clone --recursive https://github.com/merciproject/merci.git
        cd merci

2.  Build merci-core:

    Configure and build the headless merci binaries as well as the GUI (if Qt is found).

    You can disable the GUI build by passing `--without-gui` to configure.

        ./autogen.sh
        ./configure
        make

3.  It is recommended to build and run the unit tests:

        make check

### Run

Then you can either run the command-line daemon using `src/mercid` and `src/merci-cli`, or you can run the Qt GUI using `src/qt/merci-qt`

For in-depth description of Sparknet and how to use Merci for interacting with contracts, please see [sparknet-guide](doc/sparknet-guide.md).

License
-------

Merci is GPLv3 licensed.


Development Process
-------------------

The `master` branch is regularly built and tested, but is not guaranteed to be
completely stable. [Tags](https://github.com/merciproject/merci/tags) are created
regularly to indicate new official, stable release versions of Merci.

The contribution workflow is described in [CONTRIBUTING.md](CONTRIBUTING.md).

Developer IRC can be found on Freenode at #merci-dev.


Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test on short notice. Please be patient and help out by testing
other people's pull requests, and remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write [unit tests](src/test/README.md) for new code, and to
submit new unit tests for old code. Unit tests can be compiled and run
(assuming they weren't disabled in configure) with: `make check`. Further details on running
and extending unit tests can be found in [/src/test/README.md](/src/test/README.md).

There are also [regression and integration tests](/test), written
in Python, that are run automatically on the build server.
These tests can be run (if the [test dependencies](/test) are installed) with: `test/functional/test_runner.py`

### Manual Quality Assurance (QA) Testing

Changes should be tested by somebody other than the developer who wrote the
code. This is especially important for large or high-risk changes. It is useful
to add a test plan to the pull request description if testing the changes is
not straightforward.
