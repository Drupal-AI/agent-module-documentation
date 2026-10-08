<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePub Generator: Markdown (epub_generator_markdown) — agent index

Converts uploaded **Markdown** (`.md`) files to **ePub** via `league/commonmark`. Package `Content`,
core `^11.1`. Depends on `epub_generator` and `file`; requires the `league/commonmark` Composer
package (`^2.0`). License GPL-2.0-or-later. Version 1.0.x.

- **Converter service, download controller, field formatter** →
  [api/converter.md](api/converter.md)

## What it is (from source)

- **Service `epub_generator_markdown.converter`** = `MarkdownEpubConverter`
  (`src/MarkdownEpubConverter.php`): parses Markdown (optional YAML front matter + `#`/`##` chapter
  split) and calls `epub_generator.generator`. Public API: `convert()`, `convertToResponse()`,
  `convertFile()`, `convertFileToResponse()`, `parse()`.
- **Formatter `markdown_epub_download`** (`src/Plugin/Field/FieldFormatter/MarkdownEpubFormatter.php`,
  `field_types = {file}`): renders the file link plus a **Download as ePub** link for `.md`/`.markdown`
  files; per-instance layout settings (reflowable / fixed-layout viewport, spread, orientation).
- **`MarkdownEpubController`** (`src/Controller/MarkdownEpubController.php`) — the download route.
- **Hooks** in `src/Hook/EpubGeneratorMarkdownHooks.php` (`hook_help`).

## Route (`epub_generator_markdown.routing.yml`)

- `epub_generator_markdown.download` —
  `/epub/markdown-download/{entity_type}/{entity_id}/{field_name}/{delta}` →
  `MarkdownEpubController::download` (perm `generate epub`). Loads the entity, checks
  `$entity->access('view')`, resolves the file in the given field/delta, requires a `.md`/`.markdown`
  extension, and converts it. Fixed-layout is passed as `?layout=pre-paginated&vw=&vh=&spread=&orientation=`.

## Conversion mechanism

- `parse()` → `extractFrontMatter()` (YAML between `---` fences, decoded with core `Yaml::decode`) →
  `splitIntoChapters()` (H1 = chapter, H2 = sub-chapter, pre-heading content = "Preface", tracks
  fenced code blocks) → per-chapter `markdownConverter->convert()`.
- CommonMark `Environment` built with CommonMark core + GitHub-Flavored extensions and
  `html_input => allow`; the resulting chapter HTML is sanitized downstream by the base
  `HtmlToXhtmlSanitizer` before embedding in the ePub.
- `buildMetadata()` maps front-matter keys (`title`, `author`/`authors`, `publisher`, `isbn`,
  `edition`, `subtitle`, `description`, `rights`/`copyright`, `language`, `date`, `subjects`/`tags`,
  layout keys) to `EpubMetadata`.

## Config / permissions

- No settings form and no own permissions (download uses the base `generate epub` permission).
- Config schema `field.formatter.settings.markdown_epub_download` (`config/schema/`).
- `hook_requirements` (`.install`) errors when `league/commonmark` is missing.
