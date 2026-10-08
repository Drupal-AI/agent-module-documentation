# Kontainer — manual setup guide

**Kontainer** (`kontainer`) integrates the [Kontainer](https://kontainer.com/)
digital asset management (DAM) platform with Drupal's media system. It lets
editors bring assets from your Kontainer account into Drupal through the Media
Library — either **downloading** them into local media, or **referencing** them
directly from Kontainer's **CDN** — and it reports back to Kontainer where each
asset is used across your site.

Its main capabilities are: **media import** into Drupal's media storage; **CDN
integration** so assets can be served straight from Kontainer's CDN; **crop and
resize templates** applied to CDN images via a URL transform; and **file‑usage
tracking**, which monitors how often and where your files are used (via the Entity
Usage module) and sends that information back to Kontainer. It ships several media
types (Kontainer image, video, document, file, and a CDN type).

Connecting to Kontainer needs a **Kontainer URL** plus an **integration id and
secret** issued by Kontainer. The integration secret is a credential — this guide
recommends keeping it in an environment variable rather than committed
configuration. Kontainer also calls back into your site (to read file usage) on a
dedicated authenticated endpoint; the module verifies that callback with a
constant‑time comparison and refuses it when the secret is unset, which is the
correct defensive posture.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   media/Entity Usage dependencies, and enable it.
2. [Configuration](configuration/index.md) — connect to Kontainer, store the
   integration secret securely, wire the usage callback, set up CDN image
   conversions, and enable usage tracking.

## Where it lives in the admin menu

Kontainer's main settings live at **Configuration → Media → Kontainer**
(`/admin/config/media/kontainer`, route `kontainer.admin.config`), behind the
**Administer Kontainer settings** permission. CDN image conversions are managed at
`/admin/structure/cdn-image-conversion`, and usage tracking is toggled in the
**Entity Usage** settings at `/admin/config/entity-usage/settings`.

## How to use it

Once configured, an editor opens the **Media Library**, picks an asset from
Kontainer, and the module either downloads it into `public://Kontainer` as a
Drupal file/media entity or stores its CDN URL — depending on the media source you
chose. CDN images can carry a crop/resize template. Meanwhile the module tracks
where assets are referenced on nodes (and nested paragraphs) and reports that back
to Kontainer.
