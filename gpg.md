#gpg

#Terminal A
sudo apt-get install gpg

sudo apt-get install rng-tools

gpg --gen--key

#Terminal B
sudo rngd -r /dev/urandom
