<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "CountUp" field formatter

## Install & enable

```bash
composer require drupal/countup_formatter
drush en countup_formatter -y
```

No module dependencies, no sub-modules, no permissions, no Drush commands, no config schema.

### Install the countUp.js library (required for the animation)

The formatter attaches library `countup_formatter/countup`, whose dependency `countup-lib` loads
**`/libraries/countup.js/dist/countUp.umd.js`** — a **local** path, not a CDN. You must place the
library there yourself. Two options (README / `composer.libraries.json`):

- **composer-merge-plugin**: add the `inorganik/countup-js` (2.4.2) package repository and
  `web/modules/contrib/*/composer.libraries.json` to `extra.merge-plugin.include`, then
  `composer update -W`. The lib lands in `web/libraries/countup.js/`.
- **Manual**: download countUp.js 2.4.2+ from GitHub, unpack so that
  `web/libraries/countup.js/dist/countUp.umd.js` exists, then `drush cr`.

If the file is absent, `js/countup.js` guards on `typeof countUp.CountUp !== 'function'` and returns
early — the field still shows the plain formatted number, just without animation.

## Enable it on a field

Plugin id **`countup_formatter_countupformatter`**, label *"CountUp"*, applies to
`field_types = { "integer", "decimal", "float" }` (from the `@FieldFormatter` annotation in
`CountUpFormatter.php`). It does **not** apply to string, list, or other field types.

UI: *Structure → (bundle) → Manage display* → set the numeric field's format to **CountUp** →
click the gear to set the options below. Also selectable as a Views field format.

Drush / config equivalent:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_visitors.type countup_formatter_countupformatter -y
drush cr
```

## Formatter settings

From `defaultSettings()` in `CountUpFormatter.php` (on top of core `NumericFormatterBase`):

| Setting key | Default | Meaning |
|---|---|---|
| `thousand_separator` | `''` | Group separator passed to `number_format`; when non-empty, also sets `data-useGrouping=TRUE`. Inherited field from the numeric base form. |
| `decimal_separator` | `'.'` | Select: *Decimal point* (`.`) or *Comma* (`,`). Marker passed to `number_format` and `data-decimal`. |
| `scale` | `2` | Number input 0–10: digits to the right of the decimal (`number_format` + `data-decimalPlaces`). |
| `prefix_suffix` | `TRUE` | Whether the field's own prefix/suffix (field settings) are applied as `#field_prefix`/`#field_suffix` with pluralization. Inherited from base. |
| `start_val` | `0` | **Required** number the animation counts up from (`data-startVal`). |
| `duration` | `2` | Number (step 0.1) — animation length in **seconds** (`data-duration`). |
| `prefix` | `''` | Textfield: string prefixed to the value (e.g. `$ `, `&euro; `). Emitted as `data-prefix`. |
| `suffix` | `''` | Textfield: string suffixed to the value (e.g. ` m`, ` kb/s`). Emitted as `data-suffix`. |

Note on the source: `settingsForm()` builds the decimal/scale/start/duration inputs into the
returned `$elements` array, but the **prefix/suffix** inputs are (in 1.0.1) assigned to a stray
local `$element[...]` variable that is not returned — so the *Prefix*/*Suffix* text fields do not
appear on the settings form, though the stored `prefix`/`suffix` settings (defaults `''`) are still
read by `viewElements()` and written into `data-prefix`/`data-suffix`. Set them via exported config
if you need non-empty values.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_visitors:
    type: countup_formatter_countupformatter
    label: above
    settings:
      thousand_separator: ','
      decimal_separator: '.'
      scale: 0
      prefix_suffix: true
      start_val: 0
      duration: 2.5
      prefix: ''
      suffix: '+'
```

## How an item is rendered

`viewElements()` (in `CountUpFormatter.php`) for each field item:

1. `$output = $this->numberFormat($item->value)` →
   `number_format($number, scale, decimal_separator, thousand_separator)`.
2. If `prefix_suffix` is on, it derives `#field_prefix`/`#field_suffix` from the **field** settings
   `prefix`/`suffix` (split on `|` for singular|plural, `formatPlural()` by the value), each wrapped
   in **`Drupal\Core\Field\FieldFilteredMarkup`** (core's restricted-markup filter).
3. Adds a `content` attribute with the raw value when the displayed text differs from the raw value.
4. Builds the element:

```php
$elements[$delta] = [
  '#markup' => $output,                 // the formatted numeric string
  '#field_prefix' => ...,               // FieldFilteredMarkup or ''
  '#field_suffix' => ...,
  '#attributes' => [
    'class' => ['countup-formatter'],
    'data-enableScrollSpy' => TRUE,
    'data-startVal'   => start_val,
    'data-endVal'     => $output,
    'data-duration'   => duration,
    'data-prefix'     => prefix,
    'data-suffix'     => suffix,
    'data-decimal'    => decimal_separator,
    'data-separator'  => thousand_separator,
    'data-useGrouping'=> thousand_separator ? TRUE : FALSE,
    'data-decimalPlaces' => scale,
  ],
  '#attached' => ['library' => ['countup_formatter/countup']],
];
```

## The JavaScript behavior

`js/countup.js` defines `Drupal.behaviors.countupformatter`:

- `attach()`: once per page (`$('body').once('countup')`) binds
  `DOMContentLoaded load resize scroll` on `window`, wrapped in `core/drupal.debounce` at 50ms.
- `checkVisibility()`: selects `.countup-formatter:not(.countup-processed)`, and for each element
  fully inside the viewport (`getBoundingClientRect()` bounds check, visible, opacity > 0) adds
  class `countup-processed` (so it animates only once) and calls `countup(element)`.
- `countup(element)`: returns early if `countUp.CountUp` is not a function (library missing);
  merges `$element.data()` (all the `data-*` values) into options; if `end` is undefined it uses
  the element's numeric HTML; then `new countUp.CountUp(element, end, options)` and `.start()`,
  logging `count.error` to the console on failure.

Library map (`countup_formatter.libraries.yml`):

- `countup` → `js/countup.js`, deps `core/jquery`, `core/jquery.once`, `core/drupal`,
  `core/drupal.debounce`, and `countup_formatter/countup-lib`.
- `countup-lib` → local `/libraries/countup.js/dist/countUp.umd.js` (countUp.js 2.0.6+ per the
  `version`/`remote` metadata; README requires 2.4.2+). The `remote:` key is source metadata only —
  nothing is fetched from GitHub at runtime.

## Gotchas

- **Library not bundled** — without `/libraries/countup.js/dist/countUp.umd.js` there is no
  animation (plain number renders).
- Depends on `core/jquery.once` (jQuery Once), which is deprecated in favor of `core/once` in
  modern core; still shipped but may warn on future core.
- The prefix/suffix formatter text fields aren't rendered by `settingsForm()` in 1.0.1 (see note
  above) — configure them via exported config if needed.
- Animation fires only when the element is **fully** within the viewport; tall elements that never
  fit entirely on screen may not trigger.
