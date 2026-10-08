<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocumentLoaderManager service, pipeline, hooks & Drush

Service id **`document_loader.manager`** → `src/Service/DocumentLoaderManager.php`. This is the
primary integration point. All consumers (Tool, FWA, MDX, Automator, Drush) call into it.

## Install & enable

```bash
composer require drupal/document_loader
drush en document_loader -y
# Then install at least one LOADER plugin module, e.g.:
composer require drupal/document_loader_pdfparser && drush en document_loader_pdfparser -y
drush cr
```

The base module ships **no `DocumentLoader` (loader) plugins** — only type/input/output classes
and the framework. Without a loader module, every load throws
`DocumentLoaderNotFoundException` ("No document loader available…").

## The three entry methods

- `loadFromData(array $data, AccountInterface $account, string $output_format = 'text', int $max_length = 0, ?DocumentLoaderInterface $loader = NULL, string $caller = 'api'): DocumentLoaderResult`
  — highest-level. Auto-detects the type from `$data` keys, builds the typed input, runs the full
  pipeline. This is what almost every consumer uses.
- `loadFromInput(string $document_loader_type, DocumentLoaderInputInterface $input, AccountInterface $account, …): DocumentLoaderResult`
  — when you already have a typed Input and know its type ID.
- `load(string $document_loader_type, DocumentLoaderInputInterface $input, string $output_format = 'text'): ?DocumentLoaderOutputInterface`
  — thin convenience: default loader + `load()`, no validation/access/hooks. Returns NULL if no
  loader.

### Type auto-detection (`loadFromData`)

Every registered `DocumentLoaderType` exposes its input class's `getToolInputSchema()` keys. The
manager **scores** each type by how many of `$data`'s keys intersect the schema keys; highest score
wins. Ties break toward a type that has a configured/available default loader for the requested
output format. Example: `['url' => …, 'api_method' => …]` scores 2 for `ApiInput` vs 1 for
`WebsiteUrlInput`, so ApiInput wins. Keys **not** in the winning type's schema are treated as
**loader options** and passed through to the input's options array.

File-based types get special handling: the primary value is run through the
`FileInputNormalizer` (see `plugins/loader-types.md`) to resolve a file entity ID / stream URI /
remote URL into a `File` entity, the real path is verified, the extension is extracted, and
`DocumentLoaderTypeFactory::createFileInput()` picks the right `FileInput` subclass.

### The pipeline (`loadFromInput`, in order)

1. `input->validate()` → throws `DocumentLoaderValidationException` on errors.
2. `input->checkAccess($account)` → throws `DocumentLoaderAccessException` if forbidden.
3. Loader selection via `getDefaultLoader($type, $output_format)` (unless a `$loader` was passed).
   Throws `DocumentLoaderNotFoundException` if none.
4. Output-format support check; falls back to `pluginManager->getLoaderByType()` if the chosen
   loader doesn't support the format.
5. **`hook_document_loader_pre_load_alter(&$params, $context)`** — mutable `$params`
   (`output_format`, `max_length`, `loader`); read-only `$context` (`document_loader_type`,
   `input`, `caller`).
6. `loader->load($input, $output_format)` — wrapped; failures re-thrown as
   `DocumentLoaderException`.
7. Truncation: if `max_length > 0` and content exceeds it, content is cut and `"\n… (truncated)"`
   appended (`original_bytes` still records the pre-truncation length).
8. **`hook_document_loader_post_load_alter(&$result_data, $load_context)`** — mutable
   `$result_data` (`content`, `format`, `metadata`, `source`, `original_bytes`, `loader_label`).
9. Returns an immutable `DocumentLoaderResult`.

## DocumentLoaderResult

`src/Service/DocumentLoaderResult.php` — `final` readonly value object:
`content`, `format`, `loaderLabel`, `originalBytes` (int), `metadata` (array), `source`.

## Default-loader configuration

`getDefaultLoader($type, ?$output_type)` reads config object `document_loader.settings` →
`default_loaders` (a flat map). It checks a `"{type}.{output}"` key first, then `"{type}"`, else
delegates to `DocumentLoaderPluginManager::getLoaderByType()` (first available loader for the
type/output whose `isAvailable()` is TRUE). `setDefaultLoader($type, $plugin_id, ?$output_type)`
writes it back. The settings form (`config/settings.md`) is the UI for this.

## Form-builder helpers (used by consumers)

- `discoverSourceCategories()` — groups types by source category (`file`, `website`, `api`, …),
  returns label/description/schema/type_ids/output_formats; excludes categories with no loader.
- `buildSchemaFormElements($schema, $output_formats, $default, $include_shared, $honor_required)`
  — maps a tool-input schema to Drupal form elements (Choice→select, integer→number,
  boolean→checkbox, `file_input`→plain `#type file`, plus shared `output_format`/`max_length`).
- `collectSchemaFormValues($schema, $form_state)`, `collectAllSupportedExtensions()`,
  `getAvailableOutputFormats()`, `getOutputFormatsForTypes($type_ids)`.
- **Per-loader options** (see `hook` docs in `document_loader.api.php`):
  `collectLoaderOptionsSchemas()`, `buildLoaderOptionsFormSection($prefix='dl__', $saved, $type_ids)`,
  `extractLoaderOptionsFromArray($data)`. Form keys are `dl__{loader_id}__{option_key}`; the
  `dl__` prefix is a routing marker stripped before values reach `loadFromData()`. At runtime a
  loader calls `DocumentLoaderBase::extractOwnOptions()` to strip its own `{loader_id}__` prefix.

## Hooks

Declared in `document_loader.api.php`:

- `hook_document_loader_pre_load_alter(array &$params, array $context): void` — change output
  format, cap length, or swap the loader before load.
- `hook_document_loader_post_load_alter(array &$result_data, array $load_context): void` — rewrite
  content, enrich metadata, log. `$load_context['caller']` is one of `mdx_editor`, `fwa`, `tool`,
  `explorer`, `api`, `drush`.

Also: loader plugins may declare tunable options via
`DocumentLoaderInterface::getLoaderOptionsSchema()` (empty in the base). Alter info names:
`document_loader_info` (loaders) and `document_loader_type_info` (types).

## Exceptions (`src/Exception/`)

`DocumentLoaderException` (base), `DocumentLoaderValidationException`,
`DocumentLoaderAccessException`, `DocumentLoaderNotFoundException`. FileInput resolution throws
`FileInput\Exception\FileInputException`.

## Drush (`src/Drush/Commands/DocumentLoaderCommands.php`)

- `document-loader:list` (`dl:list`) — every loader with types, input fields, output formats,
  default-for. Filters `--output`, `--type`, `--input` (comma-separated, ALL-must-match);
  `--format=json|yaml`.
- `document-loader:inputs {type_id}` (`dl:inputs`) — the input schema for one type
  (e.g. `document_loader_type:website`).
- `document-loader:load` (`dl:load`) — runs `loadFromData()` as the current user. Repeatable
  `--input key=value`, plus `--output-format`, `--max-length`, `--show-metadata`. Runs as the
  Drush user account; access checks still apply.
