# Permissions

Defined in `editablefields.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Use editablefields | `use editablefields` | Whether a user may edit fields inline. The formatter renders the editable widget only if the user has this permission **and** `update` access to the entity (unless the formatter's `bypass_access` setting is TRUE). Without it, the field renders empty or via the configured fallback view mode. |
| Administer editablefields | `administer editablefields` | Administrative permission for the module (`EditableFieldsHelper::isAdmin()`). Not required for normal inline editing. |

## Access logic (from `EditableFieldsHelper::checkAccess()`)

```php
$can_edit = $entity->access('update');            // entity update access
$can_use  = $currentUser->hasPermission('use editablefields');
$has_access = $can_edit && $can_use;
```

- If `!$has_access` and the formatter's `bypass_access` is FALSE:
  - if `fallback_access` is TRUE → render the field read-only in `display_mode_access`;
  - else → render nothing.
- `bypass_access = TRUE` skips the `update`-access requirement entirely (the field is still
  subject to the route permission `access content` when using the popup endpoint).

The popup form route `editablefields.get_from` itself only requires `access content`; the
real gate is the formatter's access logic above.
