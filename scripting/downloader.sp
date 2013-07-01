#include <sourcemod>
#include <sdktools>

#define PLUGIN_VERSION "0.1"
#define CONFIGFILE "downloader.cfg"

public Plugin:myinfo = 
{
	name = "Downloader",
	author = "angryzor",
	description = "Set some stuff to add to the download table",
	version = PLUGIN_VERSION,
	url = "http://github.com/angryzor/"
}

enum PCType
{
	None,
	Model,
	SentenceFile,
	Decal,
	Generic,
	Sound
}

new PCType:pctype = None;

public OnMapStart()
{
	decl String:path[400];

	BuildPath(Path_SM,path,sizeof(path),"configs/%s",CONFIGFILE);

	if(!FileExists(path))
	{
		LogMessage("Config file %s does not exist.",path);
		return;
	}

	new Handle:f = OpenFile(path,"r");

	while(ReadFileLine(f,path,sizeof(path)))
	{
		TrimString(path);

		if(StrContains(path,"!") == 0)
			ProcessDirective(path);
		else if(!StrEqual(path,"") && StrContains(path,"//") != 0)
		{
			AddFileToDownloadsTable(path);
			DoPrecache(path);
		}
	}

	CloseHandle(f);
}

ProcessDirective(String:path[])
{
	if(StrEqual(path,"!model"))
		pctype = Model;
	else if(StrEqual(path,"!sentencefile"))
		pctype = SentenceFile;
	else if(StrEqual(path,"!generic"))
		pctype = Generic;
	else if(StrEqual(path,"!decal"))
		pctype = Decal;
	else if(StrEqual(path,"!sound"))
		pctype = Sound;
	else if(StrEqual(path,"!none"))
		pctype = None;
	else
		LogMessage("Unknown directive '%s'",path);
}

DoPrecache(String:path[])
{
	switch(pctype)
	{
		case Model:
			PrecacheModel(path,true);
		case SentenceFile:
			PrecacheSentenceFile(path,true);
		case Generic:
			PrecacheGeneric(path,true);
		case Decal:
			PrecacheDecal(path,true);
		case Sound:
			PrecacheSound(path,true);
	}
}
