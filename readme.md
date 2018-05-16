# configuration

Salt states to configure new Xubuntu live session.

## Running the state locally
```
cd
sudo apt-get update
sudo apt-get -y install git salt-minion
git clone https://github.com/make91/configuration.git
cd configuration
echo "user: $(whoami)" > srv/pillar/all.sls
sudo salt-call --local --file-root srv/salt/ --pillar-root srv/pillar/ state.highstate --state-output terse

```
