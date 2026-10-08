<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic export/import

## Services

| Service | Class | Use |
|---|---|---|
| `content_sync.manager` | `ContentSyncManager` | Entry point; owns the exporter/importer and builds import/export queues |
| `content_sync.exporter` | `ContentExporter` | `exportEntity(ContentEntityInterface $entity, array $context = [])` → YAML string |
| `content_sync.importer` | `ContentImporter` | `importEntity(array $decoded_entity, array $context = [])` → saved entity or NULL |
| `content.storage.sync` (alias of `content.storage.staging`) | `FileStorage` | The YAML files in `$content_directories['sync']` |
| `content.storage` | `CachedStorage` over `content.storage.active` | The `cs_db_snapshot` "active" state |
| `logger.cslog` | `ContentSyncLog` | Writes to `cs_logs` |
| `plugin.manager.sync_normalizer_decorator` | `SyncNormalizerDecoratorManager` | Decorator plugins |

`ContentSyncManager` API: `getContentExporter()`, `getContentImporter()`, `getSerializer()`,
`getEntityTypeManager()`, `generateImportQueue($file_names, $directory)`,
`generateExportQueue($decoded_entities, $visited)`.

## Export one entity

```php
$node = \Drupal::entityTypeManager()->getStorage('node')->load(12);
$yaml = \Drupal::service('content_sync.exporter')->exportEntity($node);
file_put_contents('/tmp/node.article.' . $node->uuid() . '.yml', $yaml);
```

`exportEntity()` sets `$entity->is_content_sync = TRUE` (the marker
`ContentEntityNormalizer::supportsNormalization()` checks — without it the module's normalizers
stay out of the way of core serialization), serializes with format `yaml`, then walks
`getTranslationLanguages()` and nests every non-default translation under `_translations[langcode]`.

## Import one entity

```php
$decoded = \Drupal\Component\Serialization\Yaml::decode(file_get_contents($path));
$entity  = \Drupal::service('content_sync.importer')->importEntity($decoded);
```

Resolution order inside `importEntity()`:

1. Entity type id comes from `$context['entity_type']` or from `_content_sync.entity_type` in the
   YAML; if neither is present it returns NULL (silently).
2. `taxonomy_term` with an empty `parent` gets `parent.target_id = 0` so it shows in the term list.
3. `serializer->denormalize()` builds the entity.
4. `user` id 0 (anonymous) is never saved.
5. `syncEntity()` → `prepareEntity()` → validate → `save()`.
6. `_translations` are applied afterwards: each translatable field is copied onto an existing or
   new translation, revisions are suppressed (`setNewRevision(FALSE)`), and the translation saved.

`prepareEntity()` is where the UUID matching happens: `loadByProperties(['uuid' => $uuid])`.
If a local entity with that UUID exists, the submitted fields (`$entity->_restSubmittedFields`)
are copied onto it — skipping entity keys (id, revision, langcode) via `isValidEntityField()` — so
the **local id is preserved**. If none exists, a duplicate is created and the exported UUID is
forced onto it. Fields with custom serialized properties are re-serialized by
`processSerializedFields()`.

`validateEntity()` only validates entities implementing `UserInterface`; everything else is
accepted unvalidated. Violations are logged to the `content_sync` channel, and
`$context['skipped_constraints']` (array of constraint class names) can whitelist known ones.
When validation fails: a new entity is dropped (returns NULL), an existing one is returned
unsaved.

## Queues and ordering

```php
$manager = \Drupal::service('content_sync.manager');
// Files → ordered import queue (dependencies first).
$queue = $manager->generateImportQueue($file_names, $directory);
// Entities → export queue including referenced entities.
$queue = $manager->generateExportQueue($decoded_entities, $visited);
```

`ImportQueueResolver` / `ExportQueueResolver` (`src/DependencyResolver/`) order the queue so a
referenced entity is processed before the entity referencing it; `$visited` prevents cycles from
looping forever.

## YAML shape

```yaml
uuid: [{value: 1f0a…}]
type: [{target_id: article}]
title: [{value: 'My page'}]
field_author: [{target_uuid: 8e21…}]      # references are UUIDs, not ids
_content_sync:
  entity_type: node        # the only key getContentSyncMetadata() writes
_translations:
  fr:
    title: [{value: 'Ma page'}]
```

Because the reference normalizers (`EntityReferenceFieldItemNormalizer`, `LinkItemNormalizer`,
`ImageItemNormalizer`, `PathAliasEntityNormalizer`) swap ids for UUIDs, a file is portable between
sites as long as the referenced entities are imported too — use `--include-dependencies` on export
or hand `generateExportQueue()` the seed entities.

## Batch helpers

`ContentExportTrait` / `ContentImportTrait` hold the batch operations used by the forms and the
Drush commands (`processContentExport()`, etc.). Reuse them for a custom batch instead of looping
`exportEntity()` yourself if you want the same archive/folder/base64 file handling and the
`site.uuid.yml` stamp.
