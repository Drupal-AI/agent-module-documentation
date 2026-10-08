# Frontify Assets — manual setup guide

**Frontify Assets** (`frontify_assets`) integrates the **Frontify (V2)
digital-asset-management (DAM) platform** with Drupal, letting editors browse and
use images, videos, and documents stored in Frontify as Drupal media. It uses the
newer **Frontify Finder 2** media browser and simplifies pulling brand assets from
your central Frontify platform into Drupal fields and WYSIWYG editors.

Compared with the older [Frontify](https://www.drupal.org/project/frontify) module
(which is built on Finder version 1), Frontify Assets supports more content-type
features: multiple Frontify fields on the same content type, image styles for
images, multiple formats for images/videos/documents, Colorbox support in views,
and inline or popup video playback.

The module ships a `frontify_assets_colorbox` submodule for lightbox display and
provides its own permissions. It plays a media/integration role only — it has no
access-control role on your site beyond that permission.

Because it connects to the **Frontify API**, store the API token/credentials as
secrets and keep all traffic over HTTPS. Assets remain hosted in Frontify and are
referenced from Drupal, so mind availability and access on the Frontify side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the Colorbox submodule if you want it.
2. [Configuration](configuration/index.md) — enter your Frontify API URL and Client
   ID and store the credentials safely.

## Where it lives in the admin menu

After enabling, configure the connection at **Configuration → Media → Frontify
Settings**. You then select assets through the Frontify Finder 2 browser from your
media/image fields and WYSIWYG editors.
