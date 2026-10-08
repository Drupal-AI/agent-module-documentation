# Media Entity Download Count — manual setup guide

**Media Entity Download Count** (`media_entity_download_count`) records how many
times a media entity's file has been downloaded and stores the running total in a
field you designate on each media type. It builds on the
[Media Entity Download](https://www.drupal.org/project/media_entity_download)
module (which provides the actual download links), and it keeps the counter in the
same media entity interface — so you see "downloaded N times" right alongside the
media, with no separate statistics page to hunt for. It works on Drupal 8.8
through 11.

The design is deliberately simple: you add an integer or text field to a media
type, tell the module to count into that field, and from then on every download
that Drupal grants increments the count. Users you exempt (typically admins and
editors) are skipped so previews and internal testing don't inflate the totals,
and you can exclude particular file extensions globally. Each counted download is
also written to Drupal's log with the filename, the user's ID, and their IP
address, which is handy for auditing but also worth knowing about from a privacy
standpoint.

Two honest caveats. The count is incremented on the download (read) path and
re‑saves the media entity each time, so on a revisionable media type that creates
a revision per download. And the increment is a plain read‑modify‑write, not a
concurrency‑safe atomic operation, so under heavy parallel load exact counts can
drift slightly. For ordinary "how popular is this PDF" reporting that is rarely a
problem, but it is good to know before you rely on the numbers being exact.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Media
   Entity Download dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — add a count field, enable counting
   per media type, set excluded extensions, and grant the "skip" permission.

## Where it lives in the admin menu

The global settings form is at **Configuration → Media → Media Entity Download
Count Settings** (`/admin/config/media/download/count/form/settings`). Per‑media‑type
counting is switched on inside each media type's edit form under **Structure →
Media types → *(type)* → Edit** (`/admin/structure/media`), in a "Media Download
Count configuration" section.
