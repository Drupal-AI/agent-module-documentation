<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ept_counter — settings widget, CountUp options & rendering

There is **no admin settings form or route** for this module. All per-block options live on the
`field_ept_settings` field of each `ept_counter` paragraph, edited with the
`ept_settings_counter` widget.

## Widget `ept_settings_counter`
`src/Plugin/Field/FieldWidget/EptSettingsCounterWidget.php`, id `ept_settings_counter`,
field type `ept_settings`. Extends `Drupal\ept_core\Plugin\Field\FieldWidget\EptSettingsDefaultWidget`.
It does **not** override the parent constructor, so it inherits the current `ept_core` 2.0.x widget
signature (it instantiates cleanly on this site).

`formElement()` calls `parent::formElement()` (which supplies the shared `design_options` — CSS box,
backgrounds, container width, title options) and then adds:

- `pass_options_to_javascript` — hidden, forced `TRUE` (tells `ept_core` to emit this paragraph's
  options into `drupalSettings`).
- `styles` — radios `two_columns` / `three_columns` / `four_columns` (default `four_columns`);
  becomes the `ept-counter-<styles>` layout class in the template and drives the CSS grid in
  `css/countup.css`.
- CountUp.js option fields (defaults in parentheses): `startVal` (0), `prefix` (''), `suffix` (''),
  `decimalPlaces` (0), `duration` (2), `useGrouping` (1), `separator` (`comma`/`dot`/`dash`, default
  `comma`), `useEasing` (1), `smartEasingThreshold` (999), `smartEasingAmount` (333),
  `enableScrollSpy` (1), `scrollSpyDelay` (0), `scrollSpyOnce` (0).

`massageFormValues()` just ensures each value has an `ept_settings` key.

## How options reach the browser
1. `ept_core`'s `EptCoreHooks::paragraphView()` (hook_ENTITY_TYPE_view) emits, for each `ept_*`
   paragraph whose `pass_options_to_javascript` is not FALSE:
   `drupalSettings[<camelBundle>]['paragraph-id-<id>'] = { paragraphClass, options }`.
   For this bundle `<camelBundle>` = `eptCounter`.
2. `js/countup.js` (`Drupal.behaviors.eptCounter`): for each `.ept-paragraph-counter` element it
   reads `drupalSettings.eptCounter[<wrapper id>].options` via `getEptCounterOptions()`, maps
   `separator` (`comma`→`,`, `dot`→`.`, `dash`→`-`), coerces numeric/boolean fields, and runs
   `Drupal.checkPlain()` over the string options (`prefix`, `suffix`, `startVal`, `smartEasing*`).
3. For each `.ept-counter-number` inside the block it constructs
   `new countUp.CountUp(div.id, div.textContent, options)` and calls `.start()`. The end value is the
   integer already rendered into the div by the number field template.

## Design options / CSS
The shared `design_options` are turned into inline CSS by `ept_core`'s
`GenerateCSS::generateFromSettings()` (called from `EptCoreHooks::preprocessParagraph()`), exposed to
the template as `{{ styles }}`, and background media into `drupalSettings.eptCore`. Layout grid rules
(2/3/4 columns, responsive breakpoints) are in `css/countup.css` under the `.ept-counter-*` classes.

## Operate it
- Enable: `drush en ept_counter -y`. Ensure the CountUp asset library is present at
  `/libraries/count-up.js` (installed via `composer require levmyshkin/count-up.js` / the asset
  packagist entry) or the counters render as plain numbers with no animation.
- No config export beyond the installed paragraph types and field configs; no `config/schema/`
  is shipped by this module (the `ept_settings` schema comes from `ept_core`).
