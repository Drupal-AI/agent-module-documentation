# Tracking methods — EntityUsageTrack plugin

Each way one entity can reference another is an **EntityUsageTrack** plugin. The module ships
plugins for: `entity_reference`, `link`, `html_link` (links in text fields), `entity_embed`,
`linkit`, `media_embed`, `block_field`, `dynamic_entity_reference`,
`entity_reference_revisions`, and `layout_builder`. Enable/disable them under
[settings](../configure/settings.md) (`track_enabled_plugins`).

- Plugin namespace: `Plugin/EntityUsage/Track`
- Attribute: `Drupal\entity_usage\Attribute\EntityUsageTrack` (legacy annotation
  `Drupal\entity_usage\Annotation\EntityUsageTrack` still works)
- Interface: `EntityUsageTrackInterface`; base class: `EntityUsageTrackBase`
- Manager service: `plugin.manager.entity_usage.track`; alter hook: `entity_usage_track_info`
- Optional interfaces: `EntityUsageTrackMultipleLoadInterface` (process all field values at
  once — do this for performance), `EntityUsageTrackUrlUpdateInterface`, `EmbedTrackInterface`

```php
namespace Drupal\mymodule\Plugin\EntityUsage\Track;

use Drupal\Core\Entity\FieldableEntityInterface;
use Drupal\Core\Field\FieldItemInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\entity_usage\Attribute\EntityUsageTrack;
use Drupal\entity_usage\EntityUsageTrackBase;

#[EntityUsageTrack(
  id: 'my_method',
  label: new TranslatableMarkup('My method'),
  description: new TranslatableMarkup('Tracks relationships made by my field.'),
  field_types: ['my_field_type'],
  source_entity_class: FieldableEntityInterface::class,
)]
class MyMethod extends EntityUsageTrackBase {

  // Return "$target_type|$target_id" strings for one field item value.
  public function getTargetEntities(FieldItemInterface $item): array {
    // ... resolve the referenced entity from $item ...
    return ['node|123'];
  }
}
```

- `field_types` — the field types this plugin scans on source entities.
- `source_entity_class` — restricts which source entity types the plugin applies to (default
  `FieldableEntityInterface`); omitting it is deprecated.
- `EntityUsageTrackBase` implements `trackOnEntityCreation/Update()` and field discovery; you
  usually only implement `getTargetEntities()`. Keep it fast — it runs millions of times when
  rebuilding large sites (use entity queries, not entity loads).
- Run `drush cr`; the plugin then appears in the settings "Enabled tracking plugins" list.
