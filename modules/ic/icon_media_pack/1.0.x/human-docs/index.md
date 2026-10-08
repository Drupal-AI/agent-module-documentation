# Icon Media Pack — manual setup guide

**Icon Media Pack** (`icon_media_pack`) lets you use a **media bundle as an icon
pack** for Drupal's Icon API. If you already keep your icons as Media entities —
SVGs or images stored in a media bundle — this module registers that bundle as a
UI Icons icon pack, so those icons become selectable everywhere Drupal offers an
icon picker (menus, fields, and other places that consume the Icon API).

It builds directly on Drupal core's **Media** system and the contrib **UI Icons**
modules. Rather than shipping its own icon set, it turns your own media library
into one — a good fit when your icons are managed as content (uploaded, permission‑
controlled, reused) instead of bundled as theme assets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies and enable it.

There is **no standalone settings form** for this module. You set it up by
defining which media bundle acts as an icon pack, as described below.

## How to use it

1. Have a **media bundle** that holds your icons — for example a media type whose
   items are SVG or image files you want to reuse as icons. Add your icons to it
   as media entities.
2. **Define that media bundle as an icon pack** for the Icon API. Once registered,
   the media bundle's items appear as an available icon collection.
3. **Pick the media icons anywhere** Drupal offers an icon selector (via UI Icons)
   — for instance when adding an icon to a menu item or an icon field — choosing
   your media‑backed collection.

Because it plugs into the shared Icon API through UI Icons, the icons you expose
this way behave like any other icon pack in the picker.
