<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Picker - Examples (dsfr4drupal_picker_examples) — agent index

Code-only example submodule of DSFR for Drupal - Picker. It demonstrates every extension point of the picker's hook API by adding/removing icon and pictogram groups and by wiring a custom stylesheet and pictogram path. It installs no fields, config or content.

- Machine name: `dsfr4drupal_picker_examples`
- Dependencies: `dsfr4drupal_picker` (parent).
- Core: `^10.3 || ^11 || ^12`. License: GPL-2.0-or-later. No permissions, routes, services (other than the autowired hook class), or config.

## What it provides
- Hook class `Drupal\dsfr4drupal_picker_examples\Hook\Dsfr4drupalPickerExamplesHooks` (autowired in `dsfr4drupal_picker_examples.services.yml`), invoked via `#[Hook]` attributes and mirrored by `#[LegacyHook]` shims in `dsfr4drupal_picker_examples.module`.
- A `css/icons.custom.css` stylesheet defining `example-icon-thumbsup` / `example-icon-thumbsdown` glyphs (and an `icons` library in `.libraries.yml`).
- Implements: `library_info_alter`, `dsfr4drupal_picker_icons`, `dsfr4drupal_picker_icons_alter`, `dsfr4drupal_picker_pictograms`, `dsfr4drupal_picker_pictograms_alter`, `dsfr4drupal_picker_pictogram_path_alter`.

## Solution docs
- [Hook examples](api/hooks.md) — each hook implementation and what it demonstrates.
