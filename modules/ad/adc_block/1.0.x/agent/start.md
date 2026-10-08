<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analog Digital Clock (adc_block) — agent index

Provides four real-time **clock Block plugins** (Canvas analog, CSS/HTML digital, and two SVG
variants) placed via the core Block system. Per-instance styling only — no content, no access role,
client-side time. Depends on core **`block`**. Core `^9 || ^10 || ^11`. Version 1.0.6.
License GPL-2.0-or-later. Package *Analog Digital Clock*.

- **The four block plugins, every setting group, timezone/date handling, templates, libraries and
  hooks** → [plugins/blocks.md](plugins/blocks.md)

## What it actually is (from source)

- **No** routing.yml, permissions.yml, services.yml, config/install, install file, or composer.json.
  `adc_block.module` implements only `hook_help()` and `hook_theme()` (four theme hooks:
  `analog_clock`, `digital_clock`, `svg_clock_analog_dynamic`, `svg_clock_digital_dynamic`).
- Config **schema only** (`config/schema/adc_block.schema.yml`) for the two legacy blocks'
  `block.block.*.settings.*` mappings; the SVG blocks store settings without a documented schema.
- Four `src/Plugin/Block/` classes, all extending `BlockBase`:
  - `AnalogClockBlock` (id **`adc_block_block`**, "Analog Clock") — Canvas; presets `layout1`–`layout10` + `custom`.
  - `DigitalClockBlock` (id **`adc_block_digital_block`**, "Digital Clock") — CSS/HTML; injects `date.formatter`, `entity_type.manager`, `datetime.time`.
  - `AnalogClockSvgBlock` (id **`svg_clock_analog_dynamic`**, "SVG Clock - Analog") — SVG.
  - `DigitalClockSvgBlock` (id **`svg_clock_digital_dynamic`**, "SVG Clock - Digital") — SVG.
- Three JS libraries in `adc_block.libraries.yml`: `adc_block.analog` (js/analog.js, Canvas),
  `adc_block.digital` (js/digital.js), `clocks` (js/clocks.js, both SVG blocks). All use core jQuery/Drupal.
- All four blocks return `getCacheMaxAge()` **0** (uncacheable — time is drawn client-side).

## Categories

Content display — admin-configured block presentation (client-side time). No content or access role.
