# DKAN Dataset Archiver — manual setup guide

**DKAN Dataset Archiver** (`dkan_dataset_archiver`) makes a durable archive copy
of a DKAN dataset's resource files whenever the dataset is published. Open‑data
portals link out to resource files that can later move, change or disappear; this
module keeps a preserved copy so the data stays available even if the original is
deleted or updated. Individual archives are stored under
`files/dataset-archives/`, and each archive entity records the archive date plus
the keywords and themes the dataset had at publication time.

Beyond per‑dataset archives, it can optionally build **aggregated** archives — by
theme, by keyword, or annually — producing a ZIP of the aggregated CSVs together
with a manifest that ties each file to its title, id and original modified date.
All of this generation runs through a **queue processed on cron**, so it doesn't
slow down the site during normal use. A set of API endpoints (under
`/api/1/archive/...`) lets you list individual and aggregated archives to build
front‑end pages of the archive; those endpoints respect the requesting user's
permissions.

A couple of practical notes. Archived copies are data at rest that inherit the
sensitivity of the datasets they came from — on a public open‑data portal that's
normally fine, but confirm before archiving anything non‑public. And if you use
the remote‑storage submodule, the credentials for the offload target are secrets
to keep out of plain configuration. Match the release series to your DKAN version:
this **1.x** line is for **DKAN 4**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module against DKAN 4, and optionally add the remote‑storage submodule.

There is **no dedicated settings form** for this module — archiving happens
automatically on publish and via cron. How the pieces work is described in "How it
works" below.

## How it works

- **Individual archives:** when a dataset is published, its resource files are
  copied into `files/dataset-archives/`, with an archive entity capturing the
  date, keywords and themes at that moment. The copy persists even if the source
  resource is later changed or removed.
- **Aggregated archives:** optionally, archives can be aggregated by keyword,
  theme or year into ZIP files, each accompanied by a manifest. You can run both
  keyword and theme aggregations at the same time.
- **Cron‑driven:** archive generation is queued and processed on cron, so it does
  not degrade site performance.
- **API for front‑end listing:** endpoints under `/api/1/archive/individual/...`
  and `/api/1/archive/aggregate/...` list archives (with filters like link type,
  keyword and theme) so you can build archive pages. They honour the requesting
  user's permissions — users see public or private archives according to what they
  are allowed to see.

## Remote storage

An optional submodule, **dkan_dataset_archiver_remote_storage**, lets you keep or
copy archives to remote storage (AWS is the supported target at present). See the
[Installation](installation/index.md) guide for enabling it, and keep the
storage credentials in environment variables or a secrets manager rather than in
committed configuration.
