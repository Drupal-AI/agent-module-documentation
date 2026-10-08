# Private file download statistics and export the data — manual setup guide

**Private file download statistics and export the data** (machine name
`file_download_user_track_export`) records who downloads your **private** files
and how often, shows the results on an admin dashboard, and can export the data —
including downloader email addresses and other selected user fields — to CSV.

For each tracked download it captures the node ID and title, the file ID and
filename, the downloading user's email with the latest timestamp, and a running
count of how many times that file has been downloaded. From the dashboard you can
view the detail for a file, delete a file's statistics, or export them to CSV.

A couple of practical notes up front. Downloads are only counted when files are
served through the site's **private file system**, so this module has no effect
on public files. Downloads by the superuser (user 1) are deliberately not
counted. And note that the on-disk project directory
(`private_file_download_statistics_and_export_the_data`) differs from the actual
Drupal machine name you enable and configure, which is
`file_download_user_track_export`.

This project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — tell the module which private file
   field to track and which user fields to include in exports.

## Where it lives in the admin menu

- **Settings:** `/admin/file-statistics/config` (a second config menu link is at
  `/admin/private-files-statistics/config`) — configure the private file field to
  track and the user fields to export.
- **Dashboard:** `/admin/files/statistics` — view, delete, and export per-file
  download statistics.

Exported CSV files are written into the **public** files directory.
