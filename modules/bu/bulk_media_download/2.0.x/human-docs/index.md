# Bulk Media Download — manual setup guide

**Bulk Media Download** (`bulk_media_download`) is *intended* to let an
administrator download all media of selected bundles as a single ZIP archive. The
plan is a settings form where you pick which media bundles to include, plus a
download button injected onto the admin media list at `/admin/content/media`.

**Important honesty note about the shipped 2.0.x code:** the actual download does
not work. The controller that should build and return the ZIP
(`BulkDownloadController::downloadMedia()`) is a stub that dumps debug output and
stops (`var_dump()` / `die()`), so clicking the button does not produce a working
archive. The real zipping logic sits in a procedural helper in the `.module` file
and shows clear signs of being development-leftover code (debug calls, commented
blocks). Treat this module as **incomplete** — it needs a code fix before it will
actually download anything.

If you still want to try it or build on it, the settings form and routes are
described below and in [Configuration](configuration/index.md). Both are
admin-only (they require the core **Administer site configuration** permission).
It depends on core's **Media** module and supports Drupal 8 through 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core Media).
2. [Configuration](configuration/index.md) — the bundle-selection settings form,
   and an honest note on the broken download.

## Where it lives in the admin menu

- **Settings:** `/admin/config/bulk_media_download/settings`
  (route `bulk_media_download.settings`) — choose which media bundles to include.
- **Download button/endpoint:** `/admin/config/bulk_media_download/button`
  (route `bulk_media_download.button`) — currently a non-functional stub.

Both routes require the core **Administer site configuration** permission
(administrators only).
