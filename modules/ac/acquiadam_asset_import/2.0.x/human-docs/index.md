# Acquia DAM Asset Importer — manual setup guide

**Acquia DAM Asset Importer** (`acquiadam_asset_import`) **bulk-imports assets from
Acquia DAM (Widen) into Drupal media**. Where the base *Media: Acquia DAM*
integration lets you reference DAM assets, this module pulls digital assets —
images and files — out of an Acquia DAM account and creates the matching Drupal
media entities in bulk, so a library of assets lands in Drupal without hand-adding
each one.

It builds on **Media: Acquia DAM** (`media_acquiadam`) and also uses the **Token**
module. It is a **media / integration** feature: the import fetches assets from the
Acquia DAM service over HTTPS (external egress), and the media it creates then
follows Drupal's normal core media and file access — the module adds no
access-control layer of its own.

**Credentials live in the base module, not here.** The Acquia DAM API credentials
are configured in **Media: Acquia DAM** (`media_acquiadam`), which handles
authentication with the DAM service. Treat those credentials as secrets — keep them
in an environment variable rather than committed configuration. This importer
reuses that existing connection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and the
   modules and DAM connection it depends on.

## Where it lives in the admin menu

The importer works on top of the Acquia DAM connection you set up in **Media: Acquia
DAM**. The DAM credentials and connection settings live under that base module's
configuration; this module adds the bulk-import step that runs against it.

## How to use it

1. Set up the **Acquia DAM connection** in the `media_acquiadam` module first —
   enter and authenticate the DAM API credentials there (kept as secrets), so Drupal
   can talk to your Acquia DAM / Widen account.
2. With the connection working, run the **import** this module provides to pull
   assets from Acquia DAM in bulk and create the corresponding Drupal media entities.
3. The imported media then behaves like any other Drupal media — subject to core
   media and file access — and can be used across your content.
