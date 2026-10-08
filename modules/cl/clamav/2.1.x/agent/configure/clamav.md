# Configure ClamAV

- **UI:** `/admin/config/media/clamav` (route `clamav.admin_display`, permission `administer clamav`, form `Drupal\clamav\Form\ClamAVConfigForm`). Menu link appears under *Configuration → Media*.
- **Config object:** `clamav.settings` (single config object; editable via UI or `drush config:set`).

## Settings keys (config/install defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `true` | Master on/off for scanning. |
| `scan_mode` | int | `0` | `0` = Daemon over TCP/IP, `1` = Executable (`clamscan`), `2` = Daemon over Unix socket. |
| `outage_action` | int | `0` | Behavior when ClamAV is unreachable: `0` = block unchecked files, `1` = allow unchecked files. |
| `verbosity` | int/bool | `0` | `1` logs clean and skipped files too (infections are always logged). |
| `overridden_schemes` | list of string | `[]` | Stream-wrapper schemes whose default scannability is inverted (see below). |
| `mode_executable.executable_path` | string | `/usr/bin/clamscan` | Path to the `clamscan` binary. |
| `mode_executable.executable_parameters` | string | `''` | Extra CLI args, e.g. `--max-recursion=10`. |
| `mode_daemon_tcpip.hostname` | string | `localhost` | ClamAV daemon host. |
| `mode_daemon_tcpip.port` | int | `3310` | ClamAV daemon port. |
| `mode_daemon_unixsocket.unixsocket` | string | `/var/clamav/clamd` | Path to clamd Unix socket. |

The scan-mode integers come from `Config` constants: `MODE_DAEMON = 0`, `MODE_EXECUTABLE = 1`,
`MODE_UNIX_SOCKET = 2`; `OUTAGE_BLOCK_UNCHECKED = 0`, `OUTAGE_ALLOW_UNCHECKED = 1`.
Note the numbering: the **default** (0) is the TCP/IP daemon, but in the UI radio list the
first option shown is "Executable".

## Scan modes (how Drupal talks to ClamAV)

- **Daemon over TCP/IP (`scan_mode: 0`)** — `Scanner\DaemonTCPIP`; opens `fsockopen(hostname, port)`, streams the file with the `zINSTREAM` protocol. Recommended.
- **Executable (`scan_mode: 1`)** — `Scanner\Executable`; shells out to `{executable_path} {executable_parameters} <file>` and reads the return code (0 clean, 1 infected, ≥2 unchecked).
- **Daemon over Unix socket (`scan_mode: 2`)** — `Scanner\DaemonUnixSocket`; same `zINSTREAM` protocol over `unix://{unixsocket}`.

## Scannable schemes

Scanning is scoped by stream-wrapper scheme. Default rule (`Scanner::isSchemeScannable()`):
**local schemes are scanned, remote schemes are not** — computed as `local XOR overridden`.
The settings form lists local and remote schemes as checkboxes; toggling one off (local) or
on (remote) adds it to `overridden_schemes`, flipping its default. Empty scheme = scannable.

## Drush config examples

```bash
# Switch to Unix-socket daemon and point at a socket
drush config:set clamav.settings scan_mode 2
drush config:set clamav.settings mode_daemon_unixsocket.unixsocket /var/run/clamav/clamd.ctl

# Fail-open: allow files through when ClamAV is down
drush config:set clamav.settings outage_action 1

# Turn scanning off entirely
drush config:set clamav.settings enabled false
```

The status report (`/admin/reports/status`) shows the connected ClamAV version, or a
"Unable to connect to ClamAV service" error, via `hook_requirements()` (runtime phase).
