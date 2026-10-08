# Event types / handlers — Admin Audit Trail

This module has **no plugin manager**. "Event types" are registered with a classic info hook,
and logging is driven by ordinary Drupal entity/form hooks in each submodule. To track a new
subsystem, write a tiny module that does two things.

## 1. Register the event type
`hook_admin_audit_trail_handlers()` returns handlers keyed by event type. For simple
entity-hook logging you only need a `title` (used as the type's label in the report filter):

```php
/**
 * Implements hook_admin_audit_trail_handlers().
 */
function mymodule_admin_audit_trail_handlers() {
  return [
    'my_thing' => ['title' => t('My Thing')],
  ];
}
```

Optional handler keys (used for the base module's generic form-submission dispatcher rather
than entity hooks):
- `form_ids` (array) — form ids that, when submitted, call `form_submit_callback`.
- `form_ids_regexp` (array) — regexes matched against the submitted form id.
- `form_submit_callback` (string) — function `(&$form, $form_state, $form_id)` returning a
  `$log` array (without `type`; the dispatcher adds it) or nothing to skip.

The registry is collected by `admin_audit_trail_get_event_handlers()` and the label list by
`admin_audit_trail_get_event_types()`.

## 2. Write rows from entity hooks (the submodule pattern)
Most submodules ignore the form dispatcher and just call the logger from entity hooks. Example
(mirrors `admin_audit_trail_node`):

```php
function mymodule_ENTITY_insert($entity) {
  admin_audit_trail_insert([
    'type' => 'my_thing',
    'operation' => 'insert',
    'description' => t('%label created', ['%label' => $entity->label()]),
    'ref_numeric' => $entity->id(),
    'ref_char' => $entity->label(),
  ]);
}
```

Conventional `operation` values used by the bundled submodules: `insert`, `update`, `delete`,
`translation insert`, `translation delete` (auth uses `login` / `logout` / etc.).

See `api/admin_audit_trail.md` for the full `$log` field list, the table schema, and the
important **CLI caveat**.
