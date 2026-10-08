# Cincopa Multimedia Platform — manual setup guide

**Cincopa Multimedia Platform** (`cincopa`) connects Drupal to
[Cincopa](https://www.cincopa.com), a commercial media hosting and delivery
service, so editors can embed Cincopa-hosted videos, photo galleries,
slideshows, music and playlists in their content. Instead of storing and
streaming large media files from your own server, the hosting, encoding and
delivery all happen on Cincopa's platform, and Drupal simply embeds the result.

The value is offloading media: rich players, galleries and streaming come from
Cincopa's network and designed templates, and your Drupal site stays lean. To
use it you need a Cincopa account — the service offers a free trial — and the API
credentials that tie your site to that account.

Because the module talks to a paid third-party service on your behalf, treat the
Cincopa API credentials as secrets: store them in an environment variable rather
than in code or plain configuration (see the installation guide for the DDEV
pattern). Keep in mind that embedded media is served from Cincopa's servers, so
your visitors load assets from an external origin, and usage may count against
your Cincopa plan.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect your Cincopa account.

## How to use it

Once the module is enabled and your Cincopa account is connected, editors add
Cincopa media into content through the Cincopa embedding workflow — pick a video,
gallery, or slideshow from your Cincopa library and it is inserted into the page,
rendered through Cincopa's player. The media itself lives on Cincopa; Drupal only
stores the reference and displays the embed.

Before any of that works you must supply your Cincopa API credentials, which is a
one-time connection step described in the installation guide. Without valid
credentials the module has nothing to embed.
