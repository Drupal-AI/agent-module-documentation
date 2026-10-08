# Programmatic API — services & YAML format

## Import content in code — `default_content.importer`

`Drupal\default_content\ImporterInterface` (service `default_content.importer`, class `Importer`).

```php
/** @var \Drupal\default_content\ImporterInterface $importer */
$importer = \Drupal::service('default_content.importer');

// Scan {module}/content and create the entities; returns EntityInterface[] keyed by UUID.
$created = $importer->importContent('my_module');
```

Import behavior (what `importContent()` does):
- Reads `{module path}/content`; skips entirely if the folder is missing.
- Iterates content entity types only (config entities are skipped).
- Parses each `content/{entity_type}/*.yml`, keys files by `_meta.uuid`, throws if a UUID
  appears twice.
- Builds a dependency graph from each file's `_meta.depends` and topologically sorts it
  (Drupal core `\Drupal\Component\Graph\Graph`), so referenced entities import first.
- Switches to user 1 (`account_switcher`) for the whole run; sets each entity new + syncing
  before save; assigns user 1 as owner if an `EntityOwnerInterface` entity has none.
- For a `FileInterface` entity, copies the physical file sitting next to the YAML to the
  entity's destination URI.
- Dispatches `DefaultContentEvents::IMPORT` (`ImportEvent`) with the created entities + module.

This is what runs automatically on `hook_modules_installed` and on config import — you rarely
call it directly, but it is the entry point for custom import triggers.

## Export content in code — `default_content.exporter`

`Drupal\default_content\ExporterInterface` (service `default_content.exporter`, class `Exporter`).

```php
/** @var \Drupal\default_content\ExporterInterface $exporter */
$exporter = \Drupal::service('default_content.exporter');

// One entity → YAML string (optionally written to $destination file).
$yaml = $exporter->exportContent('node', 123, $destination = NULL);

// Entity + all referenced entities → string[][] keyed by entity type and UUID.
$exporter->exportContentWithReferences('node', 123, $folder = NULL);

// Everything listed under default_content: in a module's info file.
$exporter->exportModuleContent('my_module', $folder = NULL);
$exporter->exportModuleContentWithReferences('my_module', $folder = NULL);
```

## Normalizer — the YAML representation

`Drupal\default_content\Normalizer\ContentEntityNormalizerInterface`
(service `default_content.content_entity_normalizer`, class `ContentEntityNormalizer`).

- `normalize(ContentEntityInterface $entity)` → array with a top-level `_meta` (at least
  `entity_type` and `uuid`) plus a `default` key of field values and optional translations.
- `denormalize(array $data)` → rebuilds the `ContentEntityInterface`.

### YAML shape written per entity

```yaml
_meta:
  version: '1.0'
  entity_type: node
  uuid: 65c412a3-b83f-4efb-8a05-5a6ecea10ad4
  bundle: page
  default_langcode: en
  depends:                       # referenced entity UUIDs → their entity type
    ab301be5-7017-4ff8-b2d3-09dc0a30bd43: user
    550f86ad-aa11-4047-953f-636d42889f85: taxonomy_term
default:                         # field values for the default language
  title:
    - value: 'Imported node'
  uid:
    - entity: ab301be5-7017-4ff8-b2d3-09dc0a30bd43   # reference by UUID
  field_tags:
    - entity: 550f86ad-aa11-4047-953f-636d42889f85
# translations:                  # optional, keyed by langcode, same field shape
```

Entity references are stored as `entity: {uuid}` and each is also recorded under
`_meta.depends`; the importer resolves them to real entities and uses `depends` to order the
graph. Stable UUIDs are what keep references valid across sites.

## Legacy hal_json (deprecated)

`.json` files serialized with `hal_json` are still importable but deprecated in
`2.0.0-alpha2` and removed in `3.0.0`; importing them requires the `serialization` and `hal`
modules and logs a warning. Re-export as YAML.
