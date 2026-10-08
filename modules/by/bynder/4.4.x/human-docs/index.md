# Bynder — manual setup guide

**Bynder** (`bynder`) connects the [Bynder](https://www.bynder.com/) cloud Digital
Asset Management (DAM) system to Drupal's core Media. Instead of storing image,
document, and video files on your own server, your editors search, pick, and upload
assets that live in Bynder, and Drupal references them as media entities — keeping
their metadata, image derivatives, and usage in sync over the Bynder API.

Editors get two ways to bring assets in, both surfaced through Entity Browser: a
**Bynder search** widget to browse and insert assets that already exist in your DAM,
and a **Bynder upload** widget to push new files up to Bynder from within Drupal
(with brand, tags, and metaproperties). Once an asset is referenced, dedicated field
formatters render Bynder images (with derivatives, responsive `srcset`, and optional
transformations), documents as download links, and videos in an HTML5 player, while
the remote metadata (title, description, copyright, custom metaproperties) is
available to display and map to fields.

The module talks to Bynder using the official Bynder PHP SDK and authenticates two
ways: a **permanent token** for global, server-to-server access, and optional
**OAuth2** so uploads can be attributed to the individual editor's Bynder account.
Metaproperties, tags, and derivatives are cached (24 hours by default, refreshed on
cron) to keep the UI snappy, and metadata is synced back on a schedule you choose.
Several optional submodules add nicer tag widgets, Amazon SNS push updates, and
usage tracking back to Bynder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the
   Bynder PHP SDK and Entity Browser), enable the module, and choose submodules.
2. [Configuration](configuration/index.md) — enter your Bynder credentials, test the
   connection, set up OAuth, map usage restrictions, and tune caching and metadata
   sync.

## Where it lives in the admin menu

The main settings form is at **Configuration → Media → Bynder**
(`/admin/config/services/bynder`), gated by the **Administer bynder configuration**
permission. You'll also create a **Bynder media type** under **Structure → Media
types** and wire the search/upload widgets into an **Entity Browser** under
**Configuration → Content authoring → Entity browsers**.

## How to use it

At a high level: enter and test your Bynder credentials on the settings form, create
a media type whose source is **Bynder**, add the Bynder search (and optionally
upload) widgets to an Entity Browser, and reference that browser from a media or
media-library field. Editors then browse or upload Bynder assets right where they
add content. The full walkthrough is in [Configuration](configuration/index.md).
