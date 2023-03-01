## Nolus-rila Testnet SnapShot (01.03.23) - height - 1206000 - v0.1.43
### How to install the snapshot (Instrustions #1 - auto)

## Autoscript

1. Run the commands,  if you are working under the *root* user, otherwise add *sudo* to each line
```
apt update && \
apt install curl wget lz4 -y && \
wget -O nls.sh https://raw.githubusercontent.com/serverum/nolus_snapshot/main/nls.sh && \
chmod u+x nls.sh && sudo /bin/bash nls.sh
```
## How to install the snapshot (Instrustions #2 - manual)

1. Stop the nolus service
```
sudo systemctl stop nolusd
```
2. Backup your *priv_validator_state.json* 
```
cp $HOME/.nolus/data/priv_validator_state.json $HOME/.nolus/priv_validator_state.json.backup
```
3. Make sure you turn on snapshots in your *$HOME/.nolus/config/app.toml* , if *snapshot-interval=0* then try this
```
snapshot_interval=1000 && sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" ~/.nolus/config/app.toml
```
4. Remove *$HOME/.nolus/data*
```
rm -rf $HOME/.nolus/data
```
5 Make sure you have *curl wget lz4* installed, otherwise do install them this way
```
sudo apt update && \
sudo apt install curl wget lz4 -y
```

5. Download and set the latest snapshot
```
curl -L https://fnord.online/snap_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.nolus
mv $HOME/.nolus/priv_validator_state.json.backup $HOME/.nolus/data/priv_validator_state.json
````
6. Restart your node & check the logs
```
sudo systemctl start nolusd && sudo journalctl -u nolusd -f -o cat
```
7. That's all.
