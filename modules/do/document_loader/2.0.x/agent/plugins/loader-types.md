<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types, Input/Output classes, factory & FileInputNormalizer

Two plugin types work together. Understand the split before writing a loader.

## `document_loader_type` (input categories)

- Manager: `plugin.manager.document_loader_type` → `src/DocumentLoaderTypePluginManager.php`
  (discovers `Plugin/DocumentLoaderType/`, cache key `document_loader_types`, alter
  `document_loader_type_info`).
- Attribute: `src/Attribute/DocumentLoaderType.php` — params: `id`, `label`, **`input_class`**
  (FQCN of the Input class), optional `description`, `interface`, `deriver`.
- Base: `src/DocumentLoaderType/DocumentLoaderTypeBase.php` — `getInputClass()` returns the
  attribute's `input_class`; `getSupportedExtensions()` delegates to that class (empty for
  URL-based types). Concrete types (e.g. `Plugin/DocumentLoaderType/PdfType.php`) just extend the
  base and set the attribute — no method overrides.
- ~19 ship: Pdf, Word, Spreadsheet, Presentation, Image, Text, Markdown, Html, Json, Xml, Yaml,
  Toml, Api, Website, S3, Notion, GitHub, SharePoint, OneDrive, Slack.

## `document_loader` (extraction backends)

- Manager: `plugin.manager.document_loader` → `src/DocumentLoaderPluginManager.php` (discovers
  `Plugin/DocumentLoader/`, cache key `document_loader_plugins`, alter `document_loader_info`).
  Helper methods: `getLoaderByType($type, ?$output)`, `getAllDocumentLoaders()`,
  `getLoadersByOutputType()`, `getLoadersGroupedByType()`, `getLoaderOptions()`,
  `supportsOutputType()`, `getInputClassName()`.
- Attribute: `src/Attribute/DocumentLoader.php` — `id`, `label`, `description`,
  `document_loader_types` (type IDs it handles), `output_types` (formats it can produce),
  optional `deriver`.
- Interface: `src/Plugin/DocumentLoaderInterface.php` — `load(input, $output_format='text'):
  DocumentLoaderOutputInterface`, `getSupportedOutputTypes()`, `getSupportedDocumentLoaderTypes()`,
  `isAvailable()`, `getLoaderOptionsSchema()`.
- Base: `src/Plugin/DocumentLoaderBase.php` (extends `PluginBase`,
  `ContainerFactoryPluginInterface`). Reads output/type lists from the definition, `isAvailable()`
  = TRUE, `getLoaderOptionsSchema()` = `[]`. `extractOwnOptions($options)` strips the
  `{plugin_id}__` prefix and keeps unscoped keys (see manager.md for the `dl__` convention).
- **The base module provides no concrete loaders** — install a loader module. To write one:
  create `Plugin/DocumentLoader/MyLoader.php` with the `#[DocumentLoader(...)]` attribute, extend
  `DocumentLoaderBase`, implement `load()` returning an Output (usually via
  `DocumentLoaderTypeFactory::createOutput()`). See the bundled skills at
  `.claude/skills/new-document-loader-plugin/` and `new-document-loader-type-plugin/`, or the
  test loaders under `tests/modules/document_loader_test/src/Plugin/DocumentLoader/`.

## Data contract (`src/DocumentLoaderType/`)

- `DocumentLoaderDataInterface` — `getContent(): string`, `getMetadata(): array` (shared by input
  & output).
- `DocumentLoaderInputInterface extends DocumentLoaderDataInterface` — adds `validate(): string[]`,
  `checkAccess(AccountInterface): AccessResultInterface`, and the static tool-schema trio
  `getToolInputSchema()`, `getToolCategoryLabel()`, `getToolCategoryDescription()`.
- `DocumentLoaderOutputInterface` — adds `getFormat(): string`.
- `UrlInputInterface extends DocumentLoaderInputInterface` — adds `getUrl(): string`.

### Inputs (`Input/`)

- **`FileInput`** — base file input; `getContent()` returns the file URI, options carried as
  metadata. `getSupportedExtensions()` = `[]` (accepts any). Format-specific subclasses (PdfInput,
  WordInput, SpreadsheetInput, ImageInput, TextInput, MarkdownInput, HtmlInput, JsonInput,
  XmlInput, YamlInput, TomlInput, S3Input, NotionInput, GitHubInput, SharePointInput,
  OneDriveInput, SlackInput, PresentationInput) override `getSupportedExtensions()`. Schema key:
  `file_input` (accepts a Drupal URI, file entity ID, or an HTTP(S) download URL). `checkAccess()`
  returns **neutral** — real file access is enforced by the `FileInputNormalizer`.
- **`ApiInput implements UrlInputInterface`** — schema keys `url`, `api_method`
  (Choice: GET/POST/HEAD), `api_headers` (JSON string), `api_body`. `validate()` checks URL format
  and method allowlist. `checkAccess()` neutral (remote resource).
- **`WebsiteUrlInput implements UrlInputInterface`** — schema key `url`; metadata options for
  user_agent/timeout/redirects/main-content extraction. `checkAccess()` neutral.

### Outputs (`Output/`)

`ContentOutput` (base) plus `{Format}Output`: Text, Html, Markdown, Csv, Json, Xml, Yaml, Toml,
Toon, Content. Resolved by convention (`ucfirst($format).'Output'`).

## `DocumentLoaderTypeFactory` (`document_loader.type_factory`)

Plugin-driven, no hardcoded class lists:

- `createFileInput($extension, $file_uri, $options)` — iterates type defs whose `input_class`
  extends `FileInput`, returns the first whose `getSupportedExtensions()` includes `$extension`;
  falls back to generic `FileInput`.
- `createUrlInput($type, $url, $options)` — looks up the type (by ID or `document_loader_type:`
  prefix), requires the input class to implement `UrlInputInterface`.
- `createInput($type, array $values, array $extra_options)` — generic: maps the first schema field
  to the constructor's primary value, the rest to options, merges `$extra_options`.
- `createOutput($format, $content, $metadata)` — `{Format}Output` or `ContentOutput` fallback.

## `FileInputNormalizer` (`document_loader.file_input.normalizer`)

`src/FileInput/FileInputNormalizer.php` — `normalize(mixed $input, AccountInterface $account):
FileInterface`. Accepts:

- a `File` entity → `view` access checked;
- an integer / numeric file entity ID → loaded, `view` access checked;
- a valid **stream-wrapper URI** (`public://`, `private://`, …) → path must exist AND a File
  entity must exist for that URI (no-entity URIs are **denied**), `view` access checked;
- an **HTTP(S) URL** → downloaded via the injected Guzzle client (30s timeout, 10 MB cap) into a
  `temporary://` file owned by the account.

Local file access is therefore always entity-`view`-gated. `InputResolverTrait`
(`src/Trait/InputResolverTrait.php`) is the shared helper consumers use to turn media/file/link/
text field values into `['file_input' => …]` or `['url' => …]` arrays for `loadFromData()`.
