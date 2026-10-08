# Media Image Display Entity View — manual setup guide

**Media Image Display Entity View** (`media_image_display_entity_view`) lets you
choose the **view mode** used when a media reference field renders a referenced
media image. Instead of a media field always rendering the media entity in one
fixed display, you pick which display mode it should use — right there in the
field's formatter settings.

The point is to stop the proliferation of view modes. Normally, every time you want
a media image at a different size you end up creating another image style *and*
another view mode to go with it. This module lets you manage your view modes and
your image styles separately, so you can reuse existing displays and even choose
which link (if any) the field should output.

A companion submodule, **CKEditor support** (`ckeditor_support`), brings the same
capability to in‑text embeds: it works with *Entity Embed* to give embedded media
the same "choose the display mode" control that the field formatter provides.

This is a content‑display feature only. Rendered media continues to follow Drupal's
core media and file access rules, so the module plays no part in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the CKEditor support submodule.

There is **no global settings page** — all configuration happens on a field's
*Manage display* (and, with the submodule, in the Entity Embed dialog), as
described below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it entirely from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage display**, on media
reference fields.

## How to use it

1. Go to a bundle's **Manage display** (for example a content type at
   **Structure → Content types → *(type)* → Manage display**).
2. For a media reference field pointing at image media, choose this module's
   formatter and, in its gear settings, select the **view mode** the media should
   render in — and, if you wish, which link the field should output.
3. Save the display.
4. For in‑text embeds, enable the **CKEditor support** submodule and use *Entity
   Embed* — the embed dialog then offers the same display‑mode choice.
