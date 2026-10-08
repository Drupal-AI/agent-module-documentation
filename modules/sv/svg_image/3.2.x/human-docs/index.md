# SVG image — manual setup guide

**SVG image** (`svg_image`) lets Drupal's ordinary core **Image** field accept,
preview, and display SVG (vector) files. Out of the box Drupal rejects `.svg`
uploads on an Image field because it validates them as raster images and its
formatters cannot render vector markup. This module transparently swaps in
replacement classes for the core image widget and the `image` / `image_url`
formatters, so your existing Image fields keep working exactly as before while
gaining SVG support — no separate file type, media type, or extra field needed.

To turn SVG on for a field you simply add `svg` to that field's list of allowed
file extensions. From then on the overridden widget permits the upload, drops
core's "file is an image" validator, and shows a proper preview in the edit form.
On display you can render each SVG either as an ordinary `<img>` tag or as inline
`<svg>` markup, and you can force explicit width and height. Every inlined SVG is
first run through the `enshrined/svg-sanitize` library to strip scripts and other
unsafe content, which mitigates cross‑site‑scripting from uploaded vector files.

The module depends on core's **Image** module and requires the
`enshrined/svg-sanitize` PHP library, which Composer installs for you. There is
**no central settings page** — everything is controlled through the normal field
and display forms, so there is a little configuration to do per field before SVGs
appear. Uninstalling is clean: it removes the `svg` extension it added to your
fields and restores the core Image dependency.

One optional submodule, **SVG Image Responsive** (`svg_image_responsive`),
extends the same treatment to core's Responsive image formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick up the sanitizer library.
2. [Configuration](configuration/index.md) — allow SVG uploads on a field and
   choose how they display, field by field.

## Where it lives in the admin menu

SVG image has **no configuration page of its own** (`configure` is null). Instead
it enhances the field and display forms you already use:

- **Structure → Content types → [type] → Manage fields → [image field] →
  settings** — where you add `svg` to the allowed extensions.
- **Structure → Content types → [type] → Manage display** — where the image
  formatter gains its "render as image vs. inline SVG" and width/height options.

See [Configuration](configuration/index.md) for the step‑by‑step.
