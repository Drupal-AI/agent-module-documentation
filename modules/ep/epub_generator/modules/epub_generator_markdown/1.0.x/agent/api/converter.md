<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdown converter, controller & formatter (epub_generator_markdown)

## `MarkdownEpubConverter` (service `epub_generator_markdown.converter`)

`src/MarkdownEpubConverter.php`. Constructor arg: `@epub_generator.generator`. Builds a
`League\CommonMark\MarkdownConverter` from an `Environment` with `html_input => 'allow'`, plus the
`CommonMarkCoreExtension` and `GithubFlavoredMarkdownExtension`.

Public methods:

- `convert(string $markdown, string $fallbackTitle = 'Untitled', array $options = []): string`
- `convertToResponse(...): BinaryFileResponse`
- `convertFile(string $filepath, array $options = []): string` / `convertFileToResponse(...)`
  — read the file (`file_get_contents`; throws `RuntimeException` on failure), filename stem as
  fallback title.
- `parse(string $markdown, string $fallbackTitle): array{metadata: EpubMetadata, chapters: EpubChapter[]}`

`$options` layout keys (applied over front matter by `applyLayoutOptions()`): `layout`,
`viewport_width`, `viewport_height`, `spread`, `orientation`.

Parsing steps:

- `extractFrontMatter()` — if the doc (after `ltrim`) starts with `---`, take the block up to the next
  `---`, decode with core `Yaml::decode()`; on decode failure the whole input is treated as content.
- `splitIntoChapters()` — line scan: `# ` starts an H1 chapter (`level 0`), `## ` starts an H2
  sub-chapter (`level 1`), content before the first heading becomes a **Preface**; fenced code blocks
  (```` ``` ````/`~~~`) are tracked so `#` lines inside them are not treated as headings.
- Each chapter's Markdown → HTML via `markdownConverter->convert()`; empty chapters dropped; if none,
  the whole content becomes one chapter. `buildMetadata()` maps front-matter keys to `EpubMetadata`
  (title precedence: front matter → first non-Preface H1 → fallback; `author`/`authors` accept string,
  comma list, or YAML list; `subjects`/`tags`; parsed `date`; layout keys).

Note: `html_input => allow` lets raw HTML in the Markdown pass into the chapter HTML, but every
chapter is then run through the base `HtmlToXhtmlSanitizer` inside `EpubGeneratorService::generate()`
(strips `script`/`iframe`/event handlers, etc.) before being written to the ePub.

## `MarkdownEpubController::download`

`src/Controller/MarkdownEpubController.php`. Route
`epub_generator_markdown.download` = `/epub/markdown-download/{entity_type}/{entity_id}/{field_name}/{delta}`
(perm `generate epub`; `delta` defaults to 0). Flow: reject unknown entity type → load entity →
require `FieldableEntityInterface` → check `$entity->access('view')` → require the field to exist and
hold a File at `$delta` → require `.md`/`.markdown` extension → resolve the file with
`file_system->realpath()` → read layout options from the query (`layout=pre-paginated`, `vw`, `vh`,
`spread`, `orientation`) → `converter->convertFileToResponse()`.

## `MarkdownEpubFormatter` (id `markdown_epub_download`)

`src/Plugin/Field/FieldFormatter/MarkdownEpubFormatter.php`, `FormatterBase`, `field_types = {file}`.
Settings (`defaultSettings`): `layout` (`reflowable`/`pre-paginated`), `viewport_width` (1024),
`viewport_height` (768), `spread` (`auto`), `orientation` (`auto`); the viewport/spread/orientation
inputs are `#states`-hidden unless layout is fixed. `viewElements()` renders the standard
`file_link`, and for `.md`/`.markdown` files wraps it in a container with a **Download as ePub** link
to `epub_generator_markdown.download`, carrying the fixed-layout settings as query parameters. Config
schema: `field.formatter.settings.markdown_epub_download` (`config/schema/`).

## Requirements

`hook_requirements` (`epub_generator_markdown.install`) fails install and reports a runtime error when
`League\CommonMark\MarkdownConverter` is not present (`composer require league/commonmark`).
