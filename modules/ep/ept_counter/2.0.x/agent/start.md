<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Counter (ept_counter) — agent index

Ships two Paragraphs bundles for animated count-up statistic blocks. Version **2.0.0**.
Core `^10.1 || ^11 || ^12`. Package "Extra Paragraph Types".

## Dependencies
- Modules: `ept_core` (^2.0), `paragraphs` (^1.0). Item icon field needs `media` with an
  `image` media type — `hook_requirements()` (in `ept_counter.install`) hard-errors on install
  if Media is enabled but no `image` media type exists.
- Composer/asset library: `levmyshkin/count-up.js` ^2.8 → served from `/libraries/count-up.js/dist/countUp.umd.js`.
- No permissions, no routes, no services beyond one hook class, no config schema of its own.

## What it provides
- **Paragraph bundles** (`config/install/paragraphs.paragraphs_type.*`):
  - `ept_counter` — container: `field_ept_title` (text_long), `field_ept_text` (text_long, WYSIWYG),
    `field_ept_settings` (ept_settings, widget `ept_settings_counter`), `field_ept_counter_items`
    (entity_reference_revisions → `ept_counter_item`).
  - `ept_counter_item` — `field_ept_counter_number` (integer, required, min 1),
    `field_ept_counter_title` (text_long, required), `field_ept_counter_description` (text_long),
    `field_ept_counter_icon` (entity_reference → media `image`).
- **Field widget plugin** `ept_settings_counter` (`EptSettingsCounterWidget`) — extends
  `ept_core`'s `EptSettingsDefaultWidget`; adds the column-style radios and all CountUp options.
- **Hook class** `Drupal\ept_counter\Hook\EptCounterHooks` (autowired service): `help`, `theme`,
  `theme_registry_alter`; plus procedural `hook_theme_suggestions_field_alter` in `.module`.
- **Templates** (`templates/`): `paragraph--ept-counter--default`, `paragraph--ept-counter-item--default`,
  `field--paragraph--ept-counter--field-ept-counter-number`.
- **Library** `ept_counter/countup` (`js/countup.js` + `css/countup.css`) — the `Drupal.behaviors.eptCounter`
  behavior that instantiates `countUp.CountUp` per item.

## Solution docs
- [Paragraph bundles & fields](fields/paragraph-types.md)
- [Counter settings, CountUp options & rendering](config/counter-settings.md)
