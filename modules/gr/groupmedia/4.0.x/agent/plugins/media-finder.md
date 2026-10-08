<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `media_finder` plugin type

Media finders detect the media items referenced/embedded inside a saved entity, so the
auto-tracking feature knows what to attach to a group. Plugin type provided by Group Media.

- **Manager service:** `plugin.manager.groupmedia.finder` (`MediaFinderManager`).
- **Directory:** `src/Plugin/MediaFinder/` in any module.
- **Discovery:** attribute `Drupal\groupmedia\Plugin\Attribute\MediaFinder` (new style) OR
  annotation `@MediaFinder` (legacy; submodule plugins use this).
- **Interface / base:** `MediaFinderInterface`, extend `MediaFinderBase`.
- **Alter hook:** `hook_media_finder_info_alter(array &$definitions)`.

## Definition properties

| Property | Meaning |
|---|---|
| `id` | plugin id |
| `label` | human label |
| `description` | short description |
| `field_types` | array of field type ids the finder inspects (e.g. `entity_reference`, `text_long`) |
| `element` | optional: embed element to look for (e.g. `drupal-media`, `drupal-entity`) |

## Core finders shipped

| id | field types | detects |
|---|---|---|
| `media_reference` | `entity_reference` | media in entity-reference fields |
| `groupmedia_media_embed` | `text`, `text_long`, `text_with_summary` | core *Embed media* filter (`drupal-media`) |
| `groupmedia_entity_embed` | same text types | *Entity Embed* module (`drupal-entity`) |

(`groupmedia_paragraphs` adds `paragraphs_media_reference` and `paragraphs_media_embed`.)

## Implement one

```php
namespace Drupal\my_module\Plugin\MediaFinder;

use Drupal\Core\Entity\EntityInterface;
use Drupal\groupmedia\Plugin\Attribute\MediaFinder;
use Drupal\groupmedia\Plugin\MediaFinder\MediaFinderBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[MediaFinder(
  id: 'my_finder',
  label: new TranslatableMarkup('My finder'),
  field_types: ['my_field_type'],
)]
class MyFinder extends MediaFinderBase {

  /** @return \Drupal\media\MediaInterface[] media items found on $entity */
  public function process(EntityInterface $entity): array {
    $items = [];
    // Inspect $entity fields whose type is in the definition's field_types,
    // resolve them to media entities, and return the list.
    return $items;
  }
}
```

`AttachMediaToGroup` calls every finder's `process()` on the saved entity, collects the
returned media, applies `hook_groupmedia_finder_add_alter`, then attaches the survivors.
Keep `process()` cheap — it runs on every entity save while tracking is enabled.
