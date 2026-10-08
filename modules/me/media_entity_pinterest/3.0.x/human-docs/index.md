# Media entity Pinterest — manual setup guide

**Media entity Pinterest** (`media_entity_pinterest`) adds **Pinterest** as a source
for Drupal's core Media system. Once set up, editors can store a Pinterest pin,
board, board section, or user profile as a media entity simply by pasting its URL,
and the site renders it as a native Pinterest embed — no need to copy Pinterest's
embed HTML by hand.

The module recognizes the four Pinterest URL shapes (a single pin, a whole board, a
board section, and a user profile) across Pinterest's regional domains, and it
validates editor input so only genuine Pinterest URLs are accepted. From a matched
URL it pulls out useful metadata — the pin ID, board slug, section, and username —
which you can map to fields. A dedicated field formatter, **Pinterest embed**, turns
the stored URL into live embed markup and loads Pinterest's official `pinit.js`
widget to render it.

A couple of things worth knowing up front. There is **no Pinterest API integration** —
everything is derived from the public URL and rendered by Pinterest's own widget
script, so each page with an embed calls out to Pinterest's CDN
(`assets.pinterest.com`). And the module ships **no media type of its own**: you
create a Pinterest media type through core's Media UI, which is what the setup below
walks through.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a Pinterest media type, point it
   at a source field, and set the embed formatter.

## Where it lives in the admin menu

The module has no settings page of its own. You configure it entirely through core
Media at **Structure → Media types** (`/admin/structure/media`), using core Media's
own permissions. The one internal setting (where thumbnails are stored) is only
adjustable via config, not a form.

## How to use it

Create a media type that uses the **Pinterest** source, give it a source field for
the URL, and set that field's display formatter to **Pinterest embed**. Then editors
add Pinterest media by pasting a pin/board/section/profile URL. The step-by-step is
in [Configuration](configuration/index.md).
