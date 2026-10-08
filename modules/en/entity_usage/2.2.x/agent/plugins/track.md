# Tracking methods — EntityUsageTrack plugin

Each way one entity can reference another is an **EntityUsageTrack** plugin. The module ships
these plugin ids (`src/Plugin/EntityUsage/Track/`):

- `entity_reference` — entity_reference plus the `entity_reference_revisions`,
  `entity_reference_entity_modify`, `file`, `image` and `webform` field types (one plugin, many
  field types — there is **no** separate `entity_reference_revisions` plugin).
- `link` — core Link fields.
- `html_link` — plain HTML `<a href>` links to entity URLs inside text fields.
- `entity_embed` — Entity Embed embeds in text.
- `linkit` — LinkIt links in text.
- `media_embed` — core media embed button.
- `ckeditor_image` — inline `<img>` tags in CKEditor text fields.
- `block_field` — Block Field fields.
- `dynamic_entity_reference` — Dynamic Entity Reference fields.
- `layout_builder` — Layout Builder inline (non-reusable) blocks.

Enable/disable them under [settings](../configure/settings.md) (`track_enabled_plugins`).

- Plugin namespace: `Plugin/EntityUsage/Track`
- Attribute: `Drupal\entity_usage\Attribute\EntityUsageTrack` (legacy annotation
  `Drupal\entity_usage\Annotation\EntityUsageTrack` still works)
- Interface: `EntityUsageTrackInterface`; base class: `EntityUsageTrackBase`
- Manager service: `plugin.manager.entity_usage.track`; alter hook: `entity_usage_track_info`
- Optional interfaces: `EntityUsageTrackMultipleLoadInterface` (process all field values at
  once — do this for performance; `entity_reference` and `dynamic_entity_reference` use it),
  `EntityUsageTrackUrlUpdateInterface` (`html_link` uses it), `EmbedTrackInterface`
  (the text-embed plugins extend `TextFieldEmbedBase`, which implements it)

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
