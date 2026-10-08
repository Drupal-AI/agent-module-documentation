<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracking methods — EntityUsageTrack plugin

Each way one entity can reference another is an **EntityUsageTrack** plugin. Ships
these plugin ids (`src/Plugin/EntityUsage/Track/`), with the field types each scans:

| Plugin id | Class | Field types tracked |
|---|---|---|
| `entity_reference` | `EntityReference` | `entity_reference`, `entity_reference_entity_modify`, `file`, `image`, `webform` |
| `entity_reference_revision_field` | `EntityReferenceRevisionField` | `entity_reference_revisions` (paragraphs) — **inline** plugin |
| `link` | `Link` | `link`, `link_tree` |
| `html_link` | `HtmlLink` | `text`, `text_long`, `text_with_summary` (plain `<a href>` to entity URLs) |
| `entity_embed` | `EntityEmbed` | text fields (Entity Embed) |
| `linkit` | `LinkIt` | text fields (LinkIt) |
| `media_embed` | `MediaEmbed` | text fields (core "Embed media" filter) |
| `ckeditor_image` | `CkeditorImage` | text fields (inline `<img>`) |
| `block_field` | `BlockField` | `block_field` |
| `dynamic_entity_reference` | `DynamicEntityReference` | `dynamic_entity_reference` |
| `layout_builder` | `LayoutBuilder` | `layout_section` (inline blocks + Entity Browser Block) |

Enable/disable them under [settings](../configure/settings.md) (`track_enabled_plugins`).
Note: `entity_reference_revision_field` is now a **separate** plugin (it was folded
into `entity_reference` in older releases).

## Plugin API
- Namespace: `Plugin/EntityUsage/Track`; discovered by attribute
  `Drupal\entity_usage\Attribute\EntityUsageTrack` (`#[EntityUsageTrack(...)]`).
- Interface `EntityUsageTrackInterface`; base class `EntityUsageTrackBase`.
- Manager service `plugin.manager.entity_usage.track` (`EntityUsageTrackManager`);
  alter hook `entity_usage_track_info`; definitions cached under
  `entity_usage_track_plugins`.
- Optional interfaces:
  - `EntityUsageTrackMultipleLoadInterface` — process all field values in one query
    (do this for performance; `entity_reference`, `dynamic_entity_reference` use it).
  - `EntityUsageTrackUrlUpdateInterface` — re-track when a URL changes (`html_link`).
  - `EmbedTrackInterface` — text-embed plugins extend `TextFieldEmbedBase`, which
    implements it.
  - `EntityUsageInlineTrackingInterface` — for "inline" entity types (e.g. paragraphs)
    that should never appear directly as source/target; such plugins are **always
    enabled** and their entity types are removed from the settings options and from
    `getSourceEntityTypeIds()`. Implement `getInlineEntityTypeIds()`.

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

- `field_types` — field types this plugin scans on source entities.
- `source_entity_class` — restricts which source entity types the plugin applies to
  (default `FieldableEntityInterface`); the manager derives the set of trackable
  source types from all plugins' `source_entity_class`.
- `EntityUsageTrackBase` implements `trackOnEntityCreation/Update()` and field
  discovery; you usually implement only `getTargetEntities()`. Keep it fast — it can
  run millions of times during a full rebuild (use entity queries via
  `checkAndPrepareEntityIds()`, not entity loads; gate with `isEntityTypeTracked()`).
- Run `drush cr`; the plugin then appears in the settings "Enabled tracking plugins"
  list.
