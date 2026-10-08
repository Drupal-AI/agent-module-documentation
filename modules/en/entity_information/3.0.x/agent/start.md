<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Information (entity_information) — agent index

Adds a pluggable **"Information" local-task tab** to entities (e.g. `/node/{node}/information`).
The tab renders collapsible `details` blocks, each built by an **EntityInformation plugin**.
Package **Administration**. Core `^10 || ^11`. License GPL-2.0-or-later. Version **3.0.0**.
**No non-core dependencies.**

- **Settings form, config object, permissions** → [config/settings.md](config/settings.md)
- **The EntityInformation plugin type, route/tab generation, controller, bundled plugins, writing a plugin** → [plugins/entity-information.md](plugins/entity-information.md)

## What it actually is

- A **plugin type**: annotation `@EntityInformation` (`src/Annotation/EntityInformation.php`),
  manager `EntityInformationManager` (service `plugin.manager.entity_information`, discovers
  `Plugin/EntityInformation`, interface `EntityInformationInterface`), plugins live in
  `src/Plugin/EntityInformation/`.
- `hook_entity_type_alter` (via `EntityTypeInfo::entityTypeAlter`) adds an `entity-information`
  link template `/{type}/{id}/information` to every entity type that has an `edit-form` template
  and a default/edit form class.
- `RouteSubscriber::alterRoutes` creates a route `entity.<type>.entity_information` for each entity
  type that has at least one matching plugin; `EntityInformationLocalTask` deriver adds the tab.
- Controller `EntityInformationController::render()` renders the enabled+matching plugins for the
  viewed entity as `#type => details` blocks, sorted by `weight`.
- **Settings**: `SettingsForm` at `/admin/config/system/entity-information` writes config object
  `entity_information.settings` (`enabled_plugins` sequence). Schema in `config/schema/`.
- **Permissions**: `view entity information`, `administer entity information settings`.
- **Bundled plugins** (both `bundles = { "node.*" }`): `path_alias` (path-alias overview) and
  `menu_link` (menu-link overview).
- No Drush, no libraries, no submodules, no `.install`.

## Static facts

- `provides_permissions`: yes · `provides_config_schema`: yes · `provides_plugin_types`:
  `entity_information` · `provides_drush_commands`: no.
- Optional per-plugin access via `EntityInformationAccessAwareInterface::access()`.
