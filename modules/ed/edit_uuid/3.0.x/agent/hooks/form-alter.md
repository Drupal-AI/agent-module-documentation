# Form alter + validation (how the UUID field reaches entity forms)

All logic lives in `edit_uuid.module`.

## `hook_form_alter` — `edit_uuid_form_alter()`

Runs on every form. It acts only when:

1. The form object is an `EntityForm`, and
2. the current user has the `show edit_uuid` permission.

It then loads **all** `edit_uuid_config` entities and, for each config where
`config_key == $entity->getEntityTypeId()` **and** `$entity->bundle()` is in
`config_value`, it rewrites the form's `uuid` element:

```php
$form['uuid']['#title'] = t('UUID');
$form['uuid']['#type'] = 'textfield';
$form['uuid']['#default_value'] = $entity->get('uuid')->value;
$form['#validate'][] = 'edit_uuid_form_validate';
$form['uuid']['#disabled'] = $value->configType();
$form['uuid']['#disabled'] =
  $user->hasPermission('edit edit_uuid') && !$value->configType() ? FALSE : $value->configType();
```

- `config_type == TRUE` → field is disabled (shown, not editable).
- `config_type == FALSE` → field is editable.
- The entity type's `uuid` element (`$form['uuid']`) must already exist on the
  form; the module repurposes core's normally-hidden uuid element into a visible
  text field. Content entity forms carry this element by default.

## Validate callback — `edit_uuid_form_validate()`

Added to `$form['#validate']` for matching forms. Steps:

1. Read submitted `uuid`.
2. If empty and the entity is new → generate one via the `uuid` service.
   If empty and the entity exists → keep the existing UUID.
3. Lowercase it; write it back to both `$form_state->setValue('uuid', …)` and
   `$form_state->set('uuid', …)`.
4. `Uuid::isValid($uuid)` — sets error "UUID is not valid!" on bad format.
5. Uniqueness: if the value changed from the existing one, run
   `getStorage($entity->getEntityTypeId())->loadByProperties(['uuid' => $uuid])`;
   if any match exists, set error "UUID already exists!". (Scope: within the same
   entity type only.)

The saved value flows through normal entity form save, so the entity's UUID is
persisted with the submitted value.

## `hook_entity_base_field_info_alter` — `edit_uuid_entity_base_field_info_alter()`

For every entity type that has a `uuid` key, calls
`$field->setDisplayConfigurable('view', TRUE)` on that `BaseFieldDefinition`. This
is what makes the `uuid` field selectable on *Manage display* so the `edit_uuid`
formatter can be placed (see [../fields/formatter.md](../fields/formatter.md)).

## `hook_help` — `edit_uuid_help()`

Provides help text on `help.page.edit_uuid` and on the config collection route.
