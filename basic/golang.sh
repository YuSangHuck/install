# Download the archive
# sh wget https://golang.org/dl/go1.13.15.linux-amd64.tar.gz

# Extract it into /usr/local, creating a Go tree in /usr/local/go.
sudo tar -C /usr/local -xzf ./go1.13.15.linux-amd64.tar.gz
rm ./go1.13.15.linux-amd64.tar.gz

# Add /usr/local/go/bin to the PATH environment variable.
echo '' >> ~/.zshrc
echo '# golang config' >> ~/.zshrc
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc

source ~/.zshrc

# Verify that you've installed Go by opening a command prompt and typing the following command:
go version
