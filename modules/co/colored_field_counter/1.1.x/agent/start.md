<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colored Field Counter (colored_field_counter) — agent index

Field API **widget plugins** that render a live, colour-coded character counter under text and
link fields on the entity **edit form**. As an editor types, JavaScript counts the characters and
recolours the counter green → orange → red against per-field thresholds, and (for non-WYSIWYG
fields) sets a hard `#maxlength`. Package `Field`. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed **1.1.4** (version dir `1.1.x`). Maintainer: DrDam.

Pure edit-form enhancement: **no routes, controllers, services, permissions, hooks, config
schema, install/update hooks, or config entities.** Everything is field-widget settings stored in
the form-display config of whatever bundle uses the widget.

## Dependencies

None declared beyond Drupal core (`composer.json` requires only `drupal/core`). Widgets that target
formatted-text/link fields extend classes from core's `text` and `link` modules, so those must be
enabled for the corresponding field types to exist. JS libraries depend on `core/jquery` and
`core/drupalSettings`.

## What it provides (from source)

Two families of widget, 10 plugins total, each extending the matching core widget and mixing in a
trait. IDs are the `@FieldWidget` plugin ids.

**Simple family** — trait `BaseSimpleTrait`, JS library `colored_field_counter/simple-counter`
(`js/counter.js`). Settings: `char_reco` (recommended chars), `char_margin_min` %, `char_margin_max` %.

| Widget id | Class | Field types |
|-----------|-------|-------------|
| `simple_string_textfield` | `SimpleStringTextfieldWidget` (extends `StringTextfieldWidget`) | `string`, `text` |
| `simple_string_textarea` | `SimpleStringTextareaWidget` (extends `StringTextareaWidget`) | `string_long` |
| `simple_wysiwyg` | `SimpleWysiwygLongWidget` (extends `text` `TextareaWidget`) | `text_long` |
| `simple_wysiwyg_summary` | `SimpleWysiwygSummaryWidget` (extends `TextareaWithSummaryWidget`) | `text_with_summary` |
| `simple_link_title` | `SimpleLinkWidget` (extends `link` `LinkWidget`) | `link` (counts the title) |

**Complex ("cplx") family** — trait `BaseCplxTrait`, JS library `colored_field_counter/colored-counter-cplx`
(`js/counter-cplx.js`). Settings: `optimal_size` + a 3-row `color_settings` table (`color`, `low`, `max`).

| Widget id | Class | Field types |
|-----------|-------|-------------|
| `cplx_textfield` | `CplxStringWidget` (extends `StringTextfieldWidget`) | `string`, `text` |
| `cplx_textfield_long` | `CplxStringLongWidget` (extends `StringTextareaWidget`) | `string_long` |
| `cplx_wysiwyg` | `CplxWysiwygLongWidget` (extends `text` `TextareaWidget`) | `text_long` |
| `cplx_wysiwyg_summary` | `CplxWysiwygSummaryWidget` (extends `TextareaWithSummaryWidget`) | `text_with_summary` |
| `cplx_link_title` | `CplxLinkWidget` (extends `link` `LinkWidget`) | `link` (counts the title) |

## How it works (from source)

- Each widget's `formElement()` calls the trait's `makeAttachement(&$element)`, which appends a
  `#field_suffix` `<div class="counter" id="{uuid}">` holding `.incochars` / `.incooptim` /
  `.incoerror` spans, tags the input with class `counter` (or `wysiwyg-counter`), attaches the JS
  library, and passes per-counter thresholds in `drupalSettings` keyed by the counter's uuid
  (the field-config uuid for stored fields, else a freshly generated one).
- **Simple**: from `char_reco`/margins the trait computes `orange = reco·(100−min)/100`,
  `red = reco`, and a lock `#maxlength = reco·(100+max)/100`. JS (`counter.js`) recolours
  orange above `orange`, red above `red`.
- **Complex**: the 3-row table maps character ranges (absolute, or `NN%` of field max/optimal size)
  to colours. `low`/`max` support `%` values resolved against 255 (short) or `optimal_size` (long).
  JS (`counter-cplx.js`) picks the row whose `[low, max]` contains the current count.
- Both JS files count with `val().replace(/(<([^>]+)>)/gi,"").length` (strip tags) plus newline
  count, hook `keyup` on inputs/textareas, and support CKEditor 4 (`instanceReady`/`key`) and
  CKEditor 5 (`.ck-content` keyup). The count is written via jQuery `.text()`; colours are applied
  with `.css("color", …)` from the fixed keyword set red/orange/green/#333.

## Solution docs

- **Widget settings forms, threshold math, JS counter behaviour** →
  [config/widget-settings.md](config/widget-settings.md)
