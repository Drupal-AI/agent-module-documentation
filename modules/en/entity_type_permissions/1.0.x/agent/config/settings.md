<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config & routes

## Install / enable

`drush en entity_type_permissions -y`. Depends only on core `user`. No composer requirements beyond
Drupal core; no config schema, install config, Drush commands, or plugin types ship with the module.
After enabling, open the settings form and select entity types — nothing is governed until you do.

## Settings form — `Form\SettingsForm`

- File `src/Form/SettingsForm.php`, extends `ConfigFormBase`, form id
  `entity_type_permissions_settings`, editable config `entity_type_permissions.settings`.
- `buildForm()` renders a single `#type => checkboxes` element `permissions_filter`, titled
  *"Generates permissions for these entity types"*. Options are the applicable content entity types
  (same filter as `DynamicPermissions`: `ContentEntityTypeInterface`, not internal, has a bundle
  entity type), keyed by entity-type id with the entity-type label. Default value comes from
  `entity_type_permissions.settings:permissions_filter`.
- `submitForm()`:
  1. `$filter = array_filter($form_state->getValue('permissions_filter'))` (checked ids only).
  2. Loads all `user_role` entities; iterates `user.permissions` handler
     `getPermissions()` and, for each permission whose `provider === 'entity_type_permissions'`,
     revokes it from every role **unless** the permission string contains one of the still-selected
     entity-type ids (`strpos($permission, $type) !== FALSE`).
  3. Saves the changed roles, then saves `permissions_filter` to config.

Effect: unchecking an entity type both stops generating its permissions and strips already-assigned
ones from all roles — no manual cleanup needed.

## Config object

`entity_type_permissions.settings` with one key:

- `permissions_filter` — array of governed entity-type machine ids (checkbox values). No
  `config/schema/*` file is shipped, so this config is schema-less.

## Route, menu link & static permission

- Route `entity_type_permissions.settings_form`
  (`entity_type_permissions.routing.yml`): path `/admin/config/system/entity-type-permissions`,
  `_form: Drupal\entity_type_permissions\Form\SettingsForm`, requirement
  `_permission: 'administer entity_type_permissions configuration'`.
- Menu link `entity_type_permissions.settings_form`
  (`entity_type_permissions.links.menu.yml`): under `system.admin_config_system`
  (Configuration → System), weight 10.
- Static permission `administer entity_type_permissions configuration`
  (`entity_type_permissions.permissions.yml`), title *"Administer Entity Type Permissions settings"* —
  the only gate on the settings form.

## Operating it

1. Grant `administer entity_type_permissions configuration` to trusted admins.
2. On the settings form, check the entity types to govern and save.
3. On People → Permissions, assign the generated per-bundle *Access …* permissions to roles.
4. To stop governing a type, uncheck it and save (its permissions are removed from all roles).
