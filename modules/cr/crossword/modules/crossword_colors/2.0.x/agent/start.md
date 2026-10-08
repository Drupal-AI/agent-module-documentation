<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Colors (crossword_colors) — agent index

Submodule of **crossword**. Admin UI to set crossword highlight/text colors; writes a generated CSS
file. Dep: `crossword:crossword`. Core `^10.2 || ^11`. GPL-2.0-or-later. `configure:
crossword_colors.settings`.

## Provides

- **Route/form** `crossword_colors.settings` → `/admin/config/crossword/colors`, `_permission:
  'configure crossword colors'`, form `CrosswordColorsConfigForm` (extends `ConfigFormBase`). Menu
  link `crossword_colors.links.menu.yml`.
- **Permission** `configure crossword colors`.
- **Service** `crossword_colors.service` = `CrosswordColorsService` (args `@file_system`,
  `@config.factory`).
- **Config** object `crossword_colors.settings` (schema `config_object`; install defaults in
  `config/install/`): `active_highlight` (`#88ccff`), `active_square` (`#1892ef`),
  `reference_highlight` (`#ccccff`), `reference_text` (`#8888cc`), `error_text` (`#aa0000`).
- **Hook** `crossword_colors_library_info_alter()` — appends the generated CSS URI to the base
  `crossword.default` library.

## Mechanism (source)

`CrosswordColorsService::saveCrosswordColorsCss()` reads each color, validates it with
`Drupal\Component\Utility\Color::validateHex()` (invalid values are skipped, not written), builds the
CSS rules and `fileSystem->saveData()`s them to `public://crossword-colors.css`
(`CrosswordColorsService::URI`). The form's `submitForm()` saves config, regenerates the CSS, then
clears `library.discovery`, `asset.css.collection_optimizer` and `asset.query_string` so changes are
visible immediately. The CSS file is (re)generated lazily by `getCrosswordColorsCssUri()` if missing.
