<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity Access by Role" field

There is no settings page. You use the module by adding a field of type
`entity_access_by_role_field` (label "Entity Access by Role", category "access") to a bundle
and configuring the field instance.

## Field value shape

Each field item stores two properties (`EntityAccessRoleItem`):

- `role_id` — a role machine name (optional; `_none` / empty = no role).
- `access` — `allowed` or `forbidden` (the `access` column is NOT NULL; `role_id` may be null).

`mainPropertyName()` is `role_id`. The field is multi-value in practice (several role rows), and
one shared `access` value applies to all selected roles.

## Per-instance settings (`field.field_settings.entity_access_by_role_field`)

| Setting | Values | Meaning |
|---|---|---|
| `operations` | subset of `view`, `update`, `delete` | which operations this field governs |
| `empty_roles_access_fallback` | `neutral` \| `allowed` \| `forbidden` | result when the field has no role selected |

Note the operation ids: view = `view`, edit = `update`, delete = `delete`. For an unpublished
entity, a `view` request is internally checked as `view_unpublished`.

## How the access decision works (`hook_entity_access`)

`entity_access_by_role_field_entity_access()` (in the `.module`):

1. If the account has `bypass entity_access_by_role_field permissions` → allowed.
2. For each role-access field on the entity whose `operations` include the current operation:
   - No roles selected → return the `empty_roles_access_fallback` (or skip if `neutral`).
   - `access = allowed`: allowed if the user has one of the selected roles, else forbidden.
   - `access = forbidden`: forbidden if the user has one of the selected roles, else allowed.
3. If every field returned neutral → neutral (core/other modules decide).

WARNING: only entity-operation access is enforced. The module does not implement
`hook_query_TAG_alter()`, so **Views and other listings are not filtered** and may show entities
(or labels) the user cannot view.

## Add the field with drush

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_role_access', 'entity_type' => 'node',
  'type' => 'entity_access_by_role_field',
])->save();
FieldConfig::create([
  'field_name' => 'field_role_access', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Role access',
  'settings' => [
    'operations' => ['view' => 'view', 'update' => 0, 'delete' => 0],
    'empty_roles_access_fallback' => 'neutral',
  ],
])->save();
```

Read it back:
`drush cget field.field.node.article.field_role_access settings` → `operations`,
`empty_roles_access_fallback`.

## Widget & formatters

- Default widget: `default_entity_access_by_role_field_widget` (radios for allow/restrict + a
  role selector).
- Formatters: `default_entity_access_by_role_field_formatter`, and
  `debug_entity_access_by_role_field_formatter` (shows the stored roles/access for debugging).
