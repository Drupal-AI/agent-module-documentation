# Masking another entity type

Declare a `mask` on your content entity type so it borrows the masked type's fields and
display configuration.

Steps:
1. Set the storage handler to `Drupal\ctools_entity_mask\MaskContentEntityStorage` and add a
   `mask` key naming the entity type to borrow from:

```php
/**
 * @ContentEntityType(
 *   id = "my_shadow",
 *   label = @Translation("My shadow"),
 *   handlers = {
 *     "storage" = "Drupal\ctools_entity_mask\MaskContentEntityStorage",
 *   },
 *   mask = "node",
 *   ...
 * )
 */
class MyShadow extends ContentEntityBase {
  use \Drupal\ctools_entity_mask\MaskEntityTrait; // id() returns the UUID
}
```

2. The module copies the masked type's configurable field definitions onto your type, and
   `ctools_entity_mask_copy_display_modes()` (via `hook_entity_view_mode_info_alter()`) copies
   its display modes — so your type shares `node`'s Manage Fields / Manage Display UI.

Notes:
- `MaskEntityTrait::id()` returns the entity UUID, because mask entities are typically not
  stored with a serial id.
- Entity types that share display modes with a masked type appear together in display-mode
  info; keep the `mask` target enabled.
- No config schema and no admin screen — everything is driven from the entity annotation.
