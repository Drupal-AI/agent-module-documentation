# Media External — manual setup guide

**Media External** (`media_external`) lets editors search third‑party stock photo
providers straight from Drupal's **Media Library** and import the pictures they
pick as normal local media items. **Pexels** and **Unsplash** are built in, and
the module is extensible so a developer can add more providers.

The way it works: you create a media type whose source is **External media** and
point it at a provider. From then on, when an editor adds media of that type they
get a keyword search box inside the Media Library. Type "mountains", hit search,
click the thumbnails you want, and import them. Drupal stores the external image's
ID locally (plus metadata like the file URL, alt text, description, and
photographer) and downloads a thumbnail for the library grid, while the full‑size
image stays remote — so you can keep storage light and still apply image styles
through the companion **imagecache_external** module.

Provider API keys are read from your site's `settings.php` rather than stored in
configuration or the UI, which keeps them out of exported config and out of the
database. Adding a new provider (a different stock library, or even a non‑image
source) is a matter of writing a small provider plugin — see the agent docs for
the interface.

The module has **no global settings page**. Setup happens on the media type you
create and in `settings.php`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   imagecache_external) and enable the module.
2. [Configuration](configuration/index.md) — add your provider API keys to
   `settings.php`, create the media type, and map the metadata.

## Where it lives in the admin menu

There is no dedicated settings page. You configure Media External at
**Structure → Media types → Add media type** (`/admin/structure/media/add`),
choosing **External media** as the source, and by editing your site's
`settings.php`. Editors then use it wherever the Media Library appears.

## How to use it

1. Add your provider API key(s) to `settings.php` (see
   [Configuration](configuration/index.md)).
2. Create a media type on the **External media** source and pick a provider.
3. When adding media of that type, use the **Add by keyword** search box in the
   Media Library, run a search, select thumbnails, and click **Import**.
