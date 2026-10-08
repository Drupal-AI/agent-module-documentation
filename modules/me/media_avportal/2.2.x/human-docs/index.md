# Media AV Portal — manual setup guide

**Media AV Portal** (`media_avportal`) adds the **European Commission's Audiovisual Portal**
as a media source in Drupal, so you can reference official EU photos and videos from your
media library instead of downloading them and re‑uploading local copies. The AV Portal is
the Commission's audiovisual archive, and institutional EU sites are frequently required to
use it as the canonical source for official imagery rather than keeping their own copies —
this module makes that practical.

Media items are **referenced remotely, not copied**. The module talks to the portal's API to
fetch resource metadata, registers a stream wrapper so portal assets can be addressed like
files (which is why image styles and field formatters work on them), and provides the media
source plus field formatters, including styled video output. Because a remote resource's
title, description or availability can change upstream after you reference it, the module
also ships a **Drush command** to refresh stored metadata in bulk — schedule it rather than
assuming stored metadata stays correct. Note there is no local fallback copy: if the portal
is unreachable, the referenced media is unavailable.

This module comes from the **OpenEuropa** (EU institutional Drupal) ecosystem. It is well
maintained for that context and deliberately narrow — it integrates the AV Portal
specifically, not remote media in general. Because it fetches from the AV Portal, expect
outbound (egress) requests from your site to the portal's servers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its Media dependency.

The core of using this module is setting up an AV Portal **media type** and referencing
resources; that is described under "How to use it" below rather than in a separate settings
page.

## Where it lives in the admin menu

Media AV Portal extends core Media. You create a media type that uses the **AV Portal**
media source under **Structure → Media types** (`/admin/structure/media/add`), and then
reference portal resources when creating media. It also provides Drush commands for
refreshing stored metadata.

## How to use it

1. Install and enable the module — see [Installation](installation/index.md).
2. Create a **media type** whose source is **AV Portal** (under **Structure → Media
   types**), so the media library can hold portal‑referenced items.
3. To reference a resource, paste the AV Portal video page URL —
   `http://ec.europa.eu/avservices/video/player.cfm?sitelang=xx&ref=xxxxx` — into the media
   item's resource field.
4. Display the media as usual through the media type's display settings; the module's
   formatters (including styled video output) render the referenced asset.
5. Because remote metadata can drift, run the module's **Drush metadata‑refresh command**
   periodically (for example on a schedule) so stored titles, descriptions and availability
   stay current.
