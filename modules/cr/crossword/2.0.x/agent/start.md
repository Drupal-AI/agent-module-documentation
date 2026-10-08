<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword (crossword) — agent index

Defines a **`crossword` field type** whose uploaded puzzle files are parsed server-side and rendered
as a **browser-playable** crossword (also as a static solution, an image, or a file). It does *not*
author puzzles — it consumes files made elsewhere. Package `Crossword`. Depends only on core **`file`**.
Core `^10.2 || ^11`. License GPL-2.0-or-later. Installed version 2.0.4. Composer lib
`masterminds/html5:^2.0` (used only for UTF-8 conversion).

## What it provides (main module, from source)

- **Field type** `crossword` (`CrosswordItem` extends core `FileItem`): default extensions
  `txt puz xml ipuz`; extra field settings `allowed_parsers`, `max/min_columns`, `max/min_rows`.
  Default widget `file_generic_crossword` (`CrosswordFileWidget` = thin `FileWidget`), default
  formatter `file_default_crossword`. Cardinality 1.
- **Formatters**: `crossword` ("Crossword Puzzle", playable), `crossword_solution` ("Crossword
  Solution", filled grid), `file_default_crossword` ("Generic file"). → [fields/formatters.md](fields/formatters.md)
- **Plugin type** `crossword_file_parser` (manager `crossword.manager.parser`, annotation
  `@CrosswordFileParser`, interface `CrosswordFileParserPluginInterface`). Four bundled parsers:
  `across_lite_text` (.txt), `across_lite_puz` (.puz), `crossword_compiler_xml` (.xml), `ipuz` (.ipuz).
- **Service** `crossword.data_service` (`CrosswordDataService`) — parse + cache + normalize + XSS-filter
  + `hook_crossword_data_alter`. Cache bin service `cache.crossword`. → [api/data-service.md](api/data-service.md)
- **Validation constraints** on the field: `CrosswordFile` (file parseable?) and `CrosswordDimensions`
  (grid within row/column limits). → [fields/field-type.md](fields/field-type.md)
- **Block** `crossword_instructions` ("Crossword Instructions"). → [blocks/instructions.md](blocks/instructions.md)
- **Theme hooks** (`crossword.module` `hook_theme`): `crossword`, `crossword_controls`,
  `crossword_grid`, `crossword_grid_row`, `crossword_square`, `crossword_clue`, `crossword_clues`,
  `crossword_instructions`, `crossword_active_clues`, each with per-formatter / per-direction /
  pseudofield theme-suggestion alters. Twig templates under `templates/`.
- **Libraries** (`crossword.libraries.yml`): `crossword.default` (js/classes.js + js/crossword.js +
  CSS, jquery/once/drupal/drupalSettings), `crossword.grid`, `crossword.solution`, `crossword.print`,
  `crossword.instructions`, `crossword.crossword-icon`.
- **Config schema** only (`provides_config_schema: true`); **no permissions, no routes, no Drush,
  no `.install`** in the main module.
- **API hook**: `hook_crossword_data_alter(array &$data, FileInterface $file)` (`crossword.api.php`).

## Submodules (each documented in its own tree under `../modules/<name>/2.0.x/`)

- `crossword_image` — GD image generation, `crossword_image` plugin type, admin regenerate form,
  `crossword_image_rendered` formatter. Dep: core `image`.
- `crossword_media` — `crossword` media source (thumbnail via crossword_image). Deps: `crossword_image`, core `media`.
- `crossword_contest` — low-stakes contest: `crossword_contest` media type + formatter + AJAX
  answer-check controller. Deps: `crossword_media`.
- `crossword_pseudofields` — node/media pseudofields + global settings form. Deps: core `node`.
- `crossword_token` — file tokens (title/author/dimensions/image). Dep: contrib `token`.
- `crossword_download` — `crossword_file_download_link` + `crossword_image_download` formatters. Deps:
  `crossword_image`, `crossword_token`, contrib `file_download_link`.
- `crossword_colors` — admin form writing `public://crossword-colors.css`.
- `crossword_status` — client-side solved/in-progress classes on crossword fields.

## Notes for agents

- The playable formatter passes the full parsed `data` (including the solution) to `drupalSettings`
  **unless** its **Redact Solution** setting is on; the contest submodule forces redaction and checks
  answers server-side. All parsed strings are `Xss::filter`-ed in the data service before display.
- Supported-format detection is by MIME + filename substring + a magic marker in the file body (see
  each parser's `isApplicable()` in [api/data-service.md](api/data-service.md)).
