# Media Entity Podigee — manual setup guide

**Media Entity Podigee** (`media_entity_podigee`) adds a media source for
[Podigee](https://www.podigee.com/), letting editors embed Podigee podcast
episodes as Drupal media entities. You paste a Podigee permalink URL into the
media item and the module displays the podcast player via oEmbed, so episodes live
in the Media Library and can be reused across the site like any other media.

Unlike some of the other podcast/video sources, Podigee integration is built on
the [oEmbed Providers](https://www.drupal.org/project/oembed_providers) contrib
module and needs a one‑time setup step: you register Podigee as a **custom oEmbed
provider** so Drupal will accept Podigee URLs. That step is described under "How to
use it" below and is essential — without it, Podigee URLs won't be allowed. The
module runs on Drupal 10 and 11 and depends on core's Media module plus oEmbed
Providers.

Because the player is embedded from Podigee's servers, the podcast loads
third‑party content in your visitors' browsers — the usual egress and privacy
consideration for any external embed. The module has no access‑control role of its
own; Drupal's normal media access applies.

> **Heads‑up on core compatibility.** The project notes that a Drupal core patch
> may currently be required for Podigee thumbnails to work (a check on thumbnail
> width and height). Review the module's project page for the current status
> before deploying, especially if thumbnails matter to you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its oEmbed
   Providers dependency) with Composer and enable it.

This module has no settings page of its own. Setup is a matter of registering the
Podigee oEmbed provider and creating a media type that uses the Podigee source,
both described below.

## Where it lives in the admin menu

The custom oEmbed provider is registered under **Configuration → Media → oEmbed
Providers → Custom providers**
(`/admin/config/media/oembed-providers/custom-providers`), which comes from the
oEmbed Providers module. The media types you create with the Podigee source appear
under **Structure → Media types** (`/admin/structure/media`), and individual
episodes are managed from **Content → Media** (`/admin/content/media`).

## How to use it

1. **Register Podigee as a custom oEmbed provider.** Go to
   `/admin/config/media/oembed-providers/custom-providers` and add a provider with
   these values (from the module's documentation):
   - **Provider name:** `Podigee`
   - **Provider URL:** `https://podigee.com`
   - **Endpoint schemes:** `https://*.podigee.io/*`
   - **Endpoint URL:** `https://embed.podigee.com/oembed`
   - **Available formats:** `JSON`
2. **Create a media type that uses the Podigee source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), name it (for
   example "Podigee episode"), and in the **Media source** field choose
   **Podigee**. Save.
3. **Add an episode.** Go to **Content → Media → Add media**, choose your Podigee
   media type, and paste a Podigee permalink URL (for example a
   `…​.podigee.io/…` episode URL). Save.
4. **Reuse it.** The episode is now in the Media Library and can be referenced
   from media reference fields across the site.
