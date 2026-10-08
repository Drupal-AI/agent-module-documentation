# SVG image field — manual setup guide

**SVG image field** (`svg_image_field`) adds a dedicated **"Vector image"** field
type, upload widget, and display formatters so SVG files can be uploaded,
sanitized, and rendered on your site. This matters because Drupal core's Image
field is backed by GD/ImageMagick and simply **rejects SVG files** — so if you
want scalable logos, icons, or illustrations stored as SVG, you need a field type
like this one.

The field (machine name `svg_image_field`, labeled *Vector image*) is built on
core's File field and comes with a matching widget and two formatters. The widget
shows an inline SVG preview at a configurable maximum size and supports optional
**Alt** and **Title** text, just like the core image field. The main formatter
can render the SVG **inline in the DOM** (so its paths can be styled or animated
with CSS) or as an **`<img>`** tag, apply width/height, force‑fill a container,
and link the image to its entity or file. Crucially, it **sanitizes** the SVG
markup on output using the bundled `enshrined/svg-sanitize` library — stripping
scripts and other unsafe content, since SVGs can otherwise carry XSS — with a
separate option for remote SVGs. A second formatter outputs just the file URL for
use in templates or CSS.

There's **no admin settings page**: everything is configured per field through
the normal Field UI (the widget and formatter settings). A **media source**
plugin also lets you build an SVG media type so SVGs work with the core Media
Library, and a validation constraint verifies uploads are genuinely SVG by
checking both MIME type and content. The module depends on core's **Image**
module and requires the **`enshrined/svg-sanitize`** PHP library (installed via
Composer) and **PHP 8.0+**. An optional submodule,
**`svg_image_field_media_bundle`**, imports a ready‑made "Vector image" media
type so you don't have to build one by hand.

This guide is written for a **human** adding and configuring the field through the
admin UI. If you want terse, token‑cheap references for an AI coding agent —
including plugin IDs, the media source, and theming — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   sanitizer library), enable it, and optionally add the media bundle submodule.

## Where it lives in the admin menu

There's no central settings page. You work with it through the standard field
UIs:

- **Manage fields** for a bundle (`.../fields`) — add a *Vector image* field.
- **Manage form display** (`.../form-display`) — configure the widget (preview
  max size, whether Alt/Title are shown or required).
- **Manage display** (`.../display`) — choose the formatter (inline vs `<img>`,
  dimensions, linking, sanitization, or the URL‑only formatter).

## How to use it

1. Go to **Manage fields** on the content type, vocabulary, or entity that should
   carry an SVG, and add a field of type **Vector image**.
2. On **Manage form display**, tune the widget — the inline preview's maximum
   width/height, and whether to show or require **Alt** and **Title** text (require
   Alt to enforce accessible markup).
3. On **Manage display**, choose how it renders: **inline** in the DOM (best when
   you want to style/animate the SVG with CSS) or as an **`<img>`** tag, set
   width/height or force‑fill, decide whether to link it, and leave the **output
   sanitization** on to strip scripts. Use the **URL** formatter instead if you
   only need the file's address.
4. To use SVGs as media, either build a media type on the provided `svg` media
   source, or enable the `svg_image_field_media_bundle` submodule to get a
   ready‑made *Vector image* media type that works in the Media Library.

Typical uses: crisp, resolution‑independent logos and icons that stay sharp on
high‑DPI screens; CSS‑styleable inline illustrations; and serving small vector
assets instead of large PNGs for better performance — all with uploaded SVGs
safely sanitized.
