# Media Entity: Unsplash — manual setup guide

**Media Entity: Unsplash** (`media_entity_unsplash`) integrates
[Unsplash](https://unsplash.com/)'s library of millions of free, high‑quality
photos into your Drupal site as media. You paste an Unsplash photo ID or URL, and
the module fetches the image through the Unsplash API, stores it locally, and
generates the photographer attribution Unsplash requires. It works seamlessly with
Drupal's Media Library, depends only on core (the Image module), and runs on Drupal
10.3 and 11.

Attribution is handled for you: because Unsplash photographers contribute their
work for free and attribution is how they benefit, the module automatically
produces the "Photo by *Photographer* on Unsplash" credit with profile links, so
you stay compliant with Unsplash's terms without extra effort.

Two things set this module apart from the plain "paste a URL" media sources and
shape how you set it up. First, it talks to the Unsplash API on your behalf, so it
needs **API credentials** — you create a free Unsplash application to get them.
Second, because it *downloads* each photo and stores it locally, the images become
ordinary local files (so image styles and the rest of Drupal's image handling
apply normally) — but the fetch means your server makes outbound (egress) calls to
Unsplash's API. Treat the API key as a secret: store it in an environment variable
and reference it through a Key entity rather than pasting it into exported
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Image module.
2. [Configuration](configuration/index.md) — obtain Unsplash API credentials,
   store the key securely, and connect the module.

## Where it lives in the admin menu

The Unsplash media source is set up like any other media source, under **Structure
→ Media types** (`/admin/structure/media`), and individual photos are added from
**Content → Media** (`/admin/content/media`) or through the Media Library. The API
credentials are entered where the module asks for them during setup — see
[Configuration](configuration/index.md).

## How to use it

1. Complete the [Configuration](configuration/index.md) steps so the module has
   working Unsplash API credentials.
2. Create a media type that uses the **Unsplash** media source (or use the one the
   module provides), under **Structure → Media types**.
3. Add an Unsplash photo from **Content → Media → Add media**, pasting an Unsplash
   photo ID or full URL. The module downloads the image, stores it locally, and
   attaches the photographer attribution automatically.
4. Reference the photo anywhere media is supported — media reference fields, the
   Media Library, and CKEditor.
