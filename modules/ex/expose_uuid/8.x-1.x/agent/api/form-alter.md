<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose UUID — form alter, permission & validation

Everything the module does lives in `expose_uuid.module` (two functions) plus one permission in
`expose_uuid.permissions.yml`. There is no config, no route, no service, no plugin.

## Install / enable

- `drush en expose_uuid -y` (or via *Extend*). No dependencies, no config to install.
- Grant the **`edit uuid`** permission (title *"Edit UUID"*) at `/admin/people/permissions` to the
  roles that should see/set UUIDs. Without it, the module adds nothing to any form.

## The permission

`expose_uuid.permissions.yml`:

```yaml
edit uuid:
  title: 'Edit UUID'
```

A single, plain permission. It controls whether the UUID field is added to entity edit forms.

## `expose_uuid_form_alter(&$form, FormStateInterface $form_state, $form_id)`

Implements `hook_form_alter`, so it runs for **every** form built on the site. Logic:

1. `if (!\Drupal::currentUser()->hasPermission('edit uuid')) return;` — early-out for users without
   the permission.
2. `if ($form_state->getFormObject() instanceof EntityFormInterface)` — only proceed for entity
   add/edit forms (nodes, terms, users, custom blocks, menus, config entities, etc.).
3. Resolve the entity:
   `$uuid = $form_state->getBuildInfo()['callback_object']->getEntity()->uuid();`
4. Add the field:

```php
$form['uuid'] = array(
  '#type' => 'textfield',
  '#title' => t('UUID'),
  '#default_value' => $uuid,
  '#size' => 36,
  '#maxlength' => 36,
  '#required' => TRUE,
);
$form['#validate'][] = 'expose_uuid_form_validate';
```

The UUID is placed into `#default_value` (rendered/escaped by Form API), and the field is required
and capped at 36 characters (canonical UUID length).

## `expose_uuid_form_validate($form, &$form_state)`

Attached validate handler:

```php
$uuid = $form_state->getValue('uuid');
if (!Uuid::isValid($uuid)) {
  $form_state->setErrorByName('uuid', t('Not a valid UUID'));
}
```

Uses `Drupal\Component\Uuid\Uuid::isValid()` (imported at the top of the file) so a malformed value
blocks form submission with *"Not a valid UUID"*.

## Persistence caveat

The module only injects the form element and validation; it adds **no submit handler** that copies
the value onto the entity. Whether an edited UUID is actually saved depends on core's entity form:

- **Config entity forms** (`EntityForm::copyFormValuesToEntity`) copy arbitrary `$form_state`
  values onto the entity via `$entity->set($key, $value)`, so the `uuid` value can be persisted.
- **Content entity forms** (`ContentEntityForm::copyFormValuesToEntity`) map only field-widget
  values, so a plain `uuid` element is generally **displayed but not written back**.

Treat the field as reliable for *viewing* UUIDs everywhere and for *setting* them primarily on
config-style entities. Because changing an entity's UUID can break references that resolve by UUID
(exported config, migrations, UUID-based web-service lookups), restrict `edit uuid` to trusted
admins.

## What it does NOT provide

No routes/endpoints, no UUID↔ID lookup service, no REST/JSON:API resource, no config object or
schema, no libraries, no Drush commands, no hooks other than `form_alter`, and no `.install` file.
