<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Entity Id (custom_entity_id) — agent index

Adds an **"Entity Id" textfield** to the create form of selected fieldable entity types/bundles so
a privileged user can assign a **specific numeric primary-key ID** to a new entity instead of the
auto-increment value. No dependencies. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.0.3. Package: none declared.

- **Settings form, the opt-in config, the form-alter/validate/presave mechanism, permission and
  route** → [config/settings.md](config/settings.md)

## What it actually is

- Procedural module — no service classes, no plugins, no Drush, no config schema, no
  `config/install`. One form class: `CustomEntityIdSettingsForm`
  (`src/Form/CustomEntityIdSettingsForm.php`, extends `ConfigFormBase`).
- Three hooks in `custom_entity_id.module`:
  - `custom_entity_id_form_alter()` — adds field `custom_entity_id_field` (textfield, size/maxlength 15,
    weight -50) when the form object has `getEntity()`, the user has permission
    `custom_entity_id access`, the entity's type+bundle is opted in, and the entity has no id yet.
  - `custom_entity_id_form_validate()` — requires numeric input and checks the entity **base table**
    for a row already using that id (via `\Drupal::database()->select(...)->condition(id, value)`).
  - `custom_entity_id_entity_presave()` — on `$entity->isNew()`, writes the numeric value into the
    entity's `entity_keys['id']` key.
- One route: **`custom_entity_id.settings`** → `/admin/config/custom-entity-id`, permission
  **`administer site configuration`**.
- One permission: **`custom_entity_id access`** (`restrict access: true`) — gates whether the field
  is shown.
- One config object: **`custom_entity_id.settings`**, single value `fieldable_entity` holding a
  **PHP-serialized** `entity_type => [bundle => bundle|0]` map (read back with
  `unserialize(..., ['allowed_classes' => FALSE])`).

## Operate it

1. Enable the module; grant `custom_entity_id access` to the roles that may set IDs.
2. Visit `/admin/config/custom-entity-id`, check the entity-type/bundle combinations to enable.
3. On a new entity's create form those users now see an **Entity Id** field; a numeric,
   non-colliding value is saved as the entity's ID.

See [config/settings.md](config/settings.md) for details, keys, and caveats.
