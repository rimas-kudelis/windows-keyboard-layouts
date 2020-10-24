# Lithuanian Keyboard Layouts for Windows
This repository contains a dump of the source folder of Windows keyboard layouts that I have made and published on https://rimas.kudelis.lt/numeric/ (or http://rq.lt/numeric for short). Currently this contains five variants of the Lithuanian Enhanced layout, which is just the stock Windows keyboard layout with a few really minor improvements (which are already available out-of-the-box on Linux systems). Each such variant resides in a separate folder, and these are as follows:
1. ltenh: master variant. It differs from the stock Windows layout by having the following characters available:
    - U+00B4 ACUTE ACCENT (´) in the AltGr layer of the key E00 (new assignment)
    - U+2013 EN DASH (–) in the AltGr layer of key E11 (new assignment)
    - U+201E DOUBLE LOW-9 QUOTATION MARK („) in the default layer of key E09 (changed assignment)
    - U+201C LEFT DOUBLE QUOTATION MARK (“) in the default layer of key E10 (changed assignment)
2. ltenhd: variant with U+002E FULL STOP as decimal separator (the master uses U+002C comma, as it should be done in Lithuania, but some poorly written applications aren't happy with that)
3. ltenhfn: a special variant which ignores NumLock state and attempts to always treat it as if it were on. This might be useful if you're using a laptop with badly (at least from my point of view) implemented numeric keypad emulation.
4. ltenhfnd: combines both workarounds above (decimal separator and NumLock state)
5. ltenh-Win9x: similar to the master variant, but made for legacy Windows 95/98/Me

## Building
The first four layouts were made with [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134) (MSKLC for short) and the source file for each is a relevant `*.klc` file. I've commited the output files produced by MCKLC as well, hence all the setup and dll files. Each layout "project" has an Installer subfolder with a `gensetup.bat` file which wraps all files produced by MSKLC in a single easy-to-distribute installer file. Final installers produced this way (`LtEnh*.exe` files) have also been commited.

For NumLock-ignorant layouts (`ltenhfn` and `ltenhfnd`), the procedure is slightly different: first you have to run "Build DLL and Setup Package" using MSKLC (although you only need the "Setup Package" part of that), then run `gensetup.bat` to patch and recompile the layout. Note that you should probably open the relevant `gensetup.bat` file in your editor of choice first and check that the path to MSKLC as specified near the top of the file is actually correct.

None of the above applies to the Windows 9x layout. For instructions regarding it, see below.

## Notes
### New Features in Windows 8 And 10
Windows 8 and 10 keyboard layouts are shipped with several new features, including:

- abbreviated layout name, shown in the task bar when more than one layout is enabled for a single language,
- the QWERTY/AZERTY/* descriptor string in language options,
- touch-optimized layouts.

However, the keyboard layout dll file format seems to have remained unchanged, and this new functionality was instead placed elsewhere. I was unable to find ways to add these features to my layouts when I looked, and it doesn't seem like anyone else would've had any success there either. Subsequently, my layouts do not support these new features.

### ARM Support
Windows 10 can be installed on ARM64 computers. It is probably possible and might make sense to compile these layouts for ARM64 as well. However, MSKLC has no support for this (see below), and I never had enough reasons to bother with this, so there is no ARM64 support yet.

### MSKLC is Abandonware
I am aware that Microsoft has abandoned Microsoft Keyboard Layout Creator. There have been no new releases since year 2007. However, last time I checked, it still worked for me, even under Windows 10, provided that the required version of .NET was installed. Since I'm not currently aware of any of its replacements (by that I mean something that would be free, have a GUI and generate a native keyboard layout which wouldn't require any specific runtimes), the files currently remain like this. In the longer term, it might be a good idea to migrate to actual C source files (or another tool, should there appear one). On the other hand, there isn't much more that I need to add to these particular layouts, so I'm not really in a hurry here.

### Windows 9x Support
Windows 95/98/Me used a different file format for keyboard layouts, so I had to use a different tool ([Janko's Keyboard Generator For Windows 95, 98 and ME](http://solair.eunet.rs/~janko/engdload.htm)) to build my layout for these versions of Windows. For this variant, the `kbdlte.kbd` file is both the binary form (the keyboard layout file) and the source form (a file that can be edited by the tool). The author of the tool has declared it to be in Public Domain since January 2007, but hasn't made its full version with AltGr support publically available, so I took liberty to commit a copy that he sent to me personally to the repository (check out the jkbd98 subfolder).

Windows 9x has fallen out of relevance decades ago, but since I had these files on my disk, I decided to go ahead and commit them here anyway.

## Acknowledgements
A bunch of binary files are commited here which I downloaded from elsewhere. These are:
- `7zr.exe`, `7zS.sfx`: 7-Zip project files used for packaging the installer files for NT-based layouts. Copyright © Igor Pavlov, licensed under GNU LGPL. Project website: https://www.7-zip.org/
- `patch.exe`: This is GNU Patch, used for patching the intermediate source files of NumLock-ignorant layouts. Licensed under GNU GPL. downloaded from http://gnuwin32.sourceforge.net/packages/patch.htm
- `wextract.exe`, `makecab.exe`, `iexpress.exe`: These are used for building the Windows 9x installer. They're probably copied from one of these Windows versions to retain installer compatibility with them and avoid missing DLL errors.
- `jkbd98.exe`: As already stated above, this tool was used for creating the Windows 9x layout file, and the author has placed it in Public Domain. Tool website: http://solair.eunet.rs/~janko/engdload.htm
