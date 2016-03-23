Functional Vilnius #8 workshop on PureScript
=============


Installing PureScript
---------------------

This is how to get up and running with PureScript.


### Locally

Install node.js v4 (LTS):

* Linux: [https://nodejs.org/en/download/package-manager](https://nodejs.org/en/download/package-manager/)
* Windows/OS X: [https://nodejs.org/en/download/](https://nodejs.org/en/download/)

Install the following packages via npm

	npm install -g bower
	npm install -g purescript@">=0.8.2"
	npm install -g pulp@">=8.1.0"
	npm install -g purescript-psa@">=0.3.5"

*Note:* On Linux/OS X you will need to use `sudo` to use the `-g` flag, unless
you setup `npm` not to use it,
[like here](https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md),
or if you're ready fiddle with your `PATH` manually.


### Using Vagrant

This is the easiest way to try out PureScript, without having to install
it on your system. This should work for any OS.

* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Install Vagrant](https://www.vagrantup.com/downloads.html)
* Clone this repo to some directory

		git clone https://github.com/functional-vilnius/fpv8-purescript purescript-workshop

  or if you don't have git, just download the repository as a
  [ZIP file](https://github.com/functional-vilnius/fpv8-purescript/archive/master.zipter.zip)
  and extract it.

* Enter the directory for this repo and run vagrant

		cd purescript-workshop
		vagrant up

* Now run

		vagrant ssh


### Verify the installation worked

Enter the cloned repository (or `cd code` if you are running in Vagrant), and then run:

	cd 1-ffi
	bower update
	pulp browserify --to out.js --censor-lib

The output should look something like

	vagrant@vagrant-ubuntu-trusty-64:~/code/1-ffi$ pulp browserify --to out.js --censor-lib
	* Browserifying project in /home/vagrant/code/1-ffi
	* Building project in /home/vagrant/code/1-ffi
			   Src   Lib   All
	Warnings   0     0     0
	Errors     0     0     0
	* Build successful.
	* Browserifying...
	* Browserified.


Finally, you can open `index.html` in your browser!


Editor integration
------------------

PureScript has many plugins for various editors, please check the full list
on [PureScript's wiki](https://github.com/purescript/purescript/wiki/Editor-and-tool-support)
to see if there's one for your favourite one.

The recommended editor for the tutorial is Atom. Note that you will need a local installation
of purescript to be able to use all of its plugins.


### Using Atom

* [Download Atom](https://atom.io/)
* Install the [language-purescript](https://atom.io/packages/language-purescript) package
* Install the [ide-purescript](https://atom.io/packages/ide-purescript) package

For docs on installing Atom packages, look here:
[https://atom.io/docs/v1.6.0/using-atom-atom-packages](https://atom.io/docs/v1.6.0/using-atom-atom-packages)
