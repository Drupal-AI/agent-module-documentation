<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: OaiMetadataMap & OaiCache

The module defines two annotation-based plugin types. Grounded in `src/Plugin/OaiMetadataMap*`,
`src/Plugin/OaiCache*`, `src/Annotation/*`, `rest_oai_pmh.services.yml`, and
`rest_oai_pmh.api.php`.

---

## 1. `OaiMetadataMap` — how an entity becomes an XML record

- Manager service: `plugin.manager.oai_metadata_map`
- Annotation: `@OaiMetadataMap` (`src/Annotation/OaiMetadataMap.php`) — keys `id`, `label`,
  `metadata_format`, and a `template` array (`type`,`name`,`directory`,`file`).
- Base class: `Drupal\rest_oai_pmh\Plugin\OaiMetadataMapBase` — `build($record)` loads the
  annotated Twig template (via `getTemplatePath()`, which fires the alter hook below) and renders
  it. Discovery dir: `src/Plugin/OaiMetadataMap/`.

Built-in plugins (`metadataPrefix` in parentheses):

| id | metadata_format | Purpose |
|---|---|---|
| `dublin_core_rdf` | `oai_dc` | Dublin Core from core RDF / schema.org field mappings. |
| `dublin_core_metatag` | `oai_dc` | Dublin Core from Metatag `dcterms_*` tags. |
| `mods` | `mods` | MODS pulled from the configured MODS View. |
| `default_metadata_map` | `oai_raw` | Raw field dump — testing only. |

A plugin must implement three methods used by the resource (`OaiPmh::getRecordMetadata()` /
`listMetadataFormats()`):

- `getMetadataFormat()` → `['metadataPrefix'=>…, 'schema'=>…, 'metadataNamespace'=>…]` (feeds
  `ListMetadataFormats`).
- `getMetadataWrapper()` → the outer XML element keyed by wrapper name; the rendered record is
  injected at `[wrapper]['metadata-xml']`.
- `transformRecord(ContentEntityInterface $entity)` → the inner XML string. **Respect access:**
  built-ins skip fields where `$fieldItemList->access()` is FALSE — do the same in a custom map.

### Writing a custom metadata schema (e.g. MARCXML)

```php
<?php
namespace Drupal\mymodule\Plugin\OaiMetadataMap;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\rest_oai_pmh\Plugin\OaiMetadataMapBase;

/**
 * @OaiMetadataMap(
 *   id = "my_marcxml",
 *   label = @Translation("MARCXML"),
 *   metadata_format = "marc21",
 *   template = {
 *     "type" = "module",
 *     "name" = "mymodule",
 *     "directory" = "templates",
 *     "file" = "marc21"
 *   }
 * )
 */
class MarcXml extends OaiMetadataMapBase {

  public function getMetadataFormat() {
    return [
      'metadataPrefix' => 'marc21',
      'schema' => 'http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd',
      'metadataNamespace' => 'http://www.loc.gov/MARC21/slim',
    ];
  }

  public function getMetadataWrapper() {
    // Outer element; attributes go as '@name' keys. 'metadata-xml' is filled in by the resource.
    return ['record' => ['@xmlns' => 'http://www.loc.gov/MARC21/slim']];
  }

  public function transformRecord(ContentEntityInterface $entity) {
    $data = ['metadata_prefix' => 'marc21', 'elements' => []];
    foreach ($entity->getFields() as $field_id => $list) {
      if (!$list->access() || $list->isEmpty()) {  // honor field access!
        continue;
      }
      foreach ($list as $item) {
        $data['elements'][$field_id][] = $item->getValue()[$item->mainPropertyName()];
      }
    }
    return parent::build($data);   // renders templates/marc21.html.twig with $data
  }
}
```

Add `templates/marc21.html.twig`, then enable the format on the settings form: set a
`metadata_map_plugins` entry `{label: marc21, value: my_marcxml}`. Harvest with
`?verb=ListRecords&metadataPrefix=marc21`. Clear caches so the plugin/format is discovered.

### Override a built-in plugin's template — `hook_rest_oai_pmh_metadata_template_alter()`

The only hook the module invites (`rest_oai_pmh.api.php`). Repoint a plugin's Twig template at
your module without subclassing:

```php
function mymodule_rest_oai_pmh_metadata_template_alter(array &$template) {
  if ($template['file'] === 'mods') {
    // Use mymodule/templates/mods.html.twig instead of the shipped one.
    $template['name'] = 'mymodule';
  }
}
```

---

## 2. `OaiCache` — index-invalidation strategy

- Manager service: `plugin.manager.oai_cache`
- Annotation: `@OaiCache` (`id`, `label`). Base: `OaiCacheBase` with `clearCache($entity, $op)`,
  called from `hook_entity_insert/update/delete` (`rest_oai_pmh_entity_alter()`). Discovery dir:
  `src/Plugin/OaiCache/`.

Built-ins:

| id | Behavior |
|---|---|
| `liberal_cache` | On any insert/update/delete of an entity type present in the OAI index (or a View that feeds it), rebuilds the affected records immediately. Keeps the endpoint always fresh; more write overhead. |
| `conservative_cache` | Only removes records when their entity is **deleted** (inherits `OaiCacheBase` unchanged). New/edited content appears only after a cron run or a manual **Rebuild**. Lower write overhead. |

Selected via `rest_oai_pmh.settings:cache_technique`.

### Writing a custom cache strategy

```php
<?php
namespace Drupal\mymodule\Plugin\OaiCache;

use Drupal\rest_oai_pmh\Plugin\OaiCacheBase;

/**
 * @OaiCache(
 *   id = "my_nightly_cache",
 *   label = @Translation("Nightly rebuild only")
 * )
 */
class Nightly extends OaiCacheBase {
  // Override clearCache() to no-op on save (rely on cron) but still drop deleted entities:
  public function clearCache($entity, $op) {
    if ($op === 'delete') {
      parent::clearCache($entity, $op);   // reuse base deletion cleanup
    }
    // else: do nothing — a scheduled `rest_oai_pmh_rebuild_entries()` refreshes content.
  }
}
```

Enable it by setting `cache_technique: my_nightly_cache` (the settings form lists all discovered
`OaiCache` plugins). Useful helpers you can call from `clearCache()`:
`rest_oai_pmh_is_valid_entity_type()`, `rest_oai_pmh_remove_record()`,
`rest_oai_pmh_remove_sets_by_display_id()`, `rest_oai_pmh_cache_views()`.
