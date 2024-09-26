@echo off
@rem ===========================================================
@rem Brief	nvimrc �����쐬
@rem Author	KORYUOH
@rem Create 2024/09/20
@rem Update 2024/09/20
@rem Version 1.0
@rem ===========================================================
setlocal

@rem git���g����Ȃ珉�����֑���
@where git>nul
if %ERRORLEVEL% NEQ 0 goto Error
goto Initialize

:Error
exit /b

:Initialize

@rem �v���O�C���}�l�[�W���[��dpp���̗p
cd %userprofile%
mkdir .neovim_cache\dpp\repos\
cd .neovim_cache\dpp\repos

mkdir Shougo
mkdir vim-denops

@rem dpp�ƈꏏ�ɕ⋭�v���O�C���������
cd Shougo
git clone git@github.com:Shougo/dpp.vim
git clone git@github.com:Shougo/dpp-ext-installer
git clone git@github.com:Shougo/dpp-protocol-git
git clone git@github.com:Shougo/dpp-ext-lazy
git clone git@github.com:Shougo/dpp-ext-toml
git clone git@github.com:Shougo/dpp-ext-local

@rem dpp�֌W���ˑ����Ă���denops�̃C���X�g�[��
cd ..\vim-denops
git clone git@github.com:vim-denops/denops.vim

@rem deno�̃C���X�g�[���`�F�b�N
@where deno
if %ERRORLEVEL% NEQ 0 goto CHECK_DENO
goto EOF

:CHECK_DENO
choice /c yn /m "deno���C���X�g�[�����܂����H"
if %ERRORLEVEL% EQU 1 goto DENO_INSTALL
if %ERRORLEVEL% EQU 2 goto EOF
goto CHECK_DENO

:DENO_INSTALL
powershell -Command "irm https://deno.land/install.ps1|iex"

:EOF

endlocal
