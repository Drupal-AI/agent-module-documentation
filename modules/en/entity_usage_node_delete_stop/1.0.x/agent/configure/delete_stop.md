# Configure the delete stop (per content type)

This module has **no settings form or route of its own**. The only configuration is a
per-bundle checkbox that the module injects into each content type's edit form and stores
as a third-party setting on the node type config entity.

## The setting

| Item | Value |
| --- | --- |
| UI location | Content type edit form → *Entity Usage Node Delete Settings* group (`/admin/structure/types/manage/<bundle>`) |
| Checkbox label | *Do not allow deletion of used nodes of this type.* |
| Third-party namespace | `entity_usage_node_delete_stop` |
| Setting key | `prohibit_deletion` |
| Type / default | boolean; **unset** (falsy) by default |
| Stored on | `node.type.<bundle>` config entity, under `third_party_settings` |

Config schema (`node.type.*.third_party.entity_usage_node_delete_stop`):

```yaml
prohibit_deletion:
  type: boolean
  label: 'Prohibit deletion of nodes that are used anywhere else'
```

Because it is a third-party setting on the content type, it **exports with the content
type** (`node.type.<bundle>.yml` → `third_party_settings.entity_usage_node_delete_stop.prohibit_deletion: true`).

## Preconditions (both required)

The checkbox is only rendered, and the stop only fires, when **both** hold:

1. `node` is present in `entity_usage.settings:delete_warning_message_entity_types`
   (configured in the Entity Usage module, `/admin/config/entity-usage/settings`). If not,
   `entity_usage_node_delete_stop_form_node_type_form_alter()` returns without adding the
   checkbox.
2. Entity Usage actually rendered its warning element `$form['entity_usage_delete_warning']`
   on the node delete form (i.e. the node has tracked usages worth warning about). The stop
   is attached to that element, so no warning element → no stop.

Verify precondition 1:

```bash
drush cget entity_usage.settings delete_warning_message_entity_types
```

## Set it via Drush / PHP

```php
// Enable for the 'page' bundle.
$type = \Drupal\node\Entity\NodeType::load('page');
$type->setThirdPartySetting('entity_usage_node_delete_stop', 'prohibit_deletion', 1);
$type->save();

// Disable again (the UI unsets the key rather than storing 0).
$type->unsetThirdPartySetting('entity_usage_node_delete_stop', 'prohibit_deletion');
$type->save();
```

```bash
drush php:eval '$t=\Drupal\node\Entity\NodeType::load("page");$t->setThirdPartySetting("entity_usage_node_delete_stop","prohibit_deletion",1);$t->save();'
```

## What happens at runtime

- **`hook_form_node_type_form_alter()`** — if precondition 1 holds and the form entity is a
  `NodeType`, adds a `details` element (`#group => additional_settings`) with the
  `prohibit_deletion` checkbox (default from the current third-party setting) and registers
  the `#entity_builders` callback `entity_usage_node_delete_stop_entity_builder`.
- **`entity_usage_node_delete_stop_entity_builder()`** — on save: if
  `$form_state->getValue('prohibit_deletion') === 1` it sets the third-party setting to `1`;
  otherwise it **unsets** the key. (A checked Form-API checkbox submits integer `1`, so the
  strict `=== 1` matches; unchecked submits `0` and the key is removed.)
- **`hook_form_node_confirm_form_alter()`** — when the form object is a `NodeDeleteForm`,
  precondition 1 holds, the node's bundle has `prohibit_deletion` set, the warning element
  `$form['entity_usage_delete_warning']` exists, and the current user does **not** have
  `skip node delete stop`, it appends
  `t('Deletion is disabled until all usages are removed.')` to
  `$form['entity_usage_delete_warning']['#message_list']['error']` and sets
  `$form['actions']['submit']['#disabled'] = TRUE`.

## Scope limit

This is a **confirm-form guard only**. The module implements no `hook_entity_access`,
`hook_entity_predelete`, or delete-access alter, so nodes can still be deleted through
`drush entity:delete`, Views Bulk Operations, migrations, REST/JSON:API, or
`$node->delete()` in custom code. Treat it as an editorial safety net, not
referential-integrity enforcement.
