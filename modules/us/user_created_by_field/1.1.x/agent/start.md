<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Created By Field (user_created_by_field) — agent index

Installs one configurable entity-reference field, `field_user_created_by_field`, on the `user`
entity that records who created each account, and two permissions that gate viewing/editing it.
Everything lives in `user_created_by_field.module` (presave + field-access hooks), the two
`config/install` field YAMLs, and `.permissions.yml`. No config route, no service, no Drush, no
plugin types.

- Depends on core `user` only. Core: `^8 || ^9 || ^10 || ^11`. No composer requirements, no submodules.
- Configure route: none (`configure` is null). Field is set up entirely by `config/install`.
- Field is auto-populated in `hook_user_presave` **only when the account is new**, with
  `\Drupal::currentUser()->id()`.
- Field visibility/editability is overridden by `hook_entity_field_access` + the two permissions.
- To surface the value, add the field to a user view mode (Manage display) or a View (e.g. People).

## Solution docs

- **The field: storage/instance, population, exposing it, uninstall** → [api/field.md](api/field.md)
- **The two permissions and the field-access hook** → [permissions/permissions.md](permissions/permissions.md)

## Key facts

- Field name: `field_user_created_by_field`; entity_type `user`, bundle `user`; type
  `entity_reference` → `target_type: user`; cardinality 1; translatable; not required.
  Handler `default:user` with `include_anonymous: true`, `auto_create: false`.
- Storage config: `field.storage.user.field_user_created_by_field`;
  instance config: `field.field.user.user.field_user_created_by_field`. Both enforced-owned by
  the module, so `hook_uninstall` deletes them (and the data).
- Permissions: `view user created by field`, `edit user created by field`.
- Hooks: `hook_user_presave` (set creator on new accounts), `hook_entity_field_access`
  (allow view/edit only with the matching permission, else forbidden), `hook_help`.
- Provides permissions: yes. Config schema: no. Drush: no. Plugin types: none.
