SM Downloader
=============

Introduction
------------
SourceMod Downloader is a tool that allows you to quickly add some random files to the 
Source engine's downloading/precache pipeline.

Usage
-----
SM Downloader reads out a file in the location addons/sourcemod/configs/downloader.cfg .
This file contains paths (one per line) to files that must be pushed to clients.
A sample downloader.cfg is provided as an example.

It is possible to add comments to your file by prefixing lines with //.
Note that the // must be the first characters on the line.

SM Downloader also understands a few simple directives that control the precach registration.

Directives
----------
* `!none` disables precaching for all the following lines
* `!sound` selects sound precaching for the following lines
* `!decal` selects decal precaching
* `!model` selects model precaching
* `!sentencefile` selects sentence file precaching
* `!generic` selects generic precaching
