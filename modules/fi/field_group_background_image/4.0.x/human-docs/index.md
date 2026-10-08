# Field Group Background Image — manual setup guide

**Field Group Background Image** (`field_group_background_image`) adds a new
**Background Image** display format to the [Field Group](https://www.drupal.org/project/field_group)
module. When you group a set of fields together on an entity's display and choose
this format, the group is wrapped in a `<div>` whose CSS `background-image` is
pulled from an image or media field on the same entity. It's the no‑code way to
build hero banners, full‑width promotional sections, and image‑backed cards whose
picture is chosen by editors rather than hardcoded in your theme's CSS.

The module provides a single field‑group formatter, `background_image`, available
wherever Field Group is used in the **view** display context (Manage display). You
point it at one of the entity's own image fields — either a core **image** field
or an **entity reference** field targeting **media** — and it renders the group as
a container div with `background-image: url('…')`. You can apply an image style to
use a cropped or resized derivative, add a stable HTML `id` for anchor links or
custom CSS, append extra inline CSS (for example `background-size: cover;
background-position: center;`), and tick **Hide if missing image** to suppress the
whole group when no image is provided. If the contrib **Color Field** module is
installed, you can also emit a `background-color` (with rgba opacity) from a color
field, for tinted overlays or solid backgrounds.

It requires the **Field Group** module (and, optionally, **Color Field** for the
background‑color feature) and core's **Field** module. There is no settings page,
no permissions, and no Drush commands — everything is configured per field group in
the display settings. There are no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Field Group dependency) and enable the module.

## Where it lives in the admin menu

There is no dedicated admin page. The **Background Image** format appears inside
Field Group on any entity's **Manage display** tab (for example **Structure →
Content types → [your type] → Manage display**).

## How to use it

1. On the entity's **Manage display** tab, add a field group (a Field Group
   feature) and drag the fields you want into it.
2. Set the group's **Format** to **Background Image**.
3. Open the group's format settings (the gear icon) and configure:
   - **Image** — the source field. Pick any core image field, or an entity
     reference field pointing at media. This is required for anything to render.
     (If the bundle has no image or media field, the form tells you to add one
     first.)
   - **Image style** — an optional image style to apply; leave empty to use the
     original file.
   - **Color field** — shown only when the **Color Field** module is enabled; a
     color field emitted as the group's `background-color` (rgba when the value
     carries opacity).
   - **Inline styles** — extra CSS appended verbatim to the div's `style`
     attribute, e.g. `background-size: cover; background-position: center;`.
   - **Hide if missing image** — when ticked, the whole group is hidden if the
     selected field has no image.
   - **ID** — an HTML `id` set on the wrapping div, handy for anchor links or
     targeted CSS/JS.

Save the display. The grouped fields now render on top of the chosen background
image, driven entirely by editorial content.
