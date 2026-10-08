# UUID field formatter

Plugin `Drupal\edit_uuid\Plugin\Field\FieldFormatter\EditUuidFieldFormatter`.

```
@FieldFormatter(
  id = "edit_uuid",
  label = @Translation("UUID"),
  field_types = { "uuid" }
)
```

- Applies to fields of type `uuid` (the entity's base UUID field).
- `viewElements()` renders each item as plain `#markup` of `$item->value`, **only
  if** the current user has the `show edit_uuid` permission; otherwise it returns
  an empty render array (nothing printed).
- Injects the `current_user` service via `create()`.

## Enabling it

Because `edit_uuid_entity_base_field_info_alter()` marks the `uuid` base field as
`setDisplayConfigurable('view', TRUE)`, the field appears on the entity's
*Manage display* screen. Set its format to **UUID** (`edit_uuid`) to print the
UUID on the rendered entity, gated by the `show edit_uuid` permission.

There are no formatter settings (`viewElements` reads no `$this->getSettings()`).
