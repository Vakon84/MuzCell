@prompt $
@set CLEXE=C:\C600\BIN\CL.EXE
@set MLEXE=C:\MASM611\BIN\ML.EXE
@set H2INC=C:\MASM611\BIN\H2INC.EXE
@set LINK=C:\MASM611\BIN\LINK.EXE
del softmpu.exe
@cd src
del *.obj
del *.inc
del *.map
%CLEXE% /c /W2 /BATCH /Ox /G2 /FoMPU401.obj MPU401.C
@if errorlevel 1 goto end
%CLEXE% /c /W2 /BATCH /Ox /G2 /Fc /FoMIDI.obj MIDI.C
@if errorlevel 1 goto end
%CLEXE% /c /W2 /BATCH /Ox /G2 /FoPIC.obj PIC.C
@if errorlevel 1 goto end
%H2INC% export.h
@if errorlevel 1 goto end
%MLEXE% /c /Cx /W2 /WX /nologo /FoSOFTMPU.obj SOFTMPU.ASM
@if errorlevel 1 goto end
%MLEXE% /c /Cx /W2 /WX /nologo /Fl /FoH_LDIV.obj H_LDIV.ASM
@if errorlevel 1 goto end
%LINK% /NOI /BATCH /FAR /NODEFAULTLIBRARYSEARCH mpu401.obj midi.obj pic.obj softmpu.obj h_ldiv.obj,..\softmpu.exe,,,,,
:end
@cd ..
@set CLEXE=
@set MLEXE=
@set H2INC=
@set LINK=
@prompt $p$g
