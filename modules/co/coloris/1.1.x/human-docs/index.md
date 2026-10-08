# Coloris Widget — manual setup guide

**Coloris Widget** (`coloris`) adds a visual **color picker** to Drupal forms,
powered by the [Coloris](https://coloris.js.org/) JavaScript library. It gives you
a dedicated **Coloris Color** field type (plus a matching widget and formatter),
so editors can pick a color from a swatch/spectrum dialog instead of typing raw
hex codes. It's ideal for storing a brand or accent color per node, a personal
profile color, campaign or event colors, or design‑token content — on any
fieldable entity (content types, taxonomy terms, users, media, and so on).

The picker is highly configurable **per field**: you choose the picker style
(default, large, polaroid, or pill), a light/dark/auto theme, the output format
(HEX, RGB(A), HSL(A), auto, or "mixed"), whether the alpha/transparency channel is
allowed, a set of preset swatches, a swatches‑only mode that limits editors to an
approved palette, an inline (always‑visible) mode with a default color, and a
clear button. Whatever an editor enters is validated on the server — only proper
`#hex`, `rgb()/rgba()`, and `hsl()/hsla()` values are accepted.

The module works as soon as you enable it: there is **no global settings page**,
no permissions, and no Drush commands. It depends only on core's **Options**
module. You use it entirely through Drupal's Field UI — add a Coloris Color field
to a bundle and configure it there. Developers can also reuse the picker directly
in custom forms via a `coloriswidget` render element.

> **Note on the library source.** The Coloris CSS/JS is loaded from the jsDelivr
> **CDN pinned to `@latest`**, so the exact third‑party script version is not
> pinned by the module and can change over time. If you need a fixed version or
> want to avoid an external CDN, self‑host the asset by overriding the
> `element.coloris.lib` library with `hook_library_info_alter()` and pointing it
> at a local copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You work with Coloris through the standard
Field UI: add a **Coloris Color** field on any bundle's **Manage fields** tab, set
its options on the field settings form, and adjust its widget/formatter on **Manage
form display** / **Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the bundle you want (for example **Structure → Content types → *(type)* →
   Manage fields**), click **Add field**, and choose **Coloris Color**.
3. On the field's settings form, tune the picker. The main options are:
   - **Picker style** — *default*, *large*, *polaroid*, or *pill* thumbnail.
   - **Theme mode** — *light*, *dark*, or *auto* to match your admin theme.
   - **Output format** — *hex*, *rgb*, *hsl*, *auto*, or *mixed* (hex unless the
     color has transparency). Optionally show format‑toggle buttons in the dialog.
   - **Alpha** — allow a transparency channel; **force‑alpha** always writes an
     explicit alpha value.
   - **Swatches** — define a list of preset colors editors can pick from (added
     one at a time). Turn on **swatches‑only** to restrict editors to exactly
     those approved colors.
   - **Clear button** — show a reset button, with a custom label.
   - **Inline** — render the picker always‑visible rather than opening on focus,
     with an optional **default color** used on initialization.
   - Smaller options: the **margin** (gap between input and dialog) and whether to
     focus/select the value input when the dialog opens.
4. On **Manage form display**, the field uses the **Color selection**
   (`text_coloris`) widget; on **Manage display** it uses the **Coloris color**
   formatter, which outputs the stored value.

The stored value is a short color string (capped at 36 characters). Multi‑value
Coloris fields are supported, so you can store several swatches per entity.

### For developers: the reusable form element

To add a Coloris picker to a custom form without a field, use the `coloriswidget`
render element:

```php
$form['brand_color'] = [
  '#type' => 'coloriswidget',
  '#title' => $this->t('Brand color'),
  '#default_value' => '#ff8800',
  '#format' => 'hex',
  '#swatches' => ['#ff8800', '#0088ff'],
];
```

Its `#…` properties map to the same options as the field settings above, and it
applies the same server‑side color validation. See the
[`agent/`](../agent/start.md) API docs for the full property list.
