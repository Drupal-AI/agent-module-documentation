# Filehash Report — manual setup guide

**Filehash Report** (`filehash_report`) adds one thing the
[File Hash](https://www.drupal.org/project/filehash) module leaves out: a report
that lists **duplicate files**. File Hash computes a content signature (a hash) for
every managed file so Drupal can tell whether a file has already been uploaded.
Filehash Report reads those hashes and shows you the files that share one — so you
can find and clean up duplicate uploads and reclaim storage.

It is purely informational. The report *finds* duplicates; it does not delete
files or change any access itself — cleanup is up to you. Because a file listing
can reveal what has been uploaded to the site, the report is gated behind its own
permission.

Filehash Report depends on the File Hash module and works on **Drupal 10 and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install File Hash and Filehash Report
   with Composer, then generate hashes and open the report.

There is **no settings form** for this module — the "configure" link simply opens
the duplicates report itself, described below.

## Where it lives in the admin menu

Once File Hash has generated hashes, the duplicates report lives at
**`/admin/config/media/filehash/duplicates`** (the module's configure route
`filehash.reportduplicates`). It sits alongside the File Hash pages under
**Configuration → Media → File Hash**.

## How to use it

Filehash Report only has data to show once File Hash has been switched on and has
computed hashes for your existing files:

1. Go to **`/admin/config/media/filehash`**, tick a hash algorithm such as
   **SHA‑256**, and save.
2. Go to **`/admin/config/media/filehash/generate`** and click **Generate** to
   compute hashes for files already on the site.
3. Open **`/admin/config/media/filehash/duplicates`** to see the duplicate‑file
   report.

Grant the report's permission only to trusted administrators — see
[Installation](installation/index.md).
