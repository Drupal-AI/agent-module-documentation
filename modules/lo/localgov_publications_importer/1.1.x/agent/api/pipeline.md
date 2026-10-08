<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import pipeline & plugin API

An **import pipeline** is a `localgov_import_pipeline` config entity with:
- `extract_plugin` + `extract_plugin_configuration` — one Extract plugin.
- `transform_plugins` (ordered list) + `transform_plugin_configurations` — zero or more Transform plugins.
- `save_plugin` + `save_plugin_configuration` — one Save plugin.

Default pipeline (`config/install/...localgov_import_pipeline.standard.yml`): extract `smalot_pdfparser`; transforms `transform_images`, `transform_linebreaks`, `page_limit`; save `publication`.

## Flow
`Service\Importer::doImport(ImportInterface)`:
1. `setPipeline($import->getPipeline())`
2. `extract()` — Extract plugin fills the Import with `Page` objects (each with text, `Image` value objects, links).
3. each Transform plugin's `transform($import)` in order.
4. `save()` — Save plugin builds and returns a node (`publication`), stored back on the import as its result.

`Service\ImportManager` wraps this for cron/Drush: it loads pending `localgov_import` entities, sets status Processing → Completed/Failed.

## Writing plugins
Three attribute-defined plugin types (namespace `Plugin/LocalGovImporter/{Extract,Transform,Save}`), discovered by `ExtractOperationManager` / `TransformOperationManager` / `SaveOperationManager` (all `parent: default_plugin_manager`):

```php
use Drupal\localgov_publications_importer\Attribute\Transform;
#[Transform(id: 'my_transform', label: new TranslatableMarkup('My transform'),
  description: new TranslatableMarkup('...'))]
class MyTransform extends TransformPluginBase { /* transformPage(PageInterface $page) */ }
```
Extract plugins implement `extract(ImportInterface $import)`, Save plugins implement `import(ImportInterface): ?NodeInterface`. Extend the provided `*PluginBase` classes. Throw `RetryableTransformFailure` for a transform that should be retried.

## Data objects
- `ImportInterface` / `Entity\Import` — `getFile()`, `addPage()`, `getPages()` (serialized blob, `unserialize` restricted to `Page`/`Image`), `addImage(FileInterface)`, `getCreator()`, status constants PENDING/PROCESSING/COMPLETED/FAILED.
- `Page` / `Image` — plain value objects carrying extracted content and raw xObject image data.
