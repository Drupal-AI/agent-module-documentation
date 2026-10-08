# Font Awesome UI — manual setup guide

**Font Awesome UI** (`fontawesome_ui`) brings the popular
[Font Awesome](https://fontawesome.com) icon library into Drupal and gives you a
place to manage it. Instead of hand‑editing your theme to load the library, you
turn on this module, point it at Font Awesome (from a CDN or from a local copy),
and choose how the icons are delivered — SVG + JavaScript, or webfonts + CSS,
minified or not. From that moment your site can render Font Awesome icons.

On top of loading the library, the module adds a small "icon manager": a list of
reusable icon definitions at **Structure → Icon** where you can add, edit,
duplicate, and delete icons, plus a filter to search the list. This lets you keep
a curated set of icons (with size, color, rotation, animation, and other options
baked in) ready for editors and themers to reuse.

Everything the module exposes — the settings form and the icon manager — is
gated behind a single permission, **`administer fontawesome ui`**, so only
trusted administrators can change how icons load or edit the icon library. One
thing to know up front: the module integrates the library, but the actual Font
Awesome files are installed separately, either with the bundled Drush command or
via Composer (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the Font Awesome library, and enable it.
2. [Configuration](configuration/index.md) — the settings form (CDN vs local,
   delivery format, version, restrictions) and the icon manager, field by field.

## Where it lives in the admin menu

Once enabled, the module has two homes in the admin menu:

- **Configuration → User interface → Font Awesome**
  (`/admin/config/user-interface/fontawesome`, route `fontawesome.settings`) —
  the global settings that decide how the library loads.
- **Structure → Icon** (`/admin/structure/icon`) — the icon manager, where you
  build and maintain reusable icon definitions.

Both require the **`administer fontawesome ui`** permission.
