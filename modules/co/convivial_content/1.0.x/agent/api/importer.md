<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Content — import pipeline (services, YAML shape, Drush)

Three services under `src/` do the work. All imports run as the acting user; entities are created
with the current user as owner where applicable.

## DataSourceManager (`src/DataSourceManager.php`)
Fetches and parses YAML over `@http_client` (Guzzle). Guzzle defaults apply — TLS verification is on.
- `getFileContent($siteSource, $fileName = 'index.yaml')` — `GET $siteSource . $fileName`, returns
  `Yaml::parse($body)` or NULL; wraps failures in `\Exception('Failed to fetch content: ...')`.
- `fetchDatasets($sourceUrl)` — reads `index.yaml`, returns `[machine_name => human name]`.
- `fetchDataset($sourceUrl, $dataset)` — returns the entry for one dataset (which carries a `file`
  key naming the dataset YAML, and a `schema` reference used later).

`index.yaml` maps dataset machine names to `{ name: <label>, file: <dataset>.yaml }`. Each dataset
YAML has a top-level `schema:` (schema file basename, `.yaml` appended), a `theme: { name: ... }`,
and per-entity-type sections (`taxonomy_term`, `media`, `block_content`, `node`, `paragraph`,
`menu`, `site`, `region`). The schema YAML maps each bundle's incoming keys to `{ type, field }`
descriptors that drive field mapping.

## SiteCleanupManager (`src/SiteCleanupManager.php`)
- `delete($entityType, $bundle = NULL)` — with a bundle, queries by `bundle` (media/taxonomy_term)
  or `type` (node/block_content/paragraph) and deletes matches; without a bundle, loads and deletes
  **all** entities of that type. All queries use `accessCheck(TRUE)`. Called only when the run's
  Site Clean Up flag is set (except paragraphs, which are always deleted before reimport — see below).

## DataImporter (`src/DataImporter.php`)
`importContent(array $yamlData, string $sourceUrl, int $siteCleanup): array` runs a fixed order:
1. Loads the schema file (`$yamlData['schema'] . '.yaml'`) and the target theme name.
2. `taxonomy_term` → `importTerms` (creates `Term` entities).
3. `media` (image) → `importMedia`; each image is **downloaded** via `httpClient->get($url)` in
   `createImageFile`, written under `public://convivial_content/assets`, wrapped in a `File` +
   `Media` (bundle `image`, `field_media_image`). Content type of the response picks the extension.
4. `block_content` → `importBlockContent`.
5. `node` → `importNode`; each node is created and set to `moderation_state = published`.
6. Deferred reference fields (`need-update`) are resolved and appended to node reference fields.
7. Paragraphs: **all existing paragraphs are deleted unconditionally**, then any paragraphs
   collected during processing are created and attached to their host node/block content
   (`importParagraphs`). Requires the `paragraphs` module or an `\Exception` is thrown.
8. `menu` (clean-up only) → delete existing links then `importMenuLinks` (links to imported nodes).
9. `site` (clean-up only) → `setSiteConfig` rewrites `system.site` `page.front`, `mail`, `name`.
10. `region` (clean-up only) → `setRegion` disables existing region blocks in the theme, then
    places imported block content as `block` config entities in each region.

Field mapping happens in `processContent` via a `switch` on the schema `type`: `text/date/list/
boolean/number` (scalar), `media-image` (resolve target id), `html` (value + `format: rich_text`),
`alias` (path alias), `paragraph` (deferred), `ref` (taxonomy/node reference resolution), `file`
(reads `themePath . '/' . $value` from the active theme via `file_get_contents`), `link` (uri).
Entity id lookups (`getTargetIdFromName`, dictionary searches) all use `accessCheck(TRUE)`.

### Custom YAML
`ImportSettingsForm` adds a synthetic `custom` dataset: choosing it and pasting YAML runs
`Yaml::parse($textarea)` and imports that directly instead of fetching a remote dataset file.
Both remote and custom paths ultimately call `importContent`.

## Forms
- `Form\ImportSettingsForm` (`convivial_content.import`, FormBase, id
  `convivial_content_import_settings_form`): builds the dataset `select` from
  `DataSourceManager::fetchDatasets` plus a `custom` option, a `custom_dataset` textarea
  (visible only when `custom` is selected), and a `site_cleanup` checkbox. `submitForm` calls
  `DataImporter::importContent` and reports imported entity type names; catches
  `InvalidPluginDefinitionException` / `EntityStorageException` / generic `\Exception` and logs
  warnings to the `convivial_content` logger.

## Drush (`src/Commands/ConvivialContentCommands.php`, `drush.services.yml`)
- `convivial_content:import <dataset>` (alias `convivial_content-import`, option `--cleanup=0|1`).
  Prompts for confirmation (`UserAbortException` on decline), then fetches the dataset + schema
  from the configured `source_url` and calls `importContent`. Examples in the source: `bookshop`,
  `umami`, `news`, each with/without `--cleanup=1`.
