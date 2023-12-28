# RealTimeSketch�̍X�V PowerShell �X�N���v�g

# �X�N���v�g�̂���f�B���N�g���Ɉړ�
Set-Location $PSScriptRoot

# �X�V�̊m�F
Write-Host ""
Write-Host "�� RealTimeSketch�̍X�V ��"
Write-Host ""
$selected = Read-Host "���s���܂����H [YES/Y] (settings.ini ��settings.ini.old�Ƃ��ăo�b�N�A�b�v����܂�)"
if ($selected -eq "YES" -or $selected -eq "Y") {
    # ���z���̗L�����`�F�b�N���A���݂��Ȃ��ꍇ�͍쐬
    if (-not (Test-Path -Path "venv")) {
        Write-Host "venv �t�H���_�����݂��܂���B���z�����쐬���܂�..."
        python -m venv venv
    }

    # ���z����L���ɂ���
    .\venv\Scripts\Activate

    # settings.ini ���o�b�N�A�b�v�܂��͍폜
    if (Test-Path -Path "settings.ini") {
        Write-Host "settings.ini ���o�b�N�A�b�v (settings.ini.old) ���܂�..."
        Rename-Item -Path "settings.ini" -NewName "settings.ini.old"
    } else {
        Write-Host "settings.ini �͑��݂��܂���B"
    }

    Write-Host "���|�W�g�����X�V���܂�..."
    git pull https://github.com/tori29umai0123/RealTimeScreen.git

    Write-Host "torch ���C���X�g�[�����܂�..."
    pip install torch==2.1.1+cu121 torchvision==0.16.1+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
    pip install --no-deps xformers==0.0.23

    Write-Host "StreamDiffusion ���C���X�g�[�����܂�..."
    pip install git+https://github.com/cumulo-autumn/StreamDiffusion.git@main#egg=streamdiffusion[tensorrt]

    Write-Host "�ˑ��֌W���C���X�g�[�����܂�..."
    pip install --upgrade -r requirements.txt

    Write-Host "benchmark.py �����s���܂�..."
    python benchmark.py --acceleration xformers

    Write-Host "�X�V���������܂����B���s����ɂ͉����L�[�������Ă�������..."
    $null = Read-Host
} else {
    Write-Host "�X�V���L�����Z�����܂����B"
}

