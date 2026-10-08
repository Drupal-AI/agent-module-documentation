# Disk Space Alert — manual setup guide

**Disk Space Alert** (`disk_space_alert`) keeps an eye on how much free space is
left on your server's filesystem and warns you before it runs out. You set a
usage threshold (as a percentage); when disk usage crosses it, the module raises an
alert — by email to the site administrators, by writing to the log, and optionally
by sending a POST request to a URL you specify (so you can wire it into a chat or
monitoring system).

The problem it solves is the quiet, catastrophic failure of a full disk. When a
server runs out of space, Drupal (and often its database) can stop working with
confusing errors. Disk Space Alert is a lightweight, in‑Drupal safety net that
warns you with time to act — clear logs, prune files, or add capacity — before that
happens.

Checks run automatically on **cron**, and you can also trigger an immediate check
from the admin UI. The module measures the local filesystem using PHP's own
`disk_free_space()` / `disk_total_space()` — it contacts no external service for the
measurement itself (only the optional POST notification leaves your server). It
depends on Drupal core's **System** and **User** modules and defines its own
permissions. Think of it as a complement to a real infrastructure monitor, not a
replacement for one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure cron runs.
2. [Configuration](configuration/index.md) — set the threshold, notification
   options, and the optional POST hook.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Disk Space Alert**
(`/admin/config/system/disk-space-alert`, route `disk_space_alert.settings`). A
current‑status report is at `/admin/disk-space`, and you can run an immediate check
from `/admin/config/system/disk-space-alert/manual-check`. See
[Configuration](configuration/index.md) for the details.
