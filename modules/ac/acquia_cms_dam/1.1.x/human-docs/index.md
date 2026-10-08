# Acquia CMS DAM — manual setup guide

**Acquia CMS DAM** (`acquia_cms_dam`) provides the configuration that integrates
**Acquia DAM** — Acquia's digital-asset-management platform — with the Acquia CMS
media system, so editors can use Acquia DAM-hosted assets as media inside Drupal.

It is part of the **Acquia CMS** family and depends on `acquia_cms_image`. The
connection to Acquia DAM uses account credentials, which must be treated as
**secrets** (never hard-coded or committed). This is a media/DAM integration: it
governs how assets are sourced and displayed, not who can access content — access
is still governed by Drupal's core media/entity access.

Use it on Acquia CMS sites that rely on Acquia DAM for centralized asset
management. You need a working Acquia DAM subscription and credentials for it to
function.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — connect the module to your Acquia
   DAM account, storing the credentials securely.

## Where it lives in the admin menu

Once enabled, the module adds Acquia DAM as a media source so DAM-hosted assets
become available through the standard media locations:

- **Content → Media** and the **Media library** — where DAM assets appear
  alongside other media once the connection is configured.
- **Structure → Media types** — the media type(s) wired to the Acquia DAM source.

## How to use it

After connecting the module to Acquia DAM (see
[Configuration](configuration/index.md)), editors browse and select DAM-hosted
assets from the Media library the same way they pick any other media, and those
assets can be referenced from media-reference fields across the site.
