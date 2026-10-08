# Configuration & install

**There is no settings page, no `configure` route, no config entity, and no config schema.** Enabling
the module registers its extractors and the `document_loader:file` plugin automatically. All behaviour
is chosen per use, not globally.

## Install

```bash
composer require drupal/ai_file_to_text   # pulls phpword, phpspreadsheet, pdf-to-html, commonmark, html-to-markdown, drupal/document_loader
drush en ai_file_to_text
```

The `dependencies:` line only lists `document_loader`. To actually use the consumers you also need:
- the **`ai`** module enabled for the `file_to_text` agent function call;
- **`ai_automators`** enabled for the `file_to_text_text_long` / `file_to_text_string_long` automators.

Optional, for higher-fidelity PDF extraction, install the `poppler-utils` system package (provides
`pdftotext` and `pdftohtml`). When present, `PopplerPdfExtractor` becomes available and takes the
`pdf` extension; otherwise the pure-PHP `PdfExtractor` is used. For DDEV:

```yaml
# .ddev/config.yaml
webimage_extra_packages:
  - poppler-utils
```

## Per-use options

There are only two settings and they are chosen where the feature is used:

- **Output format** — `text` (default), `html`, `markdown`, `json`.
  - Automator: the `automator_output_format` select on the automator's field settings.
  - Function call: the `output_format` parameter.
  - Programmatic: the second argument to `DocumentLoaderInterface::load($input, $output_format)`.
- **Heading style (HTML only)** — the automator checkbox **"Use class-based heading 1"**
  (`automator_native_headings`, default checked). Checked ⇒ H1 renders as `<p class="h1">` instead of
  `<h1>`. Programmatically this is the `native_headings` option on the input/extract call (note the
  automator inverts the checkbox into `native_headings`). H2–H6 always keep native `hN` tags plus a
  `class="hN"`.

## Output-format behaviour (reference)

- **markdown** is produced by generating native-heading HTML first, then converting via
  league/html-to-markdown.
- **json** for spreadsheets/CSV is native tabular JSON (records keyed by the first row); for every
  other type it is a DOM tree (`{"tag","attributes","children"}`) derived from the HTML.
- Requesting a format an extractor cannot produce silently **falls back to `text`**; the Document
  Loader output metadata records the source and extension (and an `error` key on failure).
