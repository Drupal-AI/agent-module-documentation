# Consumers: Document Loader, AI function call, AI Automators

Three integration points sit on top of the extractor layer. All of them resolve a file URI, pick the
extractor by extension, and return content in the requested format. None of them defines a new plugin
type — each *implements* a plugin type from another module (`document_loader`, `ai`, `ai_automators`).

## Document Loader plugin — `document_loader:file`

`Plugin/DocumentLoader/FileDocumentLoader` (extends `document_loader`'s `DocumentLoaderBase`).

```php
use Drupal\ai_file_to_text\... // nothing needed; go through the type factory
$type_factory = \Drupal::service('document_loader.type_factory');
$input  = $type_factory->createFileInput('pdf', 'public://docs/report.pdf', ['native_headings' => TRUE]);
$loader = \Drupal::service('plugin.manager.document_loader')->createInstance('document_loader:file');
$output = $loader->load($input, 'markdown');   // 'text' (default) | 'html' | 'markdown' | 'json'
$content  = $output->getContent();
$metadata = $output->getMetadata();            // ['source','extension','loader'] or ['error'=>…]
```

`FileDocumentLoader::load()` (`FileDocumentLoader.php:106`):
1. `resolveFileUri($input)` — `getFileUri()` if present, else `getContent()`.
2. `$this->fileSystem->realpath($file_uri)` — resolves `public://`/`private://` stream wrappers to a
   real path. **A non-resolvable value (including any `http(s)://` URL) yields `FALSE` → returns an
   `error: File not found` output** (so this path cannot fetch a remote URL — no SSRF here).
3. Extension taken from the resolved real path; unsupported → `error: Unsupported file extension`.
4. If the requested `output_format` is not supported for that extension, the extractor layer falls
   back to `text`; `metadata` reports the extension and source.

Declared attribute: `output_types: [text, html, markdown, json]`,
`document_loader_types: [pdf, word, spreadsheet, text, markdown, xml]` (each `document_loader_type:*`).
`getSupportedDocumentLoaderTypes()` / `getSupportedOutputTypes()` are overridden to return the
manager's dynamic values, and `hook_document_loader_info_alter` (see below) patches the cached
definition so `getLoaderByType()` resolves third-party extractor types too.

## AI Agent function call — `file_to_text`

`Plugin/AiFunctionCall/FileToText` — id `ai_file_to_text:file_to_text`, `function_name: file_to_text`,
group `information_tools`. Requires the `ai` module. Context params (all `required: FALSE`, but exactly
one of the first two must be supplied):

| Param | Meaning |
|---|---|
| `file_id` | A Drupal `file` entity id; the plugin loads the entity and uses `$file->getFileUri()`. |
| `file_location` | A file URI/path (e.g. `public://docs/report.pdf`) used directly. |
| `output_format` | `text` (default), `html`, `markdown`, `json`. |

`execute()` (`FileToText.php:104`) rejects "both provided" / "neither provided", derives the extension
with `pathinfo($file_location, PATHINFO_EXTENSION)`, builds a `FileInput` via
`document_loader.type_factory` and runs `document_loader:file`. Output is the extracted string (or an
error message) set with `setOutput()`, returned to the calling agent — this module does not render it
as page HTML.

## AI Automator plugins

Both extend `FileToTextBase` (which extends `ai_automators`' `ExternalBase`); require `ai_automators`.

| Plugin id | `field_rule` | Class |
|---|---|---|
| `file_to_text_text_long` | `text_long` | `FileToText` |
| `file_to_text_string_long` | `string_long` | `FileToString` |

- `allowedInputs()` = `['file']`; `needsPrompt()` = FALSE. Source must be a **file field**.
- `extraFormFields()` adds `automator_output_format` (select: text/html/markdown/json) and
  `automator_native_headings` (checkbox "Use class-based heading 1", visible only for HTML output,
  default TRUE — when checked, H1 renders as `<p class="h1">`; the value is inverted into the
  `native_headings` option: checked ⇒ `native_headings = FALSE`).
- `generate()` iterates the source field's referenced file entities, calls `extractText($uri, $format,
  $options)` (which runs `document_loader:file`), and returns the extracted strings.
- `FileToText::storeValues()` (text_long) attaches a text format **only** for HTML output, chosen by
  `getTextFormat()` = the field's first `allowed_formats`, else `key($all_formats)` (first available
  filter format). `FileToString` (string_long) stores plain values with no format.

## Hook — `document_loader_info_alter`

`Hook/DocumentLoaderInfoAlter::alter()` (OOP `#[Hook]`; legacy shim
`ai_file_to_text_document_loader_info_alter()` in `.module`). Reads
`FileExtractorManager::getCapabilityGroups()`: one group ⇒ patch `document_loader_types` +
`output_types` in place; multiple groups ⇒ split into `document_loader:file`, `document_loader:file__1`,
… one per capability group, so `getLoaderByType($type, $output_type)` returns `NULL` instead of a
false positive when a type does not support the requested output.
