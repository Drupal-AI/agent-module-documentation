# Fontello Icon — manual setup guide

**Fontello Icon** (`md_fontello`) integrates the [Fontello](https://fontello.com) icon
service with Drupal, so you can use custom icon fonts in your themes and modules. Fontello
lets you assemble a bespoke icon font from many icon libraries and download it as a bundle;
this module imports that bundle and makes its icons available to render in Twig, with an
optional `md_icon_link` submodule for icon‑enhanced links. It is part of the MegaDrupal
package of modules.

Icons here are purely **presentational** — the module adds icon assets for theming and has
no access‑control or content role of its own. Once you have imported a Fontello set, you
place icons in templates with a small Twig helper, or attach a specific font's library to
a page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   optionally enable the icon‑link submodule.

This module has no global settings form. Its only admin screen is the icon‑set **import**
form, described under "How to use it" below.

## Where it lives in the admin menu

Fontello Icon adds an import screen under **Structure → Fontello Icon**
(`/admin/structure/md_fontello/add`), where you name and upload a downloaded Fontello
font. There is no separate configuration page — everything else happens in your theme's
Twig templates.

## How to use it

1. **Build and download a font.** Go to [fontello.com](https://fontello.com), select the
   icons you want from the available libraries, and download the generated font bundle.
2. **Import it.** In Drupal, go to **Structure → Fontello Icon → Add**
   (`/admin/structure/md_fontello/add`), give the set a **name** (this becomes the machine
   name you reference in Twig), and upload the downloaded file to import it.
3. **Render an icon in Twig** with the `md_icon()` helper — pass the font name and the
   icon's CSS class:

   ```twig
   {{ md_icon('font_awesome', 'icon-video') }}
   ```

4. **Or just attach a font's library** when you want to style icons yourself. In Twig:

   ```twig
   {{ attach_library('md_fontello/md_fontello.font_awesome') }}
   ```

   Or from PHP, for example in `hook_page_attachments()`:

   ```php
   function mymodule_page_attachments(array &$attachments) {
     $attachments['#attached']['library'][] = 'md_fontello/md_fontello.font_awesome';
   }
   ```

Replace `font_awesome` with whatever name you gave the set when you imported it.

## The icon‑link submodule

Enable **`md_icon_link`** if you want fields that combine an icon with a link — it adds
support for a field that shows a link together with a chosen icon, using a UI selector.
Enable it only when you need that; the base module is enough for Twig‑rendered icons.
