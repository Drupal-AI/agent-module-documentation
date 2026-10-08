<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending EVI (strategies & events)

## Field-strategy (updater) plugins
Plugin type `EntityValueInheritanceUpdater` (annotation `@EntityValueInheritanceUpdater`), manager
service `plugin.manager.entity_value_inheritance_updater`, base class
`EntityValueInheritanceUpdaterPluginBase`. Shipped IDs:

| id | behaviour |
|----|-----------|
| `update` | keep destination synced with source |
| `overwrite` | unconditionally write source value to destination |
| `override` | destination may hold a local override |
| `override_role_visibility` | role-aware override of the value |
| `disable` | display inherited value but lock the destination field |

Add your own by placing a plugin in
`src/Plugin/EntityValueInheritanceUpdater/` implementing the updater interface.

## Events (`InheritanceEvents`)
Subscribe to alter or react to the sync:
- `InheritancePreUpdateEvent` / `InheritancePostUpdateEvent`
- `InheritanceAlterFieldEvent` — change the value being applied
- `InheritanceAlterUpdateListEvent` — change which destination entities get updated
- `InheritanceSaveEntityEvent`

The module's own `DisabledFieldSubscriber` and `SaveEntitySubscriber` are examples.
