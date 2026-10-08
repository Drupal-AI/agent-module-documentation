<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `convert_bundles.permissions.yml` (static) plus a dynamic callback
`Drupal\convert_bundles\Permissions::get`.

## Static

- **`administer convert_bundles`** (`restrict access: TRUE`) — gates the whole-bundle config
  form and wizard: routes `convert_bundles.admin` (`/admin/config/content/convert_bundles`) and
  `convert_bundles.form` (`/admin/convert_bundles`).

## Dynamic — one per multi-bundle entity type

`Permissions::get()` iterates all entity type definitions and, for each that has **2 or more
bundles**, emits:

- **`convert <entity_type> bundle`** — e.g. `convert node bundle`, `convert taxonomy_term bundle`,
  `convert media bundle`, `convert paragraph bundle`.
  Title: *"<Entity type label>: Convert bundle"*.

This is the permission checked by the per-entity **Convert Bundle** tab
(`entity.<entity_type>.convert_bundles`). Grant it to let a role convert one specific entity
type's bundles without giving the blanket `administer convert_bundles`.

Assign with e.g. `drush role:perm:add editor 'convert node bundle'`.
