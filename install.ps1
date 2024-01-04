Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "create python venv..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "Installing torch..."

pip install torch==2.1.1+cu121 torchvision==0.16.1+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
pip install --no-deps xformers==0.0.23

Write-Output "Installing StreamDiffusion..."

pip install git+https://github.com/cumulo-autumn/StreamDiffusion.git@main#egg=streamdiffusion[tensorrt]

Write-Output "Installing deps..."
pip install --upgrade -r requirements.txt

python utils/benchmark.py --acceleration xformers

Write-Output "Install completed"
Read-Host | Out-Null ;