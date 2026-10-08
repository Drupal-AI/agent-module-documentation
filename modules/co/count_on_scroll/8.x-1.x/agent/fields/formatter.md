<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Count on Scroll" formatter

## Install & enable

```bash
composer require drupal/count_on_scroll
drush en count_on_scroll -y
```

No composer requirements beyond Drupal core, no sub-modules, no permissions, no Drush commands.

## Enable it on a field

The formatter (plugin id **`count_on_scroll_formatter`**, label *"Count on Scroll"*) applies to
**core integer fields only** (`field_types = { integer }` in the `@FieldFormatter` annotation on
`CountOnScrollFormatter.php`). It does not apply to decimal, float, string, or any other field type.

UI path: create/choose a **Number (integer)** field on a bundle, then
*Structure → (bundle) → Manage display* → set that field's format to **Count on Scroll** → click the
gear to set the duration below.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_count.type count_on_scroll_formatter -y
drush cr
```

## The one setting

From `defaultSettings()` in `CountOnScrollFormatter.php`:

| Setting key | Default | Meaning |
|---|---|---|
| `duration` | `'6000'` | Total animation length in **milliseconds** (`#type => 'number'` in the settings form). Passed to jQuery `.animate()` via `parseInt()`. |

`settingsForm()` starts from the parent `NumericFormatterBase` form and **removes** the inherited
`thousand_separator` and `prefix_suffix` controls, leaving only the `duration` number field
(weight 50). `settingsSummary()` shows `Duration: @duration`, or `Duration: Default` when empty.

Config schema: `field.formatter.settings.count_on_scroll_formatter` (mapping with a single string
`duration`), in `config/schema/count_on_scroll.schema.yml`.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_count:
    type: count_on_scroll_formatter
    label: above
    settings:
      duration: '6000'
```

## How it renders

`viewElements()` calls the parent to build the numeric elements, then for each delta:

1. Reads the parent-formatted number from `#markup` and wraps it in
   `<span class="counter" data-count="{number}">` via `#prefix` / `#suffix`.
2. Sets the visible `#markup` to `0` (so the number starts at zero before JS runs).
3. Attaches library `count_on_scroll/count_on_scroll` and
   `drupalSettings.count_on_scroll.counter.duration = {duration}`.

`numberFormat()` is overridden to return the number unchanged (no grouping/prefix at the PHP level —
grouping is applied client-side by the JS). The value fed into `data-count` comes from the
**integer** field, so it is always a plain whole number.

## The JS behavior

`js/count_on_scroll.js` defines `Drupal.behaviors.count_on_scroll` (classic jQuery behavior, wrapped
`(function ($) { … }(jQuery))`):

- Reads `drupalSettings.count_on_scroll.counter.duration`.
- On `scroll`/`resize`/`load`, for each `.counter`: `testInView()` compares the element's offset to
  the viewport top/height; when in view it adds class `inview`, then `counting`, then runs
  `startCount()`.
- `startCount()` animates `data-count` from the element's current text up to the target with jQuery
  `.animate()` (`easing: 'swing'`), writing `Math.floor(this.countNum).toLocaleString('en')` on each
  step and on complete (this is where thousands grouping like `1,240` comes from).
- Once every `.counter` is `counting`, it unbinds the `scroll resize load` handler.

## Gotchas

- **Integer fields only** — the formatter will not appear for float/decimal/string number fields.
- **jQuery required** — the behavior uses the global `$`, but the library declares only
  `core/drupalSettings` as a dependency. On themes/pages where core jQuery is present this is fine;
  it is not loaded on its own.
- The initial rendered value is `0`; if JS is disabled the number stays at `0` rather than showing
  the real value (the real value lives in `data-count`).
- Duration is a per-view-display setting — there is no site-wide config form or route.
