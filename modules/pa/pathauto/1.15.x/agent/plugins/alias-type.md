# Make a new entity type aliasable — AliasType plugin

To let pathauto generate aliases for a content type it doesn't already support, provide an
**AliasType** plugin. Most content entities are already covered by the derived
`canonical_entities:*` plugin, so you only need this for non-entity paths or special cases.

- Plugin namespace: `Plugin/pathauto/AliasType`
- Attribute: `Drupal\pathauto\Attribute\AliasType` (legacy annotation `@AliasType` also works)
- Interface: `Drupal\pathauto\AliasTypeInterface` (batch types: `AliasTypeBatchUpdateInterface`)
- Manager service: `plugin.manager.alias_type`; alter hook: `hook_pathauto_alias_types_alter`

```php
namespace Drupal\mymodule\Plugin\pathauto\AliasType;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\pathauto\Attribute\AliasType;
use Drupal\pathauto\Plugin\pathauto\AliasType\EntityAliasTypeBase;

#[AliasType(
  id: 'my_thing',
  label: new TranslatableMarkup('My thing'),
  types: ['my_thing'],            // token types this pattern can use
  context_definitions: [],
)]
class MyThingAliasType extends EntityAliasTypeBase {
  // Extend EntityAliasTypeBase for entity-backed types; otherwise implement
  // AliasTypeInterface directly (getLabel, getTokenTypes, batchUpdate, ...).
}
```

- `types` lists the token types available in patterns of this alias type.
- Extend `EntityAliasTypeBase` to inherit bulk update/delete batch handling.
- After adding the plugin, `drush cr`; the new type appears as a **Pattern type** in the
  pattern form ([../configure/patterns.md](../configure/patterns.md)).
