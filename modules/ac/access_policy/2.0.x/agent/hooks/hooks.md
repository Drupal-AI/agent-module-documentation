# Hooks

## Hooks Access Policy provides (implement these to integrate)

Documented in `access_policy.api.php`.

### `hook_access_policy_data()`

Maps entity fields (and non-field contexts) to access-rule / selection-rule plugins so admins can
pick them in the UI. Return a nested array keyed by entity type (or a custom key), then by a unique
handler id (convention: the field name).

```php
function mymodule_access_policy_data() {
  $data = [];
  $data['node']['field_department'] = [
    'label' => t('Department'),
    'description' => t('Restrict by department.'),
    'entity_type' => 'node',        // defaults to the outer key
    'field' => 'field_department',  // the real field name
    'plugin_id' => 'entity_field_entity_reference', // the AccessRule plugin id
    // Optional keys:
    'settings' => ['operator' => '=', 'empty_behavior' => 'deny'],
    'operator' => '=',              // lock the operator (hide it from the form)
    'widget' => 'entity_field',     // move the field onto the Access selection tab
    'access_rule' => ['plugin_id' => 'entity_field_entity_reference'], // alt. form
    // Compare against contextual data (e.g. the current user's field):
    'argument' => [
      'plugin' => 'current_user',
      'field' => 'field_department',
      'field_type' => 'entity_reference',
    ],
  ];
  return $data;
}
```

`label`, `field`, and `plugin_id` are the minimum. The module's own implementation
(`access_policy_access_policy_data()`) registers the `broken` fallback handler, the global
`weekday_range` rule, and the field-derived data from `EntityFieldAccessPolicyData`,
`UserFieldAccessPolicyData`, and `FieldMatchAccessPolicyData`.

### `hook_access_policy_data_alter(array &$data)`

Alter the collected data (e.g. relabel a handler):

```php
function mymodule_access_policy_data_alter(array &$data) {
  $data['node']['field_department']['label'] = t('Business unit');
}
```

Collected + cached by the `access_policy.access_policy_data` service (`AccessPolicyData`); the cache
is cleared automatically on field-config insert and on the first policy for an entity type.

## Access-affecting hooks the module implements

These matter if you also alter access or queries for the same entities.

| Hook | Class/method | Effect |
|------|--------------|--------|
| `hook_entity_access` | `AccessPolicyEntityAccessControlHandler::access` | Restricts (or stays neutral on) entity operations per assigned policies. Only returns `forbidden`/`neutral` for standard ops (never `allowed`), so it can tighten but not widen core access. |
| `hook_entity_field_access` | `EntityOperations::entityFieldAccess` / `userFieldAccess` | Hides selection-set / access-rule-widget fields and observed user fields on edit forms (returns `forbidden` or `neutral`). |
| `hook_query_alter` | `AccessPolicyQueryAlter::queryAlter` | Filters DB queries tagged `<type>_access` so unreadable entities drop out of listings. |
| `hook_views_query_alter` | (see `.module`) | Ensures the `<type>_access` tag is present on Views over access-controlled types, then runs the query alter last (`hook_module_implements_alter`). |
| `hook_query_entity_reference_alter` | `AccessPolicyQueryAlter::queryAlter` | Filters entity-reference autocomplete/selection results. |
| `hook_entity_type_alter`, `hook_entity_base_field_info` | `EntityTypeInfo` | Adds the `manage access` form/link and the `access_policy` base field to supported entity types. |
| `hook_entity_operation_alter`, `hook_form_alter`, `hook_entity_presave`/`insert`/`update` | `EntityOperations`, `NodeFormAlter` | Add the Access operation link, inject the policy widget into entity forms, and (re)assign dynamic policies on save. |
| `hook_views_post_render` | (see `.module`) | Adds the `user` cache context to Views over access-controlled entity types. |
