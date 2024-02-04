BASE=ltenh

all: x86/$(BASE).dll x64/$(BASE).dll wow64/$(BASE).dll arm/$(BASE).dll arm64/$(BASE).dll

MSKLC_PATH=c:\PROGRA~2\MICROS~1.4
MSVC_PATH=$(VCTOOLSINSTALLDIR)

#INCLUDE_PATH=$(MSKLC_PATH)\inc
#LIB_PATH_X86=$(MSKLC_PATH)\lib\i386
#LIB_PATH_X64=$(MSKLC_PATH)\lib\amd64
#LIB_PATH_IA64=$(MSKLC_PATH)\lib\ia64
INCLUDE_PATH=$(MSVC_PATH)\include
LIB_PATH_X86=$(MSVC_PATH)\lib\x86
LIB_PATH_X64=$(MSVC_PATH)\lib\x64
LIB_PATH_ARM=$(MSVC_PATH)\lib\arm
LIB_PATH_ARM64=$(MSVC_PATH)\lib\arm64

BIN_X86=$(MSVC_PATH)\bin\Host$(PROCESSOR_ARCHITECTURE)\x86
BIN_X64=$(MSVC_PATH)\bin\Host$(PROCESSOR_ARCHITECTURE)\x64
BIN_ARM=$(MSVC_PATH)\bin\Host$(PROCESSOR_ARCHITECTURE)\arm
BIN_ARM64=$(MSVC_PATH)\bin\Host$(PROCESSOR_ARCHITECTURE)\arm64

CL_X86="$(BIN_X86)\cl.exe"
LINK_X86="$(BIN_X86)\link.exe" /MACHINE:X86

CL_X64="$(BIN_X64)\cl.exe"
LINK_X64="$(BIN_X64)\link.exe" /MACHINE:X64

CL_ARM="$(BIN_ARM)\cl.exe"
LINK_ARM="$(BIN_ARM)\link.exe" /MACHINE:ARM

CL_ARM64="$(BIN_ARM64)\cl.exe"
LINK_ARM64="$(BIN_ARM64)\link.exe" /MACHINE:ARM64

RC="rc.exe"

CL_FLAGS=-nologo -I"$(INCLUDE_PATH)" -DNOGDICAPMASKS -DNOWINMESSAGES -DNOWINSTYLES -DNOSYSMETRICS -DNOMENUS -DNOICONS -DNOSYSCOMMANDS -DNORASTEROPS -DNOSHOWWINDOW -DOEMRESOURCE -DNOATOM -DNOCLIPBOARD -DNOCOLOR -DNOCTLMGR -DNODRAWTEXT -DNOGDI -DNOKERNEL -DNONLS -DNOMB -DNOMEMMGR -DNOMETAFILE -DNOMINMAX -DNOMSG -DNOOPENFILE -DNOSCROLL -DNOSERVICE -DNOSOUND -DNOTEXTMETRIC -DNOWINOFFSETS -DNOWH -DNOCOMM -DNOKANJI -DNOHELP -DNOPROFILER -DNODEFERWINDOWPOS -DNOMCX -DWIN32_LEAN_AND_MEAN -DRoster -DSTD_CALL -D_WIN32_WINNT=0x0500 /DWINVER=0x0500 -D_WIN32_IE=0x0500 /MD /c /Zp8 /Gy /W3 /WX /Gz /Gm- /EHs-c- /GR- /GF -Z7 /Oxs

LINK_FLAGS=-nologo -merge:.edata=.data -merge:.rdata=.data -merge:.text=.data -merge:.bss=.data -section:.data,re -MERGE:_PAGE=PAGE -MERGE:_TEXT=.text -SECTION:INIT,d -OPT:REF -OPT:ICF -IGNORE:4039,4078 -noentry -dll -subsystem:native,5.0 -merge:.rdata=.text -STACK:0x40000,0x1000 -osversion:4.0 -version:4.0 /release -def:$(BASE).def

build/$(BASE)_x86.obj: $(BASE).c
  $(CL_X86) $(CL_FLAGS) -Fo$@ $**

build/$(BASE)_x64.obj: $(BASE).c
  $(CL_X64) $(CL_FLAGS) -Fo$@ $**

build/$(BASE)_wow64.obj: $(BASE).c
  $(CL_X86) $(CL_FLAGS) -DBUILD_WOW6432 -D_WOW6432_ -Fo$@ $**

build/$(BASE)_arm.obj: $(BASE).c
  $(CL_ARM) $(CL_FLAGS) -Fo$@ $**

build/$(BASE)_arm64.obj: $(BASE).c
  $(CL_ARM64) $(CL_FLAGS) -Fo$@ $**

build/$(BASE).res: $(BASE).rc
  $(RC) -nologo -r -i"$(INCLUDE_PATH)" -DSTD_CALL -DCONDITION_HANDLING=1 -DNT_UP=1 -DNT_INST=0 -DWIN32=100 -D_NT1X_=100 -DWINNT=1 -D_WIN32_WINNT=0x0500 /DWINVER=0x0400 -D_WIN32_IE=0x0400 -DWIN32_LEAN_AND_MEAN=1 -DDEVL=1 -DFPO=1 -DNDEBUG -l 409 -fo$@ $**

x86/$(BASE).dll: build/$(BASE)_x86.obj build/$(BASE).res $(BASE).def
  $(LINK_X86) $(LINK_FLAGS) -libpath:"$(LIB_PATH_X86)" -out:$@ build/$(BASE).res build/$(BASE)_x86.obj

x64/$(BASE).dll: build/$(BASE)_x64.obj build/$(BASE).res $(BASE).def
  $(LINK_X64) $(LINK_FLAGS) -libpath:"$(LIB_PATH_X64)" -out:$@ build/$(BASE).res build/$(BASE)_x64.obj

wow64/$(BASE).dll: build/$(BASE)_wow64.obj build/$(BASE).res $(BASE).def
  $(LINK_X86) $(LINK_FLAGS) -libpath:"$(LIB_PATH_X86)" -out:$@ build/$(BASE).res build/$(BASE)_wow64.obj

arm/$(BASE).dll: build/$(BASE)_arm.obj build/$(BASE).res $(BASE).def
  $(LINK_ARM) $(LINK_FLAGS) -libpath:"$(LIB_PATH_ARM)" -out:$@ build/$(BASE).res build/$(BASE)_arm.obj

arm64/$(BASE).dll: build/$(BASE)_arm64.obj build/$(BASE).res $(BASE).def
  $(LINK_ARM64) $(LINK_FLAGS) -libpath:"$(LIB_PATH_ARM64)" -out:$@ build/$(BASE).res build/$(BASE)_arm64.obj

.PHONY clean:
  del /s $(BASE)*.dll $(BASE)*.lib $(BASE)*.exp $(BASE)*.obj $(BASE).res