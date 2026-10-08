<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`entity_repeat.permissions.yml` declares a `permission_callbacks` entry pointing at
`\Drupal\entity_repeat\EntityRepeatPermissions::permissions`. There are no static permissions.

## Dynamic per-bundle permissions

`src/EntityRepeatPermissions.php` (uses core `BundlePermissionHandlerTrait`):
- `permissions()` calls `_entity_repeat_get_bundles()` and `generatePermissions()` over them.
- `_entity_repeat_get_bundles()` (`entity_repeat.module`) loads every `field_config` with
  `field_type = date_recur` and returns the bundle config entities those fields live on. So
  permissions exist **only** for bundles that actually have a Date Recur field.
- `buildPermissions($bundle_type)` returns two permissions per bundle, keyed
  `repeat own {bundle_id} {entity_type_id}` and `repeat any {bundle_id} {entity_type_id}`, with
  titles like *"%type_name: Repeat own %bundle_name"* / *"…: Repeat any %bundle_name"*.

## How they gate behavior

`EntityRepeatWidget::entityRepeatAccess()` grants the repeat capability when the current user has
`repeat any {bundle} {entity_type}`, or is the entity owner and has `repeat own {bundle} {entity_type}`.
The "enable repeat" checkbox is only rendered when this passes, and generation only fires when the
resulting flag is present (see [../fields/widget.md](../fields/widget.md) and
[../api/generation.md](../api/generation.md)). Grant these at `/admin/people/permissions` under the
Entity Repeat section. Generated clones are ordinary entities subject to their normal entity access.
