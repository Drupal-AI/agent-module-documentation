# Configuration

All of Disk Space Alert's behaviour is set on one settings page: when to alert, how
to notify, and whether to POST to an external URL.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Disk Space Alert**, or navigate directly to
   `/admin/config/system/disk-space-alert`.

## The settings

- **Enable / disable** — a master switch to turn monitoring on or off without
  uninstalling the module.
- **Threshold (percentage)** — the disk‑usage percentage at which an alert fires.
  When *used* space rises above this figure, the next check triggers a
  notification. Keep it well below 100% so you are warned with time to act (for
  example, 85–90%).
- **Email notifications** — enable to have alerts emailed to the site
  administrators when the threshold is crossed.
- **POST URL** — optionally, a URL the module will send a POST request to when the
  threshold is crossed. This is how you forward alerts to a chat service or an
  external monitor.
- **POST message** — the message body sent with the POST request. It supports
  tokens that the module fills in with live figures, including `@diskName`,
  `@totalSpace`, `@availableSpace`, `@usedSpace`, `@threshold`, and
  `@isAboveThreshold`.
- **Avoid duplicate triggers** — when enabled, the module suppresses repeat alerts
  if the disk situation has not changed significantly since the last one, so you are
  not notified over and over on every cron run.

Click **Save configuration** when done.

## Run an immediate check

Below the settings (or at `/admin/config/system/disk-space-alert/manual-check`) you
can trigger a disk‑space check on demand rather than waiting for cron. This is handy
right after clearing logs or files, to confirm the space has actually been
recovered. The current status is also shown at `/admin/disk-space`.

## A note on the POST hook and egress

The measurement itself is entirely local — nothing about your disk leaves the
server unless you fill in a **POST URL**. If you do, the message you configure
(including the disk figures from the tokens above) is **sent out to that URL**. Only
point it at an endpoint you trust, and remember that the payload describes your
server's storage.

## Access

The settings form, the status report, and the manual‑check route are all gated by
the **Administer site configuration** permission (and the module ships its own
`permissions.yml`, so review its permissions before delegating access). Since that
permission grants access to these endpoints, review who holds it.
