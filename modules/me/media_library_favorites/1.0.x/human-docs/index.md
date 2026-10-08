# Media Library Favorites — manual setup guide

**Media Library Favorites** (`media_library_favorites`) adds a personal
**favourites** feature to the Media Library, so editors can mark the media they use
most and get back to it quickly. On a site with a large library, this is a big help
for media reuse — rather than scrolling and re‑searching, an editor picks from their
own shortlist.

Favouriting is per user. Editors can toggle a media item as a favourite directly
from the Media Library, and a **"Favourites"** link appears in the Media Library
modal alongside the core **Grid** and **Table** views, showing only the current
user's favourite media for the allowed bundles.

Concretely, the module provides:

- an easy way to favourite/unfavourite media on a per‑user basis,
- a **Views display** within the Media Library view that lists the current user's
  favourites,
- a **Views filter** to limit results to the current user's favourited media, and
- a **Views field** that renders the favourite/unfavourite link on a media item.

Access to favouriting is gated by the **allow media favorites** permission, so you
choose which roles get the feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission.

There is **no dedicated settings form**. Setup is just a matter of granting the
permission (and, if you want to customise the display, the Views pieces are already
wired into the Media Library view), as described below.

## How to use it

1. Grant the **allow media favorites** permission to the roles that should be able
   to favourite media (**People → Permissions**).
2. Those users can then click the favourite toggle on media items in the Media
   Library, and use the **Favourites** link in the modal to see just their own
   favourites.
3. The favourites display, filter, and field live in the **Media Library view**, so
   if you want to fine‑tune how favourites appear you can adjust them there via the
   Views UI.
