# Add the HashiCorp GPG key.
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the official HashiCorp Linux repository.
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update and install.
sudo apt-get update && sudo apt-get install terraform

echo '' >> ~/.zshrc
echo '# terraform config' >> ~/.zshrc
echo 'alias tf="terraform"' >> ~/.zshrc