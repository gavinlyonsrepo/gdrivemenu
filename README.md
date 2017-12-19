
Overview
--------------------------------------------
* Name: gdrivemenu
* Title: gdrive menu , CLI wrapper for google drive client gdrive
* Description: A menu-driven command line interface wrapper 
for google drive client *gdrive*.
Provides 10 options to allow user to sync local data with google drive
and search contents and information. Written in bash.
* Author: Gavin Lyons
* URL:  [gdrivemenu](https://github.com/gavinlyonsrepo/gdrivemenu)

Table of contents
---------------------------

  * [Overview](#overview)
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files and setup](#files-and-setup)
  * [Output](#output)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [See Also](#see-also)
  * [Communication](#communication)
  * [History](#history)
  * [Copyright](#copyright)
  

Installation
-----------------------------------------------

A  Personal Package Archives (PPA) has been created on Ubuntu
package building and hosting section of launchpad site 
called gdrivemenu.

To install this on your system run commands in terminal

```sh
# Add PPA 
sudo add-apt-repository ppa:typematrix/gdrivemenu
# Update repositories 
sudo apt update
# Install the package 
sudo apt install gdrivemenu
```

Usage
-------------------------------------------
To run in terminal type

```sh
gdrivemenu
```

Files and setup
-----------------------------------------

| File Path | Description |
| ------ | ------ |
| /usr/bin/gdrivemenu | bash script |
| $HOME/.config/gdrivemenu/gdrivemenu.conf | config file, user made, not installed |

The user must  install and set up *gdrive* first.
They must then create 1-4 folders on Google drive and store the file ID
The *gdrive mkdir* command can do this.
(See see also section for links to gdrive readme and a blog to show how)
 [See Also](#see-also)
 
 
Config file: The user must create a config file.
The config file holds 4 sync paths. 
"gdrivedestX" is remote google drive directory file ID.
"gdriveSourceX" is the path to local directory source folder.
Where the X is a number from 1 to 4. 
Just copy and paste below exmaple into file and change paths for your setup.
alternatively a config file template with dummy values 
is in documentation folder
of the repository.
gdrivemenu.conf file setup example:

```sh
 gdriveSource1="$HOME/Documents"
 gdriveSource2="$HOME/Pictures"
 gdriveSource3="$HOME/Videos"
 gdriveSource4="$HOME/.config"
 gdriveDest1="foo123456789"
 gdriveDest2="foo125656789"
 gdriveDest3="foo123666689"
 gdriveDest4="foo123662222"
```


A Readme, desktop entry and icon are available in repository.


Output 
-------------------------------------
Some options produce output, like file lists for example.
Output folders are created with following time/date stamp syntax HHMM-DDMONYY-X 
in the /tmp/ folder.

Dependencies
-------------------------------------
gdrive (not to be confused with Grive!) is a  command line Google 
Drive client written in Go, available for Linux, Windows, FreeBSD and Mac OS X.
[guide](https://www.howtoforge.com/tutorial/how-to-access-google-drive-from-linux-gdrive/)

Source:
[gdrive](https://github.com/prasmussen/gdrive)

Features
----------------------
10 options available 

* gdrive options
	* List all syncable directories on google drive
	* Sync local directory to google drive (path 1 config file)
	* Sync local directory to google drive (path 2 config file )
	* Sync local directory to google drive (path 3 config file)
	* Sync local directory to google drive (path 4 config file)
	* List content of syncable directory
	* Google drive metadata, quota usage
	* List files
	* gdrive about
	* Get file info


See Also
-----------
gdrive (not to be confused with Grive!) is a simple command line Google 
Drive client written in Go, available for Linux, Windows, FreeBSD and Mac OS X.

Blog on how to setup: [guide](https://www.howtoforge.com/tutorial/how-to-access-google-drive-from-linux-gdrive/)

source:
[gdrive](https://github.com/prasmussen/gdrive)

File list options API help:

[search parameters](https://developers.google.com/drive/search-parameters)

[order parameters](https://godoc.org/google.golang.org/api/drive/v3#FilesListCall.OrderBy)

Communication
-----------
If you should find a bug or you have any other query, 
please send a report.
Pull requests, suggestions for improvements
and new features welcome.
* Contact: Upstream repo at github site below or glyons66@hotmail.com
* Upstream repository: [gdrivemenu](https://github.com/gavinlyonsrepo/gdrivemenu)

History
------------------

* See changelog.md in documentation section for version control history

 
Copyright
---------
Copyright (C) 2017 Gavin Lyons 

see LICENSE.md in documentation section 

for more details
