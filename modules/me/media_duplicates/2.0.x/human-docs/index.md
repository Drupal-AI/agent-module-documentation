# Media Duplicates — manual setup guide

**Media Duplicates** (`media_duplicates`) is a framework for finding — and
optionally blocking — duplicate media entities. Whenever a media item is saved, the
module computes a **checksum** (a fingerprint) of that item's source and stores it
on the media entity. It can then compare those fingerprints across your whole media
library to tell you which items are byte‑for‑byte the same, and stop editors from
creating new duplicates.

Two checksum plugins ship out of the box: **File** (a SHA‑256 hash of the source
file, used for file/image/audio/video sources) and **OEmbed** (a hash of the oEmbed
source value, for remote videos and similar). A duplicates **report** at
`/admin/reports/media-duplicates` lists every fingerprint shared by more than one
media item, with links to the offending entities.

Enforcement is opt‑in. On the settings form you decide whether to actually block
saving a duplicate, whether to block only brand‑new items (leaving existing
duplicates editable), and whether to compare only within the same media type. This
lets you roll enforcement out gradually — report‑only first, then restrict new
uploads, then restrict everything.

A couple of things to keep in mind: the module only *detects and restricts*
duplicates — it does **not** merge or clean them up (pair it with the optional
Entity Usage module to find where duplicates are referenced). And on an existing
site you'll need to generate fingerprints for your old media once, either with a
Drush command or the built‑in "Rebuild checksums" batch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the checksum plugin
type and the statistics service — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the report, the
   permission, and rebuilding checksums for existing media.

## Where it lives in the admin menu

- **Settings:** **Configuration → Media → Media Duplicates**
  (`/admin/config/media/media-duplicates`).
- **Report:** **Reports → Media duplicates** (`/admin/reports/media-duplicates`).
- **Rebuild checksums:** `/admin/config/media/media-duplicates/refresh` (also
  linked from the report and settings pages).

It adds one permission, **Administer media duplicates**, and one Drush command for
rebuilding checksums.
