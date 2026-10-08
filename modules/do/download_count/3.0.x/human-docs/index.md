# Download Count — manual setup guide

**Download Count** (`download_count`) records every download of a file held in a
**private** file field and reports the totals through admin screens, blocks, Views,
and a field formatter with an inline sparkline chart. It answers the practical
question "which of our documents are actually being downloaded?" — useful for a
document library, a publication proving its distribution numbers, a paywalled
resource, or a funder's usage‑reporting requirement.

The **private‑files constraint is the whole design**, and it is the single most
important thing to understand. Drupal serves *public* files straight from the web
server, where PHP never runs — so there is nothing to count. *Private* files are
streamed through Drupal, so the module can observe each delivery. If your download
counts stay stubbornly at zero, the first thing to check is that the field uses the
**private** file system.

For each download it stores one row: the file, the user, the entity the file was
attached to, the **IP address**, the **referrer**, and a timestamp. A separate
cache table aggregates per‑file, per‑day totals (kept current by cron and a queue
worker) so reports read fast aggregates rather than scanning the raw event log.
The reporting surface is generous for a module this size: two blocks (top
downloads and recent downloads), a field formatter with a sparkline, full Views
integration, a report at `/admin/reports/download-count` with per‑entry detail and
reset, and basic Rules integration. Note that downloads by user 1 (the
super‑admin) are not counted.

It depends on core **Field** and **File**, runs on Drupal 10.3 and 11, provides
its own permissions, and is security‑advisory covered.

> **Two caveats worth knowing up front** (both covered in
> [Configuration](configuration/index.md)). First, of the four permissions it
> declares, **only `view download counts` is actually enforced** on the reset and
> export routes — so granting that permission effectively also grants the ability
> to reset counters and export the full per‑download log. Treat it as a privileged
> permission. Second, `skip download counts` stops a role from being *counted* but
> still writes a log entry (with uid, file, and IP) for each of their downloads.

> **Privacy.** Each stored row includes user id, IP address, and referrer —
> identifiable data. Sites under GDPR should decide a retention period and cover
> this in their privacy notice; uninstalling the module drops its tables, but
> nothing prunes them while it is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — ensure your file fields are private,
   enable the field formatter, place the blocks, set permissions, and read the
   reports.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Download Count**
(`/admin/config/media/download-count`), and the download report is at
**Reports → Download count** (`/admin/reports/download-count`).
