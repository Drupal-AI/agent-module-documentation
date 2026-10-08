<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ElasticsearchIndex` plugin type

The module's core extension point. Until you define at least one index plugin it does nothing.

- Manager service: `plugin.manager.elasticsearch_index.processor`
  (`Drupal\elasticsearch_helper\Plugin\ElasticsearchIndexManager`).
- Discovery: annotated plugins in `src/Plugin/ElasticsearchIndex/` of any module.
- Annotation: `Drupal\elasticsearch_helper\Annotation\ElasticsearchIndex`.
- Interface: `ElasticsearchIndexInterface`; base class: `ElasticsearchIndexBase`.
- Alter hook: `elasticsearch_helper_elasticsearch_index_info`. Cache tag: `elasticsearch_helper_elasticsearch_index_plugins`.

## Annotation keys

Only `id` and `label` are declared on the annotation class, but `ElasticsearchIndexBase` reads
these definition keys directly:

| Key | Required | Used for |
|-----|----------|----------|
| `id` | yes | Plugin id. |
| `label` | yes | Human label (drush list, admin). |
| `indexName` | yes | Target ES index name; may contain `{placeholder}` tokens replaced from document data (e.g. `{langcode}`). |
| `entityType` | no | If set, entities of this type auto-index on save and are selected by `reindex`. |
| `bundle` | no | Restrict `entityType` auto-indexing to one bundle. |
| `normalizerFormat` | no | Serializer format used when normalizing an entity (default `elasticsearch_helper`). |

Placeholder handling: `getIndexName($data)` fills `{...}` from the serialized document;
`indexNamePattern()` replaces each `{...}` with `*` for multi-index ops (drop/truncate/search).

## Minimal index plugin

```php
namespace Drupal\my_module\Plugin\ElasticsearchIndex;

use Drupal\elasticsearch_helper\Plugin\ElasticsearchIndexBase;

/**
 * @ElasticsearchIndex(
 *   id = "my_node_index",
 *   label = @Translation("My node index"),
 *   indexName = "my-node",
 *   entityType = "node",
 *   bundle = "article"
 * )
 */
class MyNodeIndex extends ElasticsearchIndexBase {

  public function getMappingDefinition(array $context = []) {
    return \Drupal\elasticsearch_helper\Elasticsearch\Index\MappingDefinition::create()
      ->addProperty('id', \Drupal\elasticsearch_helper\Elasticsearch\Index\FieldDefinition::create('integer'))
      ->addProperty('title', \Drupal\elasticsearch_helper\Elasticsearch\Index\FieldDefinition::create('text'));
  }
}
```

`ElasticsearchIndexBase` supplies default index settings
(`number_of_shards = 1`, `number_of_replicas = 0`) and everything in
[api/services.md](../api/services.md) (index/get/delete/search/setup/drop/…). You typically
override only `getMappingDefinition()` and, when the document is not a plain entity,
`serialize()`.

## Building the mapping (fluent definition classes)

Under `src/Elasticsearch/Index/`:

- `MappingDefinition::create()->addProperty($name, FieldDefinition)` / `->addProperties([...])`.
- `FieldDefinition::create($type, $options = [])` where `$type` is any ES data type
  (`text`, `keyword`, `integer`, `date`, `object`, …). Supports:
  - `->addOptions(['format' => 'yyyy-MM-dd'])` — arbitrary mapping parameters.
  - `->addProperty($name, FieldDefinition)` — sub-fields of an `object` type.
  - `->addMultiField($name, FieldDefinition)` — ES multi-fields (`fields`). Properties and
    multi-fields are mutually exclusive on one field.
  - `->setMetadata($key, $value)` — arbitrary non-ES metadata your code can read.
- `SettingsDefinition::create()->addOptions([...])` — index `settings` (shards, analyzers…).
- `IndexDefinition::create()->setMappingDefinition(...)->setSettingsDefinition(...)` — override
  `getIndexDefinition()` to control both. `->toArray()` yields the `{settings, mappings}` body
  sent to ES `indices()->create()`.

Field/property types are validated through `elasticsearch_helper.data_type_repository`, whose
definitions can be altered via `DataTypeEvents::BUILD` (see [events/events.md](../events/events.md)).

## Turning a source into a document

`ElasticsearchIndexBase::serialize($source, $context)`:

- If `$source` is a content entity, it runs the Symfony serializer with format
  `normalizerFormat` (default `elasticsearch_helper`) and forces `data['id'] = $entity->id()`.
- Otherwise `$source` is returned as-is (index arbitrary arrays/objects).
- `getId($data)` uses `data['id']` as the ES document `_id` when it is a string/number, else lets
  ES assign one.

Provide a normalizer for the `elasticsearch_helper` format (a service tagged `normalizer`, or a
per-plugin normalizer as the example module does) to shape the stored document. Helper
`ElasticsearchLanguageAnalyzer::get($langcode)` maps a Drupal langcode to a built-in ES language
analyzer for multilingual mappings.

## Index name placeholders and languages

`indexName = "content-{langcode}"` with a document carrying `langcode` writes to
`content-en`, `content-de`, … while drop/search operate on `content-*`. This is how per-language
indices with language-specific analyzers are built.
