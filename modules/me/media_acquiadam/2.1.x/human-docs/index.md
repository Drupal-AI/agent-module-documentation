# Media: Acquia DAM — manual setup guide

**Media: Acquia DAM** (`media_acquiadam`) connects Acquia DAM (formerly Widen) to
Drupal's Media ecosystem. It adds an `acquiadam_asset` media source so DAM assets
become Drupal Media entities, an asset browser for editors to search and pick assets,
OAuth authentication against Widen, and background syncing that keeps the imported
assets and their metadata up to date.

Editors authenticate individually — each links their own Drupal account to their DAM
account through an OAuth flow — while an optional site-wide "background" token drives
unattended cron/CLI syncing. On the settings page you configure your DAM domain, the
sync interval and method, and the download/transcode options (original vs derivative,
size limit, image quality and format). A CSV-driven tool and Drush commands let you
bulk-update stored asset references.

An important thing to understand about this **2.x** release: it is largely a **bridge
and migration release** toward the newer **`acquia_dam`** module, which it now depends
on. Alongside the integration itself, it ships a guided migration workflow (admin forms
plus Drush commands) to move an existing Media: Acquia DAM site onto `acquia_dam`. If
you are starting fresh, evaluate `acquia_dam` directly; if you already run this module,
this release gives you the migration path.

Two submodules ship with it: **Media: Acquia DAM Example** (example media types, fields
and displays to get you started) and **Media: Acquia DAM Report** (a Views-based asset
usage report).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it depends on
   `acquia_dam` and `fallback_formatter`) and enable the module.
2. [Configuration](configuration/index.md) — connect your DAM domain and token,
   authenticate editors, set sync and download options, and understand the migration
   path.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Acquia DAM**
(`/admin/config/media/acquiadam`), reachable by anyone with the **Administer site
configuration** permission. The guided migration to `acquia_dam` lives at
**Configuration → Media → Acquia DAM migration**
(`/admin/config/acquia-dam/migration`). The module does not add permissions of its own
beyond core's *Administer site configuration*.
