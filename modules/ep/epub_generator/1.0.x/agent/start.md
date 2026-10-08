<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePub Generator (epub_generator) — agent index

Generates **ePub 3** ebooks from rendered Drupal content in **pure PHP**, built on the
`andileco/php-epub` library (no wkhtmltopdf / headless browser). Package `Content`.
Core `^11.1`, PHP `>=8.3` with `ext-dom`, `ext-libxml`, `ext-zip`. License GPL-2.0-or-later.
Version 1.0.x (release 1.0.1). Configure at `epub_generator.settings`.

- **Generator service, value objects, HTML→XHTML sanitizer, CSS-selector translator** →
  [api/generator-service.md](api/generator-service.md)
- **Settings form + config, ePub view mode, routes, permissions, Drush** →
  [config/settings.md](config/settings.md)

## What it is (from source)

- **Service `epub_generator.generator`** = `EpubGeneratorService` (`src/EpubGeneratorService.php`):
  takes an `EpubMetadata` + ordered `EpubChapter[]` and writes a `.epub` to a unique temp dir;
  `generateDownloadResponse()` returns a `BinaryFileResponse` (`deleteFileAfterSend(TRUE)`).
- **Value objects**: `EpubMetadata` (`src/EpubMetadata.php`, Dublin Core / OPF fields, UUID id),
  `EpubChapter` (`src/EpubChapter.php`, immutable; `sanitizeId()` for filenames).
- **`epub_generator.html_sanitizer`** = `HtmlToXhtmlSanitizer` (`src/HtmlToXhtmlSanitizer.php`):
  DOM pass that strips disallowed elements (`script`, `iframe`, `form`, event handlers, …),
  Drupal chrome, and site/book "strip selectors"; keeps SVG/MathML; emits XHTML via `saveXML()`.
- **`CssSelectorToXpath`** (`src/CssSelectorToXpath.php`): translates a CSS-selector subset to
  XPath 1.0 for the strip-selectors feature (no runtime symfony/css-selector dependency).

## Routes / controllers

- `epub_generator.settings` — `/admin/config/content/epub-generator` (perm `administer epub generator`).
- `epub_generator.download` — `/epub/download/{entity_type}/{entity_id}` →
  `EpubDownloadController::download` (perm `generate epub`); single-entity, one-chapter ePub.
- `epub_generator.node_download` — `/node/{node}/epub-download` →
  `EpubNodeDownloadController::download` (perm `generate epub`); delegates to the Book assembler
  when the book submodule is on and the node is in a book, else single-node.
- Node local task **Download ePub** (`epub_generator.links.task.yml`).

## Permissions (`epub_generator.permissions.yml`)

- `generate epub` — generate/download ePub files from content.
- `administer epub generator` — change module settings (`restrict access: true`).

## Config / install

- Config object `epub_generator.settings` (schema in `config/schema/`, defaults in `config/install/`):
  `default_language`, `default_publisher`, `custom_stylesheet`, `enabled_bundles[]` (entity:bundle),
  `strip_selectors[]`, `default_layout`, `default_viewport_width/height`, `default_spread`,
  `default_orientation`.
- `hook_install()` creates the **`node.epub`** view mode; export uses it, falling back to `full`.
- Hooks in `src/Hook/EpubGeneratorHooks.php` (`hook_help`). Default stylesheet `assets/default.css`.

## Drush (`src/Drush/Commands/EpubGeneratorCommands.php`)

- `epub:generate <id>` (alias `epub-gen`) — `--entity-type`, `--output`, `--view-mode`.
- `epub:generate-book <nid>` (alias `epub-book`) — requires the `epub_generator_book` submodule.

## Submodules (own nested doc trees under `modules/`)

- **epub_generator_book** — Book outlines → multi-chapter ebooks; metadata field mapping.
- **epub_generator_markdown** — uploaded Markdown → ePub; `.md` field formatter.
- **epub_generator_viewer** — in-browser epub.js reader + generated-ePub response cache.
