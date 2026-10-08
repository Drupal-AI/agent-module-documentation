<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adc_block — the four clock Block plugins

All in `src/Plugin/Block/`, all extend `Drupal\Core\Block\BlockBase`, all
`getCacheMaxAge()` return **0** (client-side time → never cached). Place via
**Structure → Block layout** (`/admin/structure/block`); no dedicated routes/permissions.

## Install / enable

```
composer require drupal/adc_block   # (no composer.json ships; download works too)
drush en adc_block
```
Requires core `block` (declared in `adc_block.info.yml`). No config/install, no settings route,
no permissions file — configuration is entirely per block instance.

## 1. AnalogClockBlock — id `adc_block_block` ("Analog Clock")

Canvas-based. `defaultConfiguration()`: `num_places` 5, `label_display` FALSE, `layout`
`layout1`, `timezone` `system_timezone`, `heading` '', `footer` ''.

- `buildConfigurationForm()` groups form values under `regional_settings`, `layout_settings`,
  `description_settings` (each `#tree`). `submitConfigurationForm()` flattens those three groups
  back into flat `$this->configuration[$key]`.
- Layout select offers `layout1`–`layout10` and `custom`. `getLayoutData()` returns a hardcoded
  preset array per layout (colors/widths/lengths as strings); the `custom` branch reads each
  value from config with `?? default`. Note: the select lists 10 layouts but the schema/README
  mention 7 — presets 1–10 all exist in `getLayoutData()`.
- `build()` resolves timezone (`system_timezone` → `date_default_timezone_get()`,
  `local_timezone` → '' meaning use the browser, else the literal tz id), **`Html::escape()`s**
  `heading`/`footer` into `#content`, JSON-encodes `layout_data` into `#data`, and attaches
  library `adc_block/adc_block.analog` plus `drupalSettings.layout_data`.
- Template `templates/analog-clock.html.twig`: prints `content.heading`/`content.footer` (Twig
  auto-escaped) and a `<canvas data-config="{{ data }}">`. `js/analog.js`
  (`Drupal.behaviors`) reads the JSON config and draws the clock to the canvas.

## 2. DigitalClockBlock — id `adc_block_digital_block` ("Digital Clock")

CSS/HTML. Implements `ContainerFactoryPluginInterface`; `create()` injects `date.formatter`,
`entity_type.manager`, `datetime.time`.

- Layout select: `layout1` (preset) or `custom`. `defaultConfiguration()` sets timezone,
  layout, `show_date` FALSE, `date_format` `medium`, `description_text` '', plus base colors.
- `build()` resolves timezone as above; when `show_date`, formats `time->getRequestTime()` via
  `dateFormatter->format(..., $format, $custom_format)` (`custom` uses `custom_date_format`,
  default `Y-m-d`). `getLayoutData()` **`Html::escape()`s** `description_text` into `base_data`,
  merges colors/font sizes/shadows, and returns it as `#data`; attaches
  `adc_block/adc_block.digital` + `drupalSettings.config_data`.
- The date-format select is built from `entity_type.manager->getStorage('date_format')
  ->loadMultiple()` plus a `custom` option.
- Template `templates/digital-clock.html.twig` builds inline `style="…"` strings by
  concatenating the color/size config values (Twig auto-escapes the attribute), prints
  `data.current_date`, and prints `data.description_text|raw` (the value was already
  `Html::escape()`d in PHP, so the `|raw` emits the pre-escaped text). `js/digital.js` updates
  `.adc_block-digitaltime` every second with the computed `HH:MM:SS AM/PM` string.

## 3. AnalogClockSvgBlock — id `svg_clock_analog_dynamic` ("SVG Clock - Analog")

Fully custom SVG, `category = "Analog Digital Clock"`. Large `blockForm()` with grouped
`details`: `dimensions`, `background` (solid/gradient), `border` (solid/rainbow), `numbers`
(arabic/roman/dots), `hour_markers`, `minute_markers`, `hour_hand`, `minute_hand`,
`second_hand`, `center_dot`, `effects` (glow/shadow), `timezone_settings`
(default/user/custom + `getTimezoneOptions()` from `\DateTimeZone::listIdentifiers()`).
`blockSubmit()` flattens all those groups into flat config.

- `build()` sets `#theme => 'svg_clock_analog_dynamic'`, a `#block_id` of
  `'analog-clock-' . uniqid()`, `#config => $config`, and attaches `adc_block/clocks`.
- Template `svg-clock-analog-dynamic.html.twig`: outputs `data-config="{{ config|json_encode|
  e('html_attr') }}"` on the wrapper and an empty `<svg>`. `js/clocks.js` reads/parses that JSON
  and **builds the SVG markup with `svg.innerHTML = svgContent`**, interpolating config color
  values into `stroke`/`fill` attributes.

## 4. DigitalClockSvgBlock — id `svg_clock_digital_dynamic` ("SVG Clock - Digital")

Fully custom SVG digital display, `category = "Analog Digital Clock"`. `blockForm()` groups:
`display` (12/24h, show seconds/date/day, date_format long/short/iso/custom + `custom_date_format`,
`day_format`), `background`, `border`, `colors`, `font` (family/sizes/spacing/weight), `padding`,
`text_shadow`, `box_shadow`, `timezone_settings`, `advanced` (text_align, uppercase).
`blockSubmit()` flattens all groups. `build()` → `#theme => 'svg_clock_digital_dynamic'`,
`#block_id` `'digital-clock-' . uniqid()`, `#config`, library `adc_block/clocks`. Template mirrors
#3 (`data-config` json-encoded, filled client-side by `js/clocks.js`).

## Theme hooks (`adc_block_theme()`)

`analog_clock` (vars `data`, `content`), `digital_clock` (var `data`),
`svg_clock_analog_dynamic` / `svg_clock_digital_dynamic` (vars `block_id`, `config`). Copy any of
the four `templates/*.html.twig` into a theme to override.

## Config schema

`config/schema/adc_block.schema.yml` defines `block.block.*.settings.adc_block_block` and
`block.block.*.settings.adc_block_digital_block` mappings (all the color/size/text keys). The two
SVG blocks are keyed `adc_block_svg_block` / `adc_block_digital_svg_block` in the schema with only
`num_places` mapped (the real SVG settings are stored without a matching schema entry).

## Hooks / API notes

- The README documents `hook_adc_block_layout_options_alter()`, but no `moduleHandler` alter
  invocation exists in source — the analog layout list is hardcoded in `buildConfigurationForm()`.
  Treat that alter hook as **not implemented** in 1.0.x.
- No Drush commands, no update hooks, no external HTTP, no database queries.
