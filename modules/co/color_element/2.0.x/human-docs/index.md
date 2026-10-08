# Color Element — manual setup guide

**Color Element** (`color_element`) adds a **color-picker field** to Drupal — a
field type and widget that let editors choose and store a color value (such as a hex
color) on an entity. It is handy when a piece of content should carry its own color:
per-entity styling, theming accents, or a swatch shown alongside the content.

There is no site-wide settings screen. You add a Color Element field to a content
type (or any fieldable entity) through the Field UI, and the list of colors editors
may choose from is set on the field's **Manage form display** options. By default the
chosen color is rendered as a small **swatch** in the entity view, and you can
override the default template (`color-element.html.twig`) in your own theme if you
want to present it differently.

The module has no dependencies beyond Drupal core and no content or access role of
its own — it simply stores a color. The bundled Color formatter HTML-escapes the
stored value before placing it into the swatch's inline `background-color` style.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — you set the field up through the Field UI,
described in "How to use it" below.

## How to use it

1. Go to a content type (or other entity bundle) under **Structure**, e.g.
   **Structure → Content types → *(type)* → Manage fields**.
2. **Add field** and choose the **Color Element** field type. Give it a label and
   save.
3. On the bundle's **Manage form display**, configure the field's widget options —
   this is where you specify the color values editors are allowed to choose.
4. On **Manage display**, decide how the stored color appears. By default it renders
   as a small swatch; override `color-element.html.twig` in your theme for custom
   output.
5. Edit a piece of content and pick a color — it is stored on the entity and shown
   according to the display settings.
