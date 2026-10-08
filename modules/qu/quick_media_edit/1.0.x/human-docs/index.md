# Quick Media Edit — manual setup guide

**Quick Media Edit** (`quick_media_edit`) smooths out one small but annoying gap in
the editorial workflow: getting back to where you were after editing a media image.
Normally, if you want to tweak a media image — say its focal point — you have to hunt
for it in the Media Library, and after saving you land back in the Media Library
instead of on the page you started from.

This module fixes the return trip. When a media/image formatter renders a link to the
image's edit form, Quick Media Edit adds a **`destination` parameter** to that link
pointing back at the page you were on. After you save the image, Drupal returns you to
the original node form (or wherever you came from) instead of the Media Library.
Importantly, it only does this when you actually have permission to edit the
referenced image — it checks access first, and if you can't edit the image it leaves
the link alone.

There is a caveat worth knowing: the module currently works for **images only**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — its behaviour is automatic once
enabled, after one small display setting on your media image (described below).

## How to use it

The one setup step is to make the media image link to its edit form in the first
place, so Quick Media Edit has a link to enhance:

1. Enable the module.
2. Go to **Structure → Media types → Image → Manage display** for the *Media library*
   view mode
   (`/admin/structure/media/manage/image/display/media_library`).
3. Set the image field to be **linked to content** (rather than the default).

From then on, editors with permission to edit the image can click straight through to
its edit form and, after saving, be returned to the page they came from. Users who
lack edit access are unaffected — the link is left as it was.
