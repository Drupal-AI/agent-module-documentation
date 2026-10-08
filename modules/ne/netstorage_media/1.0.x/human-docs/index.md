# NetStorage Media — manual setup guide

**NetStorage Media** (`netstorage_media`) brings assets stored in **Akamai
NetStorage** — Akamai's cloud storage / CDN origin — into Drupal as native **Media**
entities. Files that live on NetStorage can then be managed and referenced through
Drupal's Media system just like any other media, without having to duplicate them
locally.

It offers two ways to get assets in. You can **create a media entity manually** by
specifying its NetStorage path, or you can turn on **automated synchronization** so
Drupal pulls assets from a NetStorage directory on cron. Either way the result is a
standard media entity you can use in content, reference from fields, and render with
media formatters.

Because it talks to Akamai, the module needs your **NetStorage credentials**. The
API key in particular is a sensitive credential and should be stored securely — the
module integrates with the **Key** module for exactly this. The remaining
connection values can be overridden from `settings.php` so they never land in
committed configuration. NetStorage Media depends on core's **Media** module and the
`nkmani/netstorage-cms-api` PHP library, and it runs on Drupal 10 and 11. Sync is
gated by the `administer netstorage media sync` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library with
   Composer and enable it.
2. [Configuration](configuration/index.md) — enter your NetStorage credentials, set
   up a media type, and configure synchronization.

## Where it lives in the admin menu

Credentials and sync settings live at **Configuration → Media → NetStorage Media**
(`/admin/config/media/netstorage-media`). Media types that use NetStorage as their
source are created under **Structure → Media types**
(`/admin/structure/media/add`). The sync operation is controlled by the
`administer netstorage media sync` permission.
