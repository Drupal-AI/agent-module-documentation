# Configuration

All of ClamAV's settings live on one form. To open it, log in as a user with the
**Administer ClamAV** permission and go to **Configuration → Media → ClamAV
Anti-Virus**, or navigate directly to `/admin/config/media/clamav`.

## Enabled

The master on/off switch. When ticked (the default), every uploaded managed file is
scanned. Untick it to turn scanning off site-wide without uninstalling the module.

## Scan mode

Choose how Drupal reaches ClamAV. Only the fields for the mode you pick matter; the
others are ignored.

- **Daemon over TCP/IP** *(the recommended default)* — Drupal connects to a running
  ClamAV daemon over the network. Fill in the **Hostname** (default `localhost`)
  and **Port** (default `3310`). This is the fastest option because the daemon stays
  loaded in memory.
- **Executable** — Drupal shells out to the `clamscan` command for each file. Set
  the **Executable path** (default `/usr/bin/clamscan`) and, if you like, extra
  **Executable parameters** such as `--max-recursion=10`. This needs no daemon but
  is slower, since ClamAV loads its virus database on every scan.
- **Daemon over Unix socket** — like the TCP/IP daemon, but Drupal talks to it
  through a local socket file instead of a network port. Set the **Unix socket**
  path (default `/var/clamav/clamd`).

## Outage behavior

This decides what happens when a file cannot be checked because ClamAV is
unreachable (the daemon is down, the socket is missing, and so on):

- **Block unchecked files** *(default, the safe choice)* — if ClamAV cannot be
  reached, the upload is rejected. Nothing gets through unscanned.
- **Allow unchecked files** — uploads are accepted even when ClamAV is down. Choose
  this only if keeping uploads working matters more than guaranteeing every file was
  scanned.

## Verbose logging

Infections are always written to Drupal's log with the detected virus name. Turn on
verbose logging if you also want clean and skipped files recorded — useful for
auditing or for proving that scanning is happening, at the cost of a noisier log.

## Scannable schemes

Scanning is scoped by storage area (stream-wrapper scheme). By default **local**
storage — public, private, and temporary files — is scanned, and **remote** storage
(for example a CDN or cloud bucket) is not. The form lists the available schemes as
checkboxes so you can flip any one from its default: untick a local scheme to skip
it, or tick a remote scheme to include it. Most sites can leave these at their
defaults.

## Save

Click **Save configuration**. Then visit **Reports → Status report**
(`/admin/reports/status`), where the module reports the connected ClamAV version —
or an "Unable to connect to ClamAV service" error if the connection details are
wrong. Correct them here until the status report shows a version.

## Retroactively scanning existing files

The settings form governs new uploads. To scan files that were already in your
library before ClamAV was enabled, use the Drush command instead:

```bash
drush clamav:scan-files              # scan all permanent managed files
drush clamav:scan-files --batch-size=5
```

It reports counts of clean, infected, and unchecked files. Note that this command
reports results and logs infections but does not delete infected files.
