# The `field_inheritance` plugin type

Field Inheritance defines its own plugin type: an inheritance **strategy/computation** plugin.

- **Manager:** `plugin.manager.field_inheritance` (`FieldInheritancePluginManager`, extends
  `DefaultPluginManager`).
- **Discovery:** classes in `Plugin/FieldInheritance/` of any module, annotated with the
  `#[FieldInheritance(...)]` **attribute** (`Drupal\field_inheritance\Attribute\FieldInheritance`);
  the legacy `@FieldInheritance` annotation is also supported.
- **Interface:** `Drupal\field_inheritance\FieldInheritancePluginInterface`; base class
  `FieldInheritancePluginBase`.
- **Alter hook:** `field_inheritance_info` (alter plugin definitions).
- **Attribute params:** `id` (string), `name` (TranslatableMarkup), `types` (array of field types the
  plugin supports — used by the add form to filter which plugin applies to the chosen source field).

## The two shipped plugins

| id | Class | `types` |
|---|---|---|
| `default_inheritance` | `DefaultFieldInheritancePlugin` | `['any']` — works for any field. |
| `entity_reference_inheritance` | `EntityReferenceFieldInheritancePlugin` | `entity_reference`, `image`, `file`, `webform`, `entity_reference_revisions`, `paragraphs`. |

Both extend `FieldInheritancePluginBase` with no overrides — the strategy logic lives in the base
class. The plugin choice mainly selects the **factory class** used for the computed field
(`entity_reference_inheritance` → `EntityReferenceFieldInheritanceFactory`, everything else →
`FieldInheritanceFactory`).

## How a plugin computes a value

`FieldInheritancePluginBase::computeValue()` reads the `method` (the inheritance `type`) and dispatches:

- `inherit` → `inheritData()`: the source entity's `sourceField` value.
- `prepend` → `prependData()`: destination field value, then source field value.
- `append` → `appendData()`: source field value, then destination field value.
- `fallback` → `fallbackData()`: destination value if non-empty, else source value.

Then it invokes `hook_field_inheritance_compute_value_alter($value, $context)` so the result can be
overridden. Configuration passed to the plugin (set up in `hook_entity_bundle_field_info_alter()`)
includes: `id`, `source entity type`, `source entity bundle`, `source identifier`, `source field`,
`method` (= strategy), `plugin`, optional `destination field`, plus the source field's settings and
the destination `entity`.

## Writing a custom strategy plugin

```php
namespace Drupal\my_module\Plugin\FieldInheritance;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\field_inheritance\Attribute\FieldInheritance;
use Drupal\field_inheritance\FieldInheritancePluginInterface;
use Drupal\field_inheritance\Plugin\FieldInheritance\FieldInheritancePluginBase;

#[FieldInheritance(
  id: 'uppercase_inheritance',
  name: new TranslatableMarkup('Uppercase Inheritance'),
  types: ['string', 'text', 'text_long'],
)]
class UppercaseInheritancePlugin extends FieldInheritancePluginBase implements FieldInheritancePluginInterface {
  // Override computeValue() (or one of inheritData()/prependData()/...) to transform the value.
}
```

The computed field's factory (`FieldInheritanceFactoryTrait::computeValue()`) instantiates your plugin
via the manager using the inheritance's `plugin` id and calls `computeValue()`; a plugin that returns
an empty array causes the computed field to fall back to its default value.
