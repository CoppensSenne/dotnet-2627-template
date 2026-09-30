if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (use sudo)." >&2
    exit 1
fi
echo "Installing dependencies"
dnf install dotnet-sdk-9.0 git -y

echo "Cloning the repo"
if [ ! -d /home/vagrant/dotnet-2627-template ]; then
    git clone https://github.com/HOGENT-RISE/dotnet-2627-template.git /home/vagrant/dotnet-2627-template
fi


echo "Launching dotnet application on port 5001"
dotnet run --project /home/appserver/dotnet-2627-template/src/Rise.Server --urls "http://0.0.0.0:5001" &

