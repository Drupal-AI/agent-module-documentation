# Color API — manual setup guide

**Color API** (`colorapi`) provides the concept of a "color" in Drupal. It gives
you low‑level color data types (hexadecimal and RGB), an optional **Color field**
for storing a human‑readable name plus a color value on content, matching display
formatters, and an optional **Color configuration entity** for maintaining a
central list of reusable named colors. It's part developer toolkit, part
site‑builder field.

Most sites use it for the Color field: add a "Brand color" or "Accent color" field
(name + hex) to a content type, and render it as a colored swatch, styled text, or a
raw hex/RGB string. Developers get more: Typed Data color types, a validation
constraint for hex strings, and a `colorapi.service` service with helpers like
`hexToRgb()` and `isValidHexadecimalColorString()`. If you enable the Color entity,
you can manage site‑wide named colors (theme colors) as exportable configuration.

Color API has a small settings form with **two feature switches**, described below.
It has no module dependencies and ships no submodules. It adds one permission,
**administer colors**. Note that for a real color‑picker editing experience you'll
want to also install the contrib **jQuery Colorpicker** module (`jquery_colorpicker`);
without it, the field's widget is plain text inputs for the name and hex value.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus optional jQuery Colorpicker for a picker widget).

## Where it lives in the admin menu

The settings live under **Configuration → Color** — the settings form is at
`/admin/config/color/settings` and (when enabled) the named‑color list is at
`/admin/config/color/colors`. Both are gated by the **administer colors**
permission.

## How to use it

### The two feature switches

Open **Configuration → Color → Settings** (`/admin/config/color/settings`). There
are two toggles:

- **Enable Color field** (on by default) — registers the `colorapi_color_field`
  field type so you can add color fields to content.
- **Enable Color entity** (off by default) — registers the `colorapi_color` config
  entity type and its management UI at `/admin/config/color/colors`, for reusable
  named colors.

Saving the form flushes caches so a change takes effect immediately. As a
safeguard, the form **won't let you disable the Color field while any color field
still exists**, nor **disable the Color entity while named colors still exist** — it
lists what you need to remove first.

### The Color field

With the Color field enabled, add a field of type **Color** to any content type
(Manage fields). Each value stores a **name** and a **color** (a `#RRGGBB` hex
string, 3‑ or 6‑digit); the RGB components are computed automatically on save. Four
display formatters are available on **Manage display**:

- **Color display** (default) — a colored block/square.
- **Text display** — the value as styled text.
- **Raw hex** — the raw hex string.
- **Raw RGB** — the raw RGB values.

The text and raw formatters add settings for whether to also print the color's
**name** (`display_name`) and, for hex/text, whether to prefix the hex with a **#**
(`show_hash`).

### Named colors (Color entity)

If you enable the Color entity, manage a central list of named colors at
**Configuration → Color → Colors** (`/admin/config/color/colors`) — add, edit, and
delete entries, each with an id, a label, and a hex color. Because they're
configuration entities, they export cleanly for deployment across environments and
can be shared by other modules.

### For developers

The `colorapi.service` service converts hex to RGB (`hexToRgb($hex, 'red'|'green'|'blue')`)
and validates hex strings (`isValidHexadecimalColorString()`), and the module
registers `hexadecimal_color` / `rgb_color` Typed Data types plus a
`HexColorConstraint`. See the [`agent/`](../agent/start.md) API docs for details.
