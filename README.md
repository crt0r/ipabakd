# ipabakd - Create FreeIPA backups every N hours
*Why? That's just an assignment.*

## Usage
### Systemd Service
```bash
systemctl <ARG> ipabakd.service
```

Where `<ARG>` is one of: `start`, `stop`, `restart`, `enable`, `disable`

### **ipabakd.sh** - ipabak daemon
```bash
ipabakd.sh <ARG>
```

Acceptable `<ARG>` arguments: `--help`, `-h`, `<HOURS>`, where *\<HOURS\>* is just a number.

### **ipabak-stop.sh** - ipabak stopper script for manually launched processes
```bash
ipabak-stop.sh
```

*This script will find `ipabakd.sh` PID and kill it forcefully.*

## Installation
- Copy `ipabakd.sh` to `/usr/sbin`
- Copy `ipabakd-stop.sh` to `/usr/sbin`
- Copy `ipabakd.service` to `/etc/systemd/system`

## LICENSE
Licensed under the [MIT License](./LICENSE)

Copyright (c) 2022 Timofey Chuchkanov.