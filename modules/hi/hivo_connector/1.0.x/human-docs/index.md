# Hivo Connector — manual setup guide

**Hivo Connector** (`hivo_connector`) connects Drupal to
[Hivo](https://www.wearehivo.com/), a cloud digital‑asset‑management (DAM)
platform, so your editors can move assets between the two systems without leaving
Drupal. In practice it does three things:

- **Download media from Hivo into Drupal** — pick assets from your Hivo library
  and add them to Drupal's media library, ready to attach to content or use in
  layouts.
- **Upload existing Drupal media to Hivo** — send images, videos, and other media
  that already live in Drupal up to your Hivo workspace to organise, reuse, or
  distribute from there.
- **Embed Hivo media via CDN URL** — while writing in CKEditor 5, insert Hivo
  media that is delivered straight from Hivo's CDN (faster delivery, less load on
  Drupal). CDN embedding must be enabled on your Hivo account for this to work.

The module depends on core **File**, **Media**, and **CKEditor 5**, requires
Drupal 11 with PHP 8.0 or higher, provides its own permissions, and — of course —
needs a **Hivo account**. Because it talks to an external service on your behalf,
treat the connection credentials as secrets and make sure the site can reach
Hivo's servers (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your Hivo account, add the
   Hivo button to a text format, and store credentials securely.

## Where it lives in the admin menu

After enabling, you connect to Hivo at **Administration → Hivo Connector**
(`/admin/hivo-connector`). The CKEditor embed button is turned on per text format
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Full setup is in
[Configuration](configuration/index.md).
