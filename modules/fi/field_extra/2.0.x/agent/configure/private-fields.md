<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure private fields

1. **Pick entity types.** Go to `/admin/config/content/private-settings` (perm `field extra manage private field settings`). The form lists entity types that implement both `FieldableEntityInterface` and `EntityOwnerInterface`. Check the ones that should support private fields; saved to `field_extra.private_fields:types`.
2. **Enable per field.** On a field's *config edit form* (Field UI), a checkbox "Allow the author to hide this field's value by making it private" appears (only for enabled entity types). Optionally "Enable the private field by default". Stored as third-party settings `field_extra:private_field` / `private_field_default`.
3. **Author use.** On the entity add/edit form the owner (or a user with `field extra access private fields` / `field extra access <entity_type> private fields`) sees a **Private** checkbox per private-capable field. State is saved to the `field_extra_value` table (`entity_type`, `field_name`, `id`, `private`).

**Enforcement:** `hook_entity_field_access` returns `forbidden` for the `view` operation when the value is private and the account is neither the owner nor holds a bypass permission — so the value disappears from rendered output and field-access-aware API responses. Non-private fields return `neutral`.

**Programmatic override:**
```php
function mymodule_field_extra_private_alter(&$private, array $context) {
  // $context = ['entity_type' => ..., 'field_name' => ...]
}
```
