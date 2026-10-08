<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: PHPWord (document_loader_phpword) — agent index

A plugin for the **`document_loader`** framework that extracts the content of **Word and RTF
documents** via the **`phpoffice/phpword`** library and returns it as plain **text**, **html**, or
**markdown**. All parsing is delegated to PHPWord; this module adds the Drupal plugin glue plus a
hand-written PHPWord-to-Markdown converter.

- Package `Web services`. Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.x
  (installed 1.0.0). Security advisory: **covered**.
- Requires module `document_loader:document_loader` (`^2.0`) and Composer library
  `phpoffice/phpword:^1.4`.
- **No routes, no permissions, no config schema, no `*.install`, no `*.services.yml`, no Drush
  commands.** The `.info.yml` `configure:` key points at the parent module's form
  (`document_loader.settings_form`, `admin/config/media/document-loader`); there is no settings form
  in this module.

## Solution docs

- **The PHPWord loader plugin, the RTF type/input, output formats, options, and the Markdown
  converter** → [plugins/phpword-loader.md](plugins/phpword-loader.md)

## What it actually provides (from source)

- `DocumentLoader` plugin **`document_loader_phpword:phpword`** —
  `src/Plugin/DocumentLoader/PhpWordLoader.php`, a `final` class extending
  `Drupal\document_loader\Plugin\DocumentLoaderBase`, using `DocumentTraversalTrait`. Attribute:
  `document_loader_types: ['document_loader_type:word', 'document_loader_type:rtf']`,
  `output_types: ['text', 'html', 'markdown']`. `load()` accepts a `WordInput` or `RtfInput`.
- `DocumentLoaderType` plugin **`document_loader_type:rtf`** —
  `src/Plugin/DocumentLoaderType/RtfType.php` (extends `DocumentLoaderTypeBase`,
  `input_class: RtfInput::class`). It does **not** define a new plugin *type*; it registers an
  instance of the framework's existing `DocumentLoaderType`. The `word` type is provided by the
  parent module.
- Input value object **`RtfInput`** — `src/DocumentLoaderType/Input/RtfInput.php`, extends the
  framework's `FileInput`; `getSupportedExtensions()` returns `['rtf']`.
- `PhpWordToMarkdown` — `src/PhpWordToMarkdown.php`, a `final` converter class (also uses
  `DocumentTraversalTrait`).
- `DocumentTraversalTrait` — `src/DocumentTraversalTrait.php`, shared header/footer/body ordering
  helpers used by both the loader and the Markdown converter.

## Key facts (from source)

- Reader is chosen from the file **extension**, not content: `docx→Word2007`, `doc→MsDoc`,
  `odt→ODText`, `rtf→RTF`, default `Word2007` (`PhpWordLoader::READERS`).
- Output selection is a `match` on `$output_format`: `text` → `TextOutput`, `html` → `HtmlOutput`,
  `markdown` → `MarkdownOutput`; anything else throws `DocumentLoaderException`.
- One per-load option, `header_and_footer` (boolean, default FALSE), from
  `getLoaderOptionsSchema()`; when TRUE the first header and last footer are included.
- Document properties (title/subject/creator/company/created/modified/…) are returned as the
  output object's metadata (`extractMetadata()`).
- RTF is best-effort: PHPWord's RTF reader drops headings/lists and may lose special characters
  (noted in the class docblock and README).
