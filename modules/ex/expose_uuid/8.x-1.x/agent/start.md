<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose UUID (expose_uuid) — agent index

A one-file utility that surfaces an entity's **UUID** as an editable text field on **entity edit
forms**, gated by the `edit uuid` permission. Package `Admin`. **No dependencies** beyond Drupal
core. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version `8.x-1.2`
(version-dir `8.x-1.x`).

- **The form alter, the permission, validation, and how to operate it** →
  [api/form-alter.md](api/form-alter.md)

## What it actually is

- The entire module is two functions in `expose_uuid.module`:
  - `expose_uuid_form_alter(&$form, $form_state, $form_id)` — `hook_form_alter`.
  - `expose_uuid_form_validate($form, &$form_state)` — attached validate callback.
- One permission, `edit uuid` (title *"Edit UUID"*), declared in `expose_uuid.permissions.yml`.
- **No** routes, controllers, services, plugins, entities, config objects, config schema,
  libraries, hooks beyond `form_alter`, Drush commands, or install file. `LICENSE.txt` is GPLv2.

## Mechanism (from source)

- On **every** form, `expose_uuid_form_alter` first checks
  `\Drupal::currentUser()->hasPermission('edit uuid')` and returns early if the user lacks it.
- It then acts only when `$form_state->getFormObject() instanceof EntityFormInterface`. It reads the
  entity via `$form_state->getBuildInfo()['callback_object']->getEntity()->uuid()`.
- It adds `$form['uuid']` — a `textfield` (`#title` `t('UUID')`, `#default_value` = current UUID,
  `#size`/`#maxlength` 36, `#required` TRUE) — and appends `expose_uuid_form_validate` to
  `$form['#validate']`.
- `expose_uuid_form_validate` calls `Drupal\Component\Uuid\Uuid::isValid($value)` and, on failure,
  `setErrorByName('uuid', t('Not a valid UUID'))`.
- Whether the submitted value is persisted depends on core's form handling for the entity type
  (config-entity forms copy arbitrary form values onto the entity; content-entity forms map only
  field-widget values), so on many content entities the field is effectively read-only display.

## Operate it

- Enable: `drush en expose_uuid -y`. Grant `edit uuid` to trusted roles at
  `/admin/people/permissions`. The UUID field then appears on entity edit forms for those users.
