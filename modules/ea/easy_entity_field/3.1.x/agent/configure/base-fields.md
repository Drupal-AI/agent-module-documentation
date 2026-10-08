<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Entity Base Field — adding base fields

## 1. Enable target entity types
Go to `/admin/config/development/easy-entity-field` (route `easy_entity_field.settings_form`, permission `administer easy entity field`). Select which entity types get base-field management and, optionally, the `base_route` where the "Manage Base Fields" local task attaches. Settings are read by `easy_entity_field.settings` (`EasyEntityFieldSettings`).

## 2. Routes the module generates
`Routing\RouteSubscriber::alterRoutes()` adds, for each enabled `<entity_type_id>`:
- `entity.<type>.base_field` — list ("Manage Base Fields")
- `entity.<type>.base_field.add` — `EasyEntityFieldAddForm`
- `entity.<type>.base_field.storage` — storage settings (`easy_entity_field.storage` entity form)
- `entity.<type>.base_field.edit` — edit (`easy_entity_field.edit`)
- `entity.<type>.base_field.delete` — delete

Every one of these requires the permission `administer <entity_type_id> base fields`.

## 3. Permissions (all restricted)
- `administer easy entity field` (global settings) — `restrict access: TRUE`.
- Dynamic `administer <type> base fields` per fieldable entity type — generated in `EasyEntityFieldPermissions::fieldPermissions()`, `restrict access: TRUE`.

Grant these only to trusted administrators: creating/altering a base field changes the entity's storage schema.

## 4. Field types
Reference-style base fields are provided by plugins under `src/Plugin/EasyEntityField/`: `EntityReference`, `EntityReferenceRevisions`, `DynamicEntityReference` (managed by `plugin.manager.easy_entity_field`). Add your own by implementing `EasyEntityFieldPluginInterface` (see `easy_entity_field.api.php`).

## 5. Schema application & cleanup
`easy_entity_field.entity_update` (`EasyEntityUpdate`) installs/updates field storage definitions through the entity definition update manager. Each managed field is stored as an `easy_entity_field` config entity and listed via `EasyEntityFieldListBuilder`. `EasyEntityFieldUninstallValidator` prevents uninstalling the module while managed fields remain — delete them first.
