# Media OpenGraph — manual setup guide

**Media OpenGraph** (`media_opengraph`) adds a new media source plugin — and a
ready‑made media type that uses it — for turning a plain link into a rich media
entity. Give it a URL and it fetches that page's OpenGraph/meta tags (title,
description, image) and renders a local preview, much like the link cards you see
when you paste a URL into Twitter or Facebook.

The default media type maps the fetched image, title, and description into fields
with some very basic styling. It's expected that most sites will want to customise
the theme/markup to fit their design — the module gives you the data and a starting
point, not a finished component. Fetched metadata is cached (page metatags for
roughly an hour, mapped field data for about a week by default), since metatags on
pages outside your control change more often than files you upload yourself.

The module fetches the remote URL server‑side to read its OpenGraph tags. It has
no access‑control role of its own. It depends on core's
**Media** module, and Media Library is recommended.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page**. You configure the module by editing the
media type it provides (or creating your own) and mapping metatags to fields —
described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. Its media type lives with the rest of
your media types at **Structure → Media types** (`/admin/structure/media/types`).

## How to use it

1. After enabling the module, go to **Structure → Media types**
   (`/admin/structure/media/types`). You'll find the default OpenGraph media type
   provided by the module — or you can add a new media type that uses the
   **OpenGraph** media source.
2. Site builders customise the **mapping of metatags to fields** on the media
   type: which field receives the fetched image, which the title, and which the
   description. Advanced site builders can even map non‑documented metatags by
   editing and importing configuration manually.
3. Create a media item of that type by entering a link. The module fetches the
   target page's OpenGraph tags and populates the mapped fields, producing a local
   preview card. Restyle/theme the output to match your site.
