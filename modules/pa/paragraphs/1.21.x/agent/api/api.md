# API — entities & services

## Entities
- **Content:** `Drupal\paragraphs\Entity\Paragraph` (entity type `paragraph`,
  `ParagraphInterface`). Revisionable content entity; every paragraph belongs to a bundle
  (a Paragraphs type) and is referenced from a host via an Entity Reference Revisions field.
- **Config (bundle):** `Drupal\paragraphs\Entity\ParagraphsType` (`paragraphs_type`).

## ParagraphInterface — useful methods
- `getParentEntity()` / `setParentEntity(ContentEntityInterface $parent, $field_name)` — the
  host entity and field this paragraph is embedded in.
- `getType()` / `getParagraphType()` — bundle id / the `ParagraphsType` config entity.
- `getSummary(array $options = [])`, `getSummaryItems()`, `getIcons()` — the summary shown in
  the collapsed widget.
- Behavior settings storage: `getAllBehaviorSettings()`,
  `&getBehaviorSetting($plugin_id, $key, $default = NULL)`,
  `setAllBehaviorSettings(array $settings)`, `setBehaviorSettings($plugin_id, array $settings)`.
- `isChanged()`.

## Create a paragraph in code
```php
$paragraph = \Drupal\paragraphs\Entity\Paragraph::create([
  'type' => 'text',            // Paragraphs type machine name
  'field_body' => 'Hello',     // a field on that type
]);
$paragraph->save();

// Attach to a host node's ERR field:
$node->field_content->appendItem($paragraph);
$node->save();
```
Because the field is Entity Reference Revisions, save the host after adding items so the
paragraph's revision is pinned to the host revision.

## Services
| Service id | Class | Purpose |
|---|---|---|
| `plugin.manager.paragraphs.behavior` | `ParagraphsBehaviorManager` | Behavior plugin manager — see [../plugins/behavior.md](../plugins/behavior.md) |
| `plugin.manager.paragraphs.conversion` | `ParagraphsConversionManager` | Conversion plugin manager — see [../plugins/conversion.md](../plugins/conversion.md) |
| `paragraphs_type.uuid_lookup` | `ParagraphsTypeIconUuidLookup` | Cached lookup of type icon file UUIDs |

## Migration
Ships D7 migrate source/process/field plugins (`src/Plugin/migrate/…`) to upgrade Drupal 7
**Paragraphs** and **Field Collection** data; `paragraphs_migration_plugins_alter()` wires
them in.
