# The `EntityTitleLength` service (lengthen another entity type)

## Interface & abstract class

`Drupal\title_length\EntityTitleLengthInterface` / `EntityTitleLength` (abstract). Constructor
args: `@database`, `@entity_type.manager`, `@entity.definition_update_manager`.

Key members:

| Member | Purpose |
|---|---|
| `getEntityType(): string` | (abstract) target entity type id, e.g. `node` |
| `getNameOfTitleField(): string` | (abstract) the title field name, e.g. `title` / `name` |
| `getBaseFieldDefinitions($etype): array` | (abstract) return the entity's base field defs |
| `getLength(): int` (static) | `Settings::get("{$type}_title_length_chars") ?: 500` |
| `changeLength(int $length): void` | widen data + revision title columns; re-install field storage def |
| `checkIfExistEntitiesWithLongTitles(?int $length = 255): bool` | true if any title/revision exceeds `$length` |

`changeLength()` does the real work: `Schema::changeField()` on the entity's data table (and,
if revisionable, the revision data table) to `varchar($length)`, then
`EntityDefinitionUpdateManager::installFieldStorageDefinition()` with the new `max_length`.

## Add support for a new entity type

Mirror `node_title_length`:

```php
namespace Drupal\my_title_length;
use Drupal\title_length\EntityTitleLength;
use Drupal\my_module\Entity\Thing;
use Drupal\Core\Entity\EntityTypeInterface;

class ThingTitleLength extends EntityTitleLength {
  public static function getEntityType(): string { return 'thing'; }
  public static function getNameOfTitleField(): string { return 'label'; }
  public function getBaseFieldDefinitions(EntityTypeInterface $etype): array {
    return Thing::baseFieldDefinitions($etype);
  }
}
```

Register it as a service `thing_title_length.thing` with those three arguments, add a
`hook_entity_base_field_info_alter()` that sets `$fields['label']->setSetting('max_length',
ThingTitleLength::getLength())`, and call the service's `changeLength(getLength())` from
`hook_install()`. That is exactly what the two shipped submodules do.

## Call it directly

```php
$svc = \Drupal::service('node_title_length.node');   // submodule's service
$svc->changeLength(\Drupal\node_title_length\NodeTitleLength::getLength());  // re-apply 500
$svc->changeLength(255);                              // shrink back (fails if long titles exist? no — only the drush cmd/uninstall check)
```
