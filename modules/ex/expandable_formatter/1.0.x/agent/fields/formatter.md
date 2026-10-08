<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Expandable" formatter

## Install & enable

```bash
composer require drupal/expandable_formatter
drush en expandable_formatter -y
```

Only dependency is core **`field`**. No sub-modules, no permissions, no Drush commands, no install
hooks, no site-wide settings form.

## Enable it on a field

Plugin id **`expandable_formatter`**, label *"Expandable"*
(`src/Plugin/Field/FieldFormatter/ExpandableFormatter.php`, extends core `FormatterBase`).
It applies to these `field_types` only:

- `text`, `text_long`, `text_with_summary` (formatted text fields)
- `string_long` (plain long text)

UI path: *Structure → (bundle) → Manage display* → set a supported field's format to **Expandable**
→ click the gear to set the options below. `settingsSummary()` shows trim height, effect, expand
label, and trigger class on the summary line.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.body.type expandable_formatter -y
drush cr
```

## Formatter settings

From `defaultSettings()`:

| Setting key | Default | Type | Meaning |
|---|---|---|---|
| `collapsed_height` | `20` | int (min 1) | Pixels of the field shown while collapsed. Required. |
| `use_ellipsis` | `TRUE` | bool | Append a `…` after the collapsed text. |
| `effect` | `slide` | select `none`/`slide` | `slide` animates height; `none` = instant show/hide. Required. |
| `trigger_expanded_label` | `Expand` | string | Trigger text shown while collapsed (click to expand). Required. |
| `trigger_collapsed_label` | `Collapse` | string | Trigger text shown while expanded (click to collapse). |
| `trigger_classes` | `button` | string | Space-separated CSS classes added to the trigger `<a>`. |
| `js_duration` | `500` | int (min 1) | Slide animation length in milliseconds. |

Config schema is `field.formatter.settings.expandable_formatter`
(`config/schema/expandable_formatter.schema.yml`); there is no `config/install`.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  body:
    type: expandable_formatter
    label: above
    settings:
      collapsed_height: 60
      use_ellipsis: true
      effect: slide
      trigger_expanded_label: 'Read more'
      trigger_collapsed_label: 'Read less'
      trigger_classes: 'button'
      js_duration: 400
```

## How a field item is rendered

`viewElements()` builds one render element per field item with `#theme => 'expandable_formatter'`.
Settings are passed to the front end as `data-*` attributes on the wrapper (`data-effect`,
`data-collapsed-height`, `data-collapsed-label`, `data-expanded-label`, `data-js-duration`), the
ellipsis flag as `#use_ellipsis`, and the trigger CSS classes as `#trigger_classes`. The library
`expandable_formatter/expand` is attached via `#attached`.

The field value itself is produced through Drupal's standard display pipeline:

- If the item has a text **format** (`text`, `text_long`, `text_with_summary`), the content is a
  `#type => 'processed_text'` element rendered with that field's assigned text format and langcode —
  the same rendering core's own text formatters use, so the format's filters/allowed tags apply.
- If the item has **no** format (e.g. `string_long`), the content is an `#type => 'inline_template'`
  rendering `{{ value|nl2br }}`, so plain-text input keeps its newlines as `<br>`.

The theme hook `expandable_formatter` is declared in `expandable_formatter_theme()` (the `.module`)
with variables `attributes`, `use_ellipsis`, `content`, `trigger_classes`. Template
`templates/expandable-formatter.html.twig` wraps the rendered content in
`.expandable-formatter--content`, optionally emits `.expandable-formatter--ellipsis`, and always
emits a `.expandable-formatter--trigger` link (initially labeled with the expand label).

## Client-side behavior

`css/expandable-formatter.css` hides the ellipsis and trigger by default and gives `.js-collapsed`
`overflow: hidden`. `js/expandable-formatter.js` (`Drupal.behaviors.expandableFormatter`, jQuery)
runs per `.expandable-formatter`:

1. Measures the content's natural `outerHeight`.
2. **Only if** that height exceeds `data-collapsed-height` does it show the ellipsis + trigger, add
   `.js-collapsed`, and clamp the content to the collapsed height. Short values render with no
   toggle at all.
3. On trigger click it toggles: with `effect === 'slide'` it `animate()`s the height (over
   `data-js-duration` ms) between the collapsed height and the measured full height; otherwise it
   just `show()`/`hide()`s. The trigger text swaps between the expanded/collapsed labels and the
   ellipsis is shown/hidden accordingly.

The collapse is purely presentational — height plus `overflow: hidden` — so the complete field
markup is always in the DOM; the module never cuts or re-splits the field's HTML.

## Notes / caveats

- No `.install`, no update hooks, no dependencies beyond core `field`; uninstalling just removes the
  formatter option (fields fall back to a default formatter).
- Because trimming is height-based, the same `collapsed_height` yields a consistent visual footprint
  regardless of content length — the module's stated design goal versus character-count trimming.
- Requires JavaScript: with JS disabled the CSS hides the trigger and the content renders at full
  height (no collapse), so content is never hidden without a way to reveal it.
- This is a dev checkout (`^1.0@dev`); `.info.yml` has no `version:` line — the `1.0.x` version-dir
  name is retained deliberately.
