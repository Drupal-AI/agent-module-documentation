# IMCE Download Tracker — manual setup guide

**IMCE Download Tracker** (`imce_download_tracker`) counts how often files are
downloaded and shows that count right inside the [IMCE](https://www.drupal.org/project/imce)
file manager. Next to each file name it displays a small blue badge in the form
"Downloads: X", and the counts refresh as you move between folders. Select one or
more files and click the **Download Statistics** button and you get a detailed
modal — download count, first download, last download, and which user last fetched
the file. It is a quiet analytics layer for editors and administrators who want to
know which files are actually being used.

There is one limitation you must understand before relying on it: **tracking only
works for files in the private file system** (`private://`). It counts downloads
by hooking into Drupal's file-download mechanism, which core only invokes for
private files — public files (`public://`) are served straight off disk by the web
server, so Drupal never sees the request and cannot count it. If download counts
matter to you, store the files you care about in the private scheme. (For public
files you would need a different approach, such as JavaScript click tracking.)

Setting it up is a matter of **permissions and the file scheme**, not a settings
form: you enable an "Access download statistics" permission on the IMCE profiles
whose users should see the badges and the statistics modal. The module also ships
a handful of Drush commands for maintenance, and it creates a database table to
hold the tracking data. Importantly, it only *records and displays* counts — it
does not change who can access a file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (IMCE is required).

There is **no dedicated settings form** for this module. You configure it through
IMCE profile permissions and the file scheme, described in "How to set it up"
below.

## Where it lives in the admin menu

Access is configured inside IMCE's own configuration at **Configuration → Media →
IMCE** (`/admin/config/media/imce`), on the profiles you edit. The badges and the
**Download Statistics** button appear in the IMCE file browser itself.

## How to set it up

1. Install and enable the module (see [Installation](installation/index.md)). IMCE
   must be installed.
2. **Store your tracked files in the private file system** (`private://`) — public
   files cannot be tracked (see above).
3. Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`), edit the
   relevant profile(s), and add the **Access download statistics** permission so
   those users can see the badges and open the statistics modal. Save.
4. Open IMCE. Download-count badges now appear next to file names and refresh as
   you navigate folders. Select files and click **Download Statistics** to see the
   detailed modal.

## Maintenance with Drush

The module provides Drush commands for managing the recorded statistics:

- `drush imce-download-tracker:recount` — recalculate statistics for all files.
- `drush imce-download-tracker:reset [fid]` — reset the download count for one
  file by its file ID (for example `drush imce-download-tracker:reset 123`).
- `drush imce-download-tracker:stats [--all] [--top=N]` — display statistics; e.g.
  `drush imce-download-tracker:stats --top=10` for the ten most-downloaded files.

> **Tracking vs access.** This module only counts and displays downloads. It does
> not grant or restrict access to any file — file access is still governed by
> Drupal and by IMCE's profile/folder permissions.
