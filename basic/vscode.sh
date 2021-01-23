### configure vscode repository ###

# update repository index
sudo apt-get update

# install https
sudo apt-get install -y curl apt-transport-https

# download & import ms signing GPG key
curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o microsoft.asc
sudo apt-key add microsoft.asc
rm ./microsoft.asc

# add vscode repository to my system
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"  | sudo tee /etc/apt/sources.list.d/vscode.list



### install vscode ###

# update repository index
sudo apt-get update

# install vscode
sudo apt-get install -y code
