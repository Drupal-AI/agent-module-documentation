<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Countdown (ept_countdown) — agent index

A Paragraphs bundle that renders an **animated FlipDown countdown** to a configured target date.
Part of the Extra Paragraph Types (EPT) family; a thin display module built on `ept_core`.
Package *Extra Paragraph Types*. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.x
(installed 2.0.0).

- **Install, the paragraph bundle, its fields, widget settings, template & JS** →
  [config/paragraph-type.md](config/paragraph-type.md)

## Dependencies

- `drupal:datetime` (core) — the target-date field type.
- `ept_core:ept_core` — base module: the `ept_settings` field type/widget/formatter, the shared
  design-options tab, and the `preprocess_paragraph` / `paragraph_view` hooks that emit CSS and
  `drupalSettings`.
- `paragraphs:paragraphs` — the Paragraphs entity system.
- Front-end library `levmyshkin/flipdown` (FlipDown.js) installed to `/libraries/flipdown`.

## What it actually provides (from source)

- **One Paragraphs type**: `ept_countdown` (`config/install/paragraphs.paragraphs_type.ept_countdown.yml`).
- **Fields** on the bundle: `field_ept_countdown_date` (core `datetime`, required — the target),
  `field_ept_title` (`text_long`), `field_ept_text` (`text_long`), and `field_ept_settings`
  (`ept_settings`, provided by ept_core). Storage/field configs in `config/install/`.
- **One field widget plugin**: `EptSettingsCountDownWidget` (id `ept_settings_countdown`), in
  `src/Plugin/Field/FieldWidget/EptSettingsCountDownWidget.php`, extending ept_core's
  `EptSettingsDefaultWidget`. Adds countdown-specific settings (color theme, style, per-unit
  headings) on top of the shared design options.
- **Template**: `templates/paragraph--ept-countdown--default.html.twig` (registered by ept_core's
  `hook_theme_registry_alter`).
- **Libraries** (`ept_countdown.libraries.yml`): `ept_countdown` (FlipDown CSS/JS + `js/ept_countdown.js`)
  and `new_year` (seasonal snow CSS). No `*.module`, `*.install`, `*.routing.yml`,
  `*.permissions.yml`, `*.services.yml`, Drush, or config schema of its own.

## Routes / permissions / services

None. Configuration is per-paragraph on the entity edit form, gated by the site's Paragraphs /
content-edit permissions. Site-wide EPT defaults (colors, breakpoints, container widths) live in
the separate `ept_core` module at `/admin/config/content/ept-core` (`ept_core.settings`).
