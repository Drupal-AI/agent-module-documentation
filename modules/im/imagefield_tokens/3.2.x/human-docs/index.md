# Image Field Tokens — manual setup guide

**Image Field Tokens** (`imagefield_tokens`) lets you put tokens — placeholders
like `[node:title]` — into the **Alt** and **Title** text of images, and have
them filled in automatically from the surrounding content. Instead of retyping
alt text on every image, an editor can type `[node:title]` once and every image
on an *Article* gets alt text derived from that article's title.

It works by adding its own **widget** and **formatter** to core's existing Image
field, so it doesn't create a new field type and there's nothing to install on
your data. On the editing side, the widget adds a *token tree* link next to the
Alt and Title boxes so editors can browse and insert available tokens, and it
previews the replacement as you go. On the display side, the formatter runs the
tokens through Drupal's token engine at render time, resolving them against the
entity the image belongs to — with the proper cache metadata so a token‑derived
value refreshes correctly when the source field changes.

The raw token text (for example `[node:title]`) is stored verbatim in the image's
Alt/Title values and only expanded when the image is shown. Because it targets
core Image fields, it works anywhere an image field is used, including Media, and
it plays nicely with FileField Sources and IMCE. Two companion plugins light up
only when their modules are present: a crop‑aware widget when **Image Widget
Crop** is enabled, and a Colorbox formatter when **Colorbox** is enabled.

It depends on the **Token** module plus core **Image** and **Media Library**.
There is **no settings form, permission, or Drush command** — you use it purely by
selecting its widget on *Manage form display* and/or its formatter on *Manage
display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration page. You turn the module on for a specific image field
by choosing its widget (for editing) and/or formatter (for display).

**Turn on token entry (the widget):**

1. Go to the bundle's **Manage form display** — for example **Structure → Content
   types → Article → Manage form display**.
2. Find your image field and change its **Widget** to **Image (Image Field
   Tokens)** (`imagefield_tokens`).
3. Save. The image widget now shows a token‑tree link; editors can type tokens
   such as `[node:title]` into the Alt and Title fields and see a preview of the
   replacement.

If the **Image Widget Crop** module is enabled, a second crop‑aware widget
(`imagefield_tokens_widget_crop`) is also available, combining cropping with
token entry.

**Turn on token replacement (the formatter):**

1. Go to the bundle's **Manage display** — for example **Structure → Content types
   → Article → Manage display**.
2. Change the image field's **Format** to **Image (Image Field Tokens)**
   (`imagefield_tokens`), choose an image style as usual, and save.
3. When the image renders, any tokens stored in its Alt/Title are expanded against
   the host entity.

If the **Colorbox** module is enabled, an `imagefield_tokens_colorbox` formatter
is also available, applying the same token replacement while rendering through
Colorbox.

> **Compatibility note (Drupal 11.4+).** On Drupal 11.4 and later the
> `imagefield_tokens` **display formatter** currently fails to instantiate because
> core's `ImageFormatter` gained an extra constructor argument the module doesn't
> yet pass (`ArgumentCountError`). The **widget** is unaffected. Until the module
> is patched, on 11.4+ use the widget for token *entry* and the plain core image
> formatter for *display*.
