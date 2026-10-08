<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `sync_normalizer_decorator` plugins (+ the normalizer stack)

## The plugin type

- Manager service: `plugin.manager.sync_normalizer_decorator` (`SyncNormalizerDecoratorManager`,
  a `default_plugin_manager` child).
- Namespace: `Drupal\{module}\Plugin\SyncNormalizerDecorator\`.
- Annotation: `@SyncNormalizerDecorator` (`src/Annotation/SyncNormalizerDecorator.php`) with
  `id` and `name`.
- Base class: `SyncNormalizerDecoratorBase` (implements all three methods as no-ops — override
  only what you need).

Interface (`SyncNormalizerDecoratorInterface`):

```php
public function decorateNormalization(array &$normalized_entity, ContentEntityInterface $entity, $format, array $context = []);
public function decorateDenormalization(array &$normalized_entity, $type, $format, array $context = []);
public function decorateDenormalizedEntity(ContentEntityInterface $entity, array $normalized_entity, $format, array $context = []);
```

- `decorateNormalization` — on **export**, after the entity has been turned into an array. Mutate
  `$normalized_entity` to strip, rewrite or add values.
- `decorateDenormalization` — on **import**, on the raw array before the entity is built.
- `decorateDenormalizedEntity` — on **import**, on the built entity object before it is saved.

All registered decorators run for every content entity — there is no per-entity-type filter in
the plugin definition, so branch on `$entity->getEntityTypeId()` yourself. The hook points live in
`SyncNormalizerDecoratorTrait`, used by `ContentEntityNormalizer` and its subclasses.

## Shipped decorator: `id_cleaner`

`Plugin/SyncNormalizerDecorator/IdsCleaner.php` (`id = "id_cleaner"`, *IDs Cleaner*) removes serial
ids and target ids from the normalized array so an imported entity does not carry the source
site's numeric identity. This is what makes UUID-based matching work across environments — keep it
enabled unless you deliberately want ids preserved.

## Writing your own

```php
// my_module/src/Plugin/SyncNormalizerDecorator/StripInternalNotes.php
namespace Drupal\my_module\Plugin\SyncNormalizerDecorator;

use Drupal\content_sync\Plugin\SyncNormalizerDecoratorBase;
use Drupal\Core\Entity\ContentEntityInterface;

/**
 * @SyncNormalizerDecorator(
 *   id = "strip_internal_notes",
 *   name = @Translation("Strip internal notes"),
 * )
 */
class StripInternalNotes extends SyncNormalizerDecoratorBase {

  public function decorateNormalization(array &$normalized_entity, ContentEntityInterface $entity, $format, array $context = []) {
    if ($entity->getEntityTypeId() === 'node') {
      unset($normalized_entity['field_internal_notes']);
    }
  }

}
```

Need services? Implement `ContainerFactoryPluginInterface` and add a `create()` — see `IdsCleaner`,
which injects `entity_field.manager` and `entity_type.bundle.info`. Then `drush cr` and re-export.

## Normalizer stack (override points)

Registered in `content_sync.services.yml`, all tagged `normalizer`; higher priority wins:

| Priority | Service | Handles |
|---|---|---|
| 10 | `content_sync.normalizer.text_item` | text field items |
| 9 | `content_sync.normalizer.image_item` | image items (id → UUID) |
| 9 | `content_sync.normalizer.entity_reference_field_item` | entity reference items → `target_uuid` |
| 9 | `content_sync.normalizer.link_item` | link items pointing at entities |
| 8 | `content_sync.normalizer.timestamp_item` | timestamps |
| 7 | `content_sync.normalizer.file_entity` | file entities (payload via `--files`) |
| 7 | `content_sync.normalizer.user_entity` | users |
| 7 | `content_sync.normalizer.path_alias_entity` | path aliases |
| 7 | `content_sync.normalizer.paragraph_entity` | paragraphs |
| 6 | `content_sync.normalizer.content_entity` | every other content entity |

Plus `yaml_serialization.encoder.yaml` (`YamlEncoder` wrapping `serialization.yaml`) registered as
the `yaml` format encoder.

Two ways to change behavior, in order of preference:

1. **A decorator plugin** — additive, survives module updates. Prefer this.
2. **A higher-priority normalizer** — register your own service with
   `tags: [{name: normalizer, priority: 11}]` and a `supportsNormalization()` that matches only
   your case. Note the module's normalizers only engage when `$data->is_content_sync` is set, so a
   custom normalizer must respect the same marker or it will also hijack REST/JSON:API output.
