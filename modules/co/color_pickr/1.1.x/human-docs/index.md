# Color pickr — manual setup guide

**Color pickr** (`color_pickr`) adds a dedicated **color field** to Drupal, with
a graphical color-picker widget and several ways to display the chosen color. It
lets editors pick a color from a swatch/hue interface instead of typing a hex
code, and it lets site builders show that color as plain text or as a shaped
swatch (square, circle, hexagon, or line).

Under the hood it provides one field type, `color_pickr_code`, that stores a
single color string per value. Its widget bundles the
[Pickr](https://github.com/Simonwep/pickr) JavaScript library to render an
interactive swatch/hex/rgba/hsla/cmyk picker; saving writes a HEXA value like
`#3F51B5CC` back into the field (clearing stores the literal `none`). Five
formatters share the field type: one prints the raw color string, and four render
a colored shape.

There is **no global settings page**, no permissions, no config schema, and no
dependencies beyond Drupal core. Everything is chosen **per field** on the
**Manage form display** and **Manage display** tabs — you add a Color pickr field
to any fieldable entity, pick the widget's skin, and pick a display shape.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated page. You use it through the standard field UI: **Manage
fields**, **Manage form display**, and **Manage display** on any content type,
taxonomy vocabulary, or other fieldable entity (for example
`/admin/structure/types/manage/article/fields`).

## How to use it

### 1. Add a Color pickr field

On an entity's **Manage fields** tab, add a new field and choose the **Color
pickr** field type. Give it a label and save. (It stores a single color string
per value; you can make it multi-value like any other field if you want a list of
colors.)

### 2. Choose the widget and its settings (Manage form display)

On **Manage form display**, the field uses the **Color pickr** widget. It renders
a read-only text box plus a swatch button that opens the Pickr color picker. The
widget has two settings:

- **Theme** — the Pickr skin: **Classic** *(default)*, **Monolith**, or **Nano**.
- **Hide description** — when on, hides the raw text input so editors only see the
  swatch button.

When an editor saves a color, the picker writes a HEXA string (with alpha), e.g.
`#3F51B5CC`; using the picker's *clear* action stores `none`.

### 3. Choose how the color displays (Manage display)

On **Manage display**, pick one of the five formatters for the field:

- **Color pickr default** — prints the stored color string as text.
- **Color pickr square** — a small square swatch filled with the color.
- **Color pickr circle** — a circular swatch.
- **Color pickr hexagon** — a hexagon swatch.
- **Color pickr line** — a horizontal line/bar in the color.

Every shape formatter automatically renders **nothing** when the value is empty or
`none`, so unfilled fields stay clean.

### Theming (optional)

Each shape has its own Twig template (`color-pickr-square.html.twig`, and so on)
and a theme hook, so you can override the markup or size in your own theme — copy
the template into your theme and adjust it, or use
`hook_theme_suggestions_*_alter()` / `hook_preprocess_HOOK()`. The color value is
emitted into a `style="background-color: …"` attribute and Twig auto-escapes it in
HTML context; if you ever output the value in a JS or CSS context yourself,
sanitize it.
