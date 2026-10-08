# Acquia DAM — manual setup guide

**Acquia DAM** (`acquia_dam`) connects your Drupal site to the **Acquia DAM
(Widen)** digital-asset-management service, so the images, videos, PDFs and other
files your team already manages in the DAM become reusable Drupal media entities.
Editors browse and embed those remote assets straight from the core **Media
Library**, without re-uploading anything into Drupal. The module provides a media
source plugin (`acquia_dam_asset`) and, on install, sets up eight ready-made media
types: **Image, Video, Audio, PDF, Documents, Archive, SpinSet, and Generic**.

Assets can be used two ways, and you choose per media type: **reference them
remotely** so the DAM stays the single source of truth, or **download and sync**
copies into Drupal's file system. The module keeps embedded assets fresh (via
cron, a queue, and an "asset update check" action), warns editors when a
referenced asset has a newer version or has expired, and can map DAM metadata
(descriptions, keywords, and so on) onto your media fields. It renders assets
through embed-code, thumbnail, image-style and responsive-image formatters.

Because the module talks to an external SaaS, most real asset operations need a
valid DAM connection. Authentication is **OAuth**: you configure a site-level
connection to your DAM **domain**, and then each editor authorizes their own DAM
account before they can browse assets. The DAM client secret is best stored in a
**Key** entity rather than in plain configuration. It depends on core's File,
Image, Media, Media Library and Views modules plus the contributed **Token** and
**Views Remote Data** modules. Two optional submodules extend it:
**acquia_dam_integration_links** (tracks where assets are used, even deep inside
paragraphs and WYSIWYG text) and **acquiadam_asset_import** (bulk-imports assets
by Widen category).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and choose the submodules you need.
2. [Configuration](configuration/index.md) — connect the site to your DAM domain,
   store credentials safely, map metadata and image styles, and decide which media
   types download locally.

## Where it lives in the admin menu

The connection and settings forms sit under **Configuration → Acquia DAM**
(`/admin/config/acquia-dam`). From there you reach the main connection form, plus
**Metadata** (`/admin/config/acquia-dam/metadata`), **Image styles**
(`/admin/config/acquia-dam/image-styles`), and **Integration links**
(`/admin/config/acquia-dam/integration-links`). Individual editors authorize their
own DAM account from their user page at `/user/{user}/acquia-dam`.

## How to use it

Once the site is connected and an editor has authorized their DAM account, the DAM
assets appear as an extra source inside the core **Media Library**. When adding
media to a field (or inside CKEditor), editors open the Media Library, switch to
the DAM asset view, search and pick an asset, and embed it — either as a remote
reference or, if that media type is set to download, as a synced local copy. The
right rendition is pulled automatically through the module's formatters.
