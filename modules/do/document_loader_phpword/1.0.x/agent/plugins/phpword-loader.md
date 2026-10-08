<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The PHPWord loader plugin

## Install & enable

```bash
composer require drupal/document_loader_phpword
drush en document_loader_phpword -y
```

Pulls in `phpoffice/phpword:^1.4` and requires `drupal/document_loader:^2.0`. There is no
configuration to do: the plugin auto-registers and appears in the Document Loader plugin list at
`admin/config/media/document-loader` (that route belongs to the parent `document_loader` module —
the `configure:` key in this module's `.info.yml` just points there).

## The loader plugin

`src/Plugin/DocumentLoader/PhpWordLoader.php` — `final class PhpWordLoader extends
DocumentLoaderBase`, attribute `#[DocumentLoader(...)]`:

- **id** `document_loader_phpword:phpword`, label *PHPWord*.
- **document_loader_types** `['document_loader_type:word', 'document_loader_type:rtf']` — the `word`
  type is provided by the framework; `rtf` is added by this module (below).
- **output_types** `['text', 'html', 'markdown']`.

`create()` injects only `file_system` (`Drupal\Core\File\FileSystemInterface`).

### `load(DocumentLoaderInputInterface $input, string $output_format = 'text'): DocumentLoaderOutputInterface`

1. Rejects anything that is not a `WordInput` or `RtfInput` (`\InvalidArgumentException`).
2. Takes the file URI from `$input->getContent()`.
3. Picks the PHPWord reader from the **lowercased file extension** via the `READERS` map
   (`docx→Word2007`, `doc→MsDoc`, `odt→ODText`, `rtf→RTF`); unknown extensions fall back to
   `Word2007` (PHPWord does not auto-detect).
4. Reads its own option(s) from `$input->getOptions()` (when the method exists) via
   `extractOwnOptions()` — here just `header_and_footer`.
5. Parses to a `PhpOffice\PhpWord\PhpWord` object (`parse()`), extracts metadata, and returns via a
   `match ($output_format)`:
   - `text` → `TextOutput(extractText(...), $metadata)`
   - `html` → `HtmlOutput(toHtml(...), $metadata)`
   - `markdown` → `MarkdownOutput((new PhpWordToMarkdown())->convert(...), $metadata)`
   - default → throws `DocumentLoaderException` ("Unsupported output format …").

### Options schema

`getLoaderOptionsSchema()` returns one option:

| Key | Type | Default | Effect |
|---|---|---|---|
| `header_and_footer` | boolean | `FALSE` | When TRUE, prepend the document's **first header** and append its **last footer** to the output (text and markdown paths). |

### File resolution (`parse()` / `resolveLocalPath()`)

PHPWord's readers need a real local path.

- `resolveLocalPath()`: if the URI has a scheme (`preg_match('#^[a-zA-Z0-9+.\-]+://#', …)`), it is
  resolved with `file_system->realpath()` and returned only when the result is a readable local
  path; otherwise a plain path is returned when `is_readable()`. Remote wrappers (e.g. `s3://`)
  return NULL.
- When a local path is available, `IOFactory::load($localPath, $reader)` is called directly.
- Otherwise the bytes are read with `@file_get_contents($fileUri)` (honouring stream wrappers),
  written to a `tempnam()` file in `file_system->getTempDirectory()` (fallback
  `sys_get_temp_dir()`), parsed, then the temp file is `unlink()`ed in a `finally`.
- Parse failures throw `DocumentLoaderValidationException` ("Failed to parse the given document.");
  read/temp-file failures throw `DocumentLoaderException`.
- Note: the fallback path holds the whole document in memory. The code comments that callers are
  expected to enforce upload size limits upstream (Drupal file validation).

## The RTF document type & input

- `src/Plugin/DocumentLoaderType/RtfType.php` — `#[DocumentLoaderType(id:
  'document_loader_type:rtf', label: 'RTF', input_class: RtfInput::class)]`, extends
  `DocumentLoaderTypeBase` (empty body). This registers the RTF type so the framework knows RTF is a
  valid input kind and which input class carries it.
- `src/DocumentLoaderType/Input/RtfInput.php` — extends the framework's `FileInput`;
  `getSupportedExtensions()` → `['rtf']`.

The `word` type and its `WordInput` come from the parent `document_loader` module.

## Text extraction

`extractText()` + `extractBlockText()` + `inlineText()` (in `PhpWordLoader`):

- Iterates the ordered element groups (`DocumentTraversalTrait::orderedElementGroups()`), so body
  sections come out in document order, optionally wrapped by the first header / last footer.
- Each block element (paragraph, heading, list item) becomes one line; a `Table` becomes one line
  per row with **tab-separated** cells; `TextBreak` becomes a newline; `AbstractContainer`
  descendants are concatenated. Empty lines are dropped. Lines are joined with `\n`.

## HTML extraction

`toHtml()` runs PHPWord's `Writer\HTML` (`$writer->getContent()`), then extracts just the
`<body>…</body>` inner HTML with a regex so the output is the document content, not PHPWord's full
HTML wrapper (which includes a default `<title>PHPWord</title>`). Writer failures throw
`DocumentLoaderValidationException`. The returned string is placed in an `HtmlOutput`; this module
does not itself render or sanitize it — that is the consumer's responsibility.

## Markdown conversion

`src/PhpWordToMarkdown.php` — `final class PhpWordToMarkdown`, also using `DocumentTraversalTrait`.
`convert(PhpWord $phpWord, bool $includeHeaderFooter = FALSE): string` renders each ordered element
group into blocks joined by blank lines. Key behaviours:

- **Headings** — `Title` elements → `#`×level (depth clamped 1–6).
- **Lists** — consecutive `ListItemRun`/`ListItem` elements are grouped into one block; indent =
  4 spaces × depth; marker `1.` for numbered styles (`TYPE_NUMBER`/`TYPE_NUMBER_NESTED`/
  `TYPE_ALPHANUM`), else `-`. PHPWord readers usually lose the ordered/unordered distinction, so
  most read documents render as bullets.
- **Inline** (`renderInline()`) — `Link` → `[text](source)`; `Text` → escaped text with
  bold/italic/strikethrough markers from its `Font` style (`applyFontStyle()` keeps surrounding
  whitespace outside the markers); `TextBreak` → newline; containers recurse.
- **Tables** (`renderTable()`) — Markdown pipe table; pipes in cells are escaped, whitespace
  collapsed, `gridSpan` (horizontal merges) padded with empty cells, rows normalized to the widest
  column count, and a `---` separator row inserted after the first row.
- **Escaping** (`escapeMarkdown()` / `decodeEntities()`) — HTML entities are decoded
  (`html_entity_decode`, `ENT_QUOTES | ENT_HTML5`), non-breaking spaces (U+00A0/U+202F) normalized
  to regular spaces, then Markdown control chars ``\ ` * _ [ ]`` backslash-escaped.

The class exists because PHPWord's own HTML→conversion is lossy for Markdown (flattens lists,
renders formatting as inline CSS).

## Metadata

`extractMetadata()` reads `PhpWord::getDocInfo()` and returns the non-empty subset of: `title`,
`subject`, `description`, `keywords`, `category`, `creator`, `last_modified_by`, `company`,
`manager`, `created`, `modified`. This array becomes the output object's metadata regardless of
output format.

## Shared traversal helper

`src/DocumentTraversalTrait.php` — `orderedElementGroups()` returns element lists in output order
(optional first header, then every section's elements, then optional last footer);
`firstHeader()`/`lastFooter()` scan `$section->getHeaders()`/`getFooters()` for the first/last
non-empty container. Used by both `PhpWordLoader::extractText()` and `PhpWordToMarkdown::convert()`.

## Operating notes

- No routes/permissions/UI of its own; drive it through the `document_loader` framework (a
  `DocumentLoader` consumer, service call, or another module) with a `WordInput`/`RtfInput`.
- Choose the correct extension: the reader is selected by extension, so a mislabelled file is fed to
  the wrong PHPWord reader.
- RTF is best-effort (headings/lists lost, special characters may drop) per the plugin docblock.
- Unit tests: `tests/src/Unit/Plugin/DocumentLoader/PhpWordLoaderTest.php` and
  `tests/src/Unit/PhpWordToMarkdownTest.php` (fixtures `test.docx`, `test.odt`, `test.rtf`).
