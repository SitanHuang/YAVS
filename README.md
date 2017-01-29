# YAVS
YAVS = defect versioning system for one-man army,
       yet another versioning system

This program is used to backup historical versions, diffs

## Design
1. A `version` is commited through a `publish`
   with a message, date, directory diff
   and a backup of files
2. Files can be synced with remote server(overwriting)
3. Can generate changelogs

## Usage
```shell
yavs --version
yavs init
yavs version
yavs push <version>
yavs log
yavs log <version>
yavs status

# TODOs
yavs ammend
yavs sync
yavs set 'sync' 'ftp'
yavs set 'server' <IP>
yavs set 'passwd' <password>
```

## TODO
- syncing with server via ftp
- amend previous publish

### I welcome contributions :)
