<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Counter settings widget & CountUp.js pipeline

## Widget plugin

`src/Plugin/Field/FieldWidget/EbtSettingsCounterWidget.php` — `@FieldWidget(id = "ebt_settings_counter", field_types = {"ebt_settings"})`, extends `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`. Used by `field_ebt_settings` on the `ebt_counter` block form (set in the block's default form display).

`formElement()` calls the parent (which provides the shared EBT design options) then appends:

- Hidden `pass_options_to_javascript` = TRUE — signals ebt_core to serialize these settings into `drupalSettings.ebtCounter[<id>].options`.
- `styles` (radios) — `two_columns` / `three_columns` / `four_columns`; default `four_columns`. Drives the `ebt-counter-<styles>` CSS class.

CountUp.js options (see https://github.com/inorganik/CountUp.js), each stored under `ebt_settings`:

| Key | #type | Default | Meaning |
|---|---|---|---|
| `startVal` | number | 0 | number to start at |
| `prefix` | textfield | '' | text prepended to result |
| `suffix` | textfield | '' | text appended to result |
| `decimalPlaces` | number | 0 | decimal places |
| `duration` | number | 2 | animation seconds |
| `useGrouping` | checkbox | 1 | 1,000 vs 1000 |
| `separator` | radios | comma | comma / dot / dash grouping separator |
| `useEasing` | checkbox | 1 | ease animation |
| `smartEasingThreshold` | number | 999 | smooth easing above this |
| `smartEasingAmount` | number | 333 | amount eased above threshold |
| `enableScrollSpy` | checkbox | 1 | start when in view |
| `scrollSpyDelay` | number | 0 | delay (ms) after in view |
| `scrollSpyOnce` | checkbox | 0 | run only once |

`massageFormValues()` ensures each value has an `ebt_settings` key.

## JS pipeline (`js/countup.js`)

Behavior `Drupal.behaviors.ebtCounter`:

1. `once('counter-block', '.ebt-block-counter', context)` selects each counter block.
2. `getEbtCounterOptions(id)` reads `drupalSettings.ebtCounter[id].options`, deletes `design_options` and `pass_options_to_javascript`, maps `separator` (`comma`→`,`, `dot`→`.`, `dash`→`-`), casts numeric options with `parseInt`, coerces booleans, and passes `prefix`, `suffix`, `startVal`, `smartEasingAmount`, `smartEasingThreshold` through `Drupal.checkPlain()` (HTML-escaped).
3. For each `.ebt-counter-number` (once `'countup'`): `new countUp.CountUp(div.id, div.textContent, options)` then `.start()`. The animated end value is taken from the element's existing `textContent` (the rendered integer field).

## Library

`ebt_counter.libraries.yml` → `countup`: loads `/libraries/count-up.js/dist/countUp.umd.js` (external `levmyshkin/count-up.js` 2.8, MIT) + `js/countup.js` + `css/countup.css`; depends on `core/drupal`, `core/once`, `core/drupalSettings`. Attached from the block templates via `attach_library('ebt_counter/countup')`.

## Operating notes

- There is no admin settings page; all options live on the block instance under `field_ebt_settings`.
- The counter number itself comes from `field_ebt_counter_number` (integer field) rendered into the `.ebt-counter-number` element that CountUp targets by id.
