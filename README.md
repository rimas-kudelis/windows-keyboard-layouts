# Lithuanian keyboard layouts for Windows
This repository contains a dump of the source folder of Windows keyboard layouts that I have made and published on https://rimas.kudelis.lt/numeric/ (or http://rq.lt/numeric for short). Currently this contains four variants of the Lithuanian Enhanced layout, which is just the stock Windows keyboard layout with a few really minor improvements (which are already available out-of-the-box on Linux systems). Each such variant resides in a separate folder, and these are as follows:
1. ltenh: master variant. It differs from the stock Windows layout by having the following characters available:
    - U+00B4 ACUTE ACCENT (´) in the AltGr layer of the key E00 (new assignment)
    - U+2013 EN DASH (–) in the AltGr layer of key E11 (new assignment)
    - U+201E DOUBLE LOW-9 QUOTATION MARK („) in the default layer of key E09 (changed assignment)
    - U+201C LEFT DOUBLE QUOTATION MARK (“) in the default layer of key E10 (changed assignment)
2. ltenhd: variant with U+002E FULL STOP as decimal separator (the master uses U+002C comma, as it should be done in Lithuania, but some poorly written applications aren't happy with that)
3. ltenhfn: a special variant which ignores NumLock state and attempts to always treat it as if it were on. This might be useful if you're using a laptop with badly (at least from my point of view) implemented numeric keypad emulation.
4. ltenhfnd: combines both workarounds above (decimal separator and NumLock state)

## Building
The layouts were made with [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134) (MSKLC for short) and the source file for each is a relevant `*.klc` file. I've commited the output files produced by MCKLC as well, hence all the setup and dll files. Each layout "project" has an Installer subfolder with a `gensetup.bat` file which wraps all files produced by MSKLC in a single easy-to-distribute installer file. Final installers produced this way (`LtEnh*.exe` files) have also been commited.

For NumLock-ignorant layouts (`ltenhfn` and `ltenhfnd`), the procedure is slightly different: first you have to run "Build DLL and Setup Package" using MSKLC (although you only need the "Setup Package" part of that), then run `gensetup.bat` to patch and recompile the layout. Note that you should probably open the relevant `gensetup.bat` file in your editor of choice first and check that the path to MSKLC as specified near the top of the file is actually correct.

## OS support
The layouts are built for 32-bit and 64-bit x86 Windows PCs, as well as IA64 (Itanium). These are the platforms that MSKLC 1.4 supported. Read notes below for more info.

## Notes
### New features and issues in Windows 8 and above
Stock keyboard layouts in Windows 8 and above are shipped with several new features, including:

- abbreviated layout name shown in the task bar when more than one layout is enabled for a single language,
- the QWERTY/AZERTY/* descriptor string in language options,
- touch-optimized layouts.

However, the keyboard layout dll file format seems to have remained unchanged, and this new functionality was instead placed elsewhere. I was unable to find ways to add these features to my layouts when I looked, and it doesn't seem like anyone else would've had any success there either. Subsequently, my layouts do not support these new features.

On top of all that, I noticed that latest versions of Windows sometimes misbehave when it comes to custom layouts. For example, I sometimes can't enter digits (which reside in AltGr layer) in Windows login screen using my layout as Windows default, unless I switch from it and back. I haven't looked at it too much, but it probably makes sense to keep one of the stock layouts enabled as a fallback of sorts.

### ARM support
Windows 10 and above can be installed on ARM64 computers. It should be possible to compile these layouts for ARM64 as well. However, MSKLC has no support for this (see below), and I haven't compiled my layouts for ARM64 yet either.

### MSKLC is abandonware
I am aware that Microsoft has abandoned Microsoft Keyboard Layout Creator. There have been no new releases since year 2007. However, last time I checked, it still worked for me, even under Windows 10, provided that the required version of .NET was installed. Since I'm not currently aware of any of its replacements (by that I mean something that would be free, have a GUI and generate a native keyboard layout which wouldn't require any specific runtimes), the files currently remain like this. In the longer term, it might be a good idea to migrate to actual C source files (or another tool, should there appear one). On the other hand, there isn't much more that I need to add to these particular layouts, so I'm not really in a hurry here.

### Windows 9x support
Nowadays completely irrelevant Windows 95/98/Me used a different file format for keyboard layouts. I had a version of my layout built for these operating systems as well. You can find it under `v1.5` tag if interested.

## Acknowledgements
Several binary files are commited here which I downloaded from elsewhere. These are:
- `7zr.exe`, `7zS.sfx`: 7-Zip project files used for packaging the installer files for my layouts. Copyright © Igor Pavlov, licensed under GNU LGPL. Project website: https://www.7-zip.org/
- `patch.exe`: This is GNU Patch, used for patching the intermediate source files of NumLock-ignorant layouts. Licensed under GNU GPL. downloaded from http://gnuwin32.sourceforge.net/packages/patch.htm
