#!/bin/bash

sudo systemctl stop nolusd

echo -e '\n\e[42mBackup priv_validator_state.json\e[0m\n' && sleep 1
if [ -f "$HOME/.nolus/data/priv_validator_state.json" ]; then
	cp $HOME/.nolus/data/priv_validator_state.json $HOME/.nolus/priv_validator_state.json.backup
fi


snapshot_interval=1000
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" ~/.nolus/config/app.toml && sleep 1
rm -rf $HOME/.nolus/data

echo -e '\n\e[42mDownloading snapshot...\e[0m\n' && sleep 1
curl -L https://fnord.online/snap_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.nolus
mv $HOME/.nolus/priv_validator_state.json.backup $HOME/.nolus/data/priv_validator_state.json

sudo systemctl start nolusd

echo -e '\n\e[42mCheck Nolus status\e[0m\n' && sleep 1
if [[ `service nolusd status | grep active` =~ "running" ]]; then
  echo -e "Your nolus snapshot \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice nolusd status\e[0m"
else
  echo -e "Your nolus node's snapshot \e[31mwas not installed correctly\e[39m, please reinstall manually."
fi