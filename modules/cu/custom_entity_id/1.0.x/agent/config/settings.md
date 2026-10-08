<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, mechanism & operation

Files: `custom_entity_id.module`, `src/Form/CustomEntityIdSettingsForm.php`,
`custom_entity_id.routing.yml`, `custom_entity_id.permissions.yml`, `custom_entity_id.info.yml`.

## Install / enable

`drush en custom_entity_id`. No dependencies, no libraries, no composer requirements. Core
requirement `^10 || ^11 || ^12` (`info.yml`). Grant the `custom_entity_id access` permission to the
roles allowed to set custom IDs (it is `restrict access: true`, so treat it as admin-level).

## Route & permission

- Route `custom_entity_id.settings` → `/admin/config/custom-entity-id`, `_form:
  CustomEntityIdSettingsForm`, requirement `_permission: 'administer site configuration'`.
  Referenced as the `configure:` link in `info.yml`.
- Permission `custom_entity_id access` (`custom_entity_id.permissions.yml`) — controls whether the
  ID field is rendered on entity create forms. It does **not** gate the settings form.

## Settings form (`CustomEntityIdSettingsForm`)

- `ConfigFormBase`; editable config name `custom_entity_id.settings`; form id
  `custom_entity_id_settings`. DI: `config.factory`, `entity_type.manager`,
  `entity_type.bundle.info`.
- `buildForm()` iterates every entity-type definition; for each whose class has a `hasField`
  method it builds a `checkboxes` element per entity type, options = that type's bundles
  (`entity_type.bundle.info`), title = the type's bundle label. Current selection is read from
  config value `fieldable_entity` via `unserialize($stored, ['allowed_classes' => FALSE])`
  (defensively reset to `[]` if not an array).
- `submitForm()` collects the per-entity-type checkbox values (skipping array keys containing `#`),
  then stores them as `serialize($arr_selected_chk)` into `custom_entity_id.settings:fieldable_entity`.

## Config object

- `custom_entity_id.settings` — single key `fieldable_entity`, a **PHP-serialized string** of the
  shape `['node' => ['article' => 'article', 'page' => 0], 'taxonomy_term' => [...]]` (Drupal
  `checkboxes` values: selected bundles keep their key, unselected become `0`). No config schema
  ships, so this value is stored untyped.

## Runtime mechanism (`custom_entity_id.module`)

- `custom_entity_id_form_alter($form, $form_state, $form_id)`:
  - Requires `$form_state->getFormObject()` to have a `getEntity()` method **and** the current user
    to have `custom_entity_id access`.
  - Reads `custom_entity_id.settings:fieldable_entity`, unserializes it (allowed_classes FALSE),
    and proceeds only if the entity's `getEntityTypeId()` and `bundle()` are present in the opted-in
    map.
  - Only when the entity's id key value is not yet set, adds field `custom_entity_id_field`
    (`textfield`, size 15, maxlength 15, weight -50) with element-validate
    `custom_entity_id_attach_custom_entity_id_field_to_entity`, and appends
    `custom_entity_id_form_validate` to `$form['#validate']`.
- `custom_entity_id_form_validate()`:
  - If a value was entered and is not numeric → `setErrorByName('custom_nid_field', 'Nid is not
    numeric.')` (note: the error is set on a field name that does not exist, so it surfaces as a
    generic form error rather than being attached to the ID field).
  - Selects from the entity's `base_table` where the id key equals the entered value; if any row is
    returned → error "Entity id already exists." The query uses `->condition(...)` binding, not
    string concatenation.
- `custom_entity_id_attach_custom_entity_id_field_to_entity()` — element-validate that copies the
  submitted value onto `$entity->custom_entity_id_field`.
- `custom_entity_id_entity_presave($entity)` — only when `$entity->isNew()`, re-reads the opt-in
  config, and if the entity's `custom_entity_id_field` is non-empty and numeric, writes it into the
  entity's `entity_keys['id']` key with `$entity->set(...)`.

## Operation & caveats

1. Enable module → grant `custom_entity_id access` → configure opted-in bundles at
   `/admin/config/custom-entity-id`.
2. The field appears only on **create** forms (entity has no id) of opted-in bundles for permitted
   users; on edit forms it is suppressed.
3. Uniqueness is enforced only against **existing** rows at validation time; it does not reserve the
   value against the auto-increment sequence, so a later auto-assigned entity could still be created
   normally. Choosing an ID far above current values can leave gaps.
4. Non-numeric input is rejected; empty input falls through to normal auto-increment behaviour.
5. The presave hook runs for all new entities but only acts when the opt-in config matches and the
   `custom_entity_id_field` property is present (set by the permission-gated form path).
