<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Light (entity_usage_light) — agent index

Adds a per-entity **"Usage" tab** that lists, on demand, the entities a given entity
references. A lightweight alternative to Entity Usage: no storage table, no cron — the
list is computed live from the entity's current field values and cached. Package `Other`.
**No dependencies outside core** (Views/Paragraphs/Layout Builder are optional soft
integrations). Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.1.

- **What it provides, how detection works, the routes/permissions and cache** →
  [api/tracking.md](api/tracking.md)
- **Two-level configuration (settings form + per-bundle third-party settings)** →
  [config/settings.md](config/settings.md)

## What it actually is

- No entities, no fields, no Drush, no plugin types. It provides **2 permissions**
  (`entity_usage_light.permissions.yml`), **1 config object** (`entity_usage_light.settings`,
  schema in `config/schema/`), and dynamic per-entity-type routes/tabs.
- Two permissions: `administer entity_usage_light settings` (gates the settings form) and
  `access entity_usage_light information` (gates every "Usage" tab).
- Settings form `SettingsForm` (`src/Form/SettingsForm.php`, route
  `entity_usage_light.settings`, path `/admin/config/content/entity_usage_light`) toggles
  `active_on.<entity_type_id>`.

## Mechanism (from source)

- `hook_entity_type_alter` → `EntityTypeInfo::entityTypeAlter()` adds a
  `entity_usage_light` link template (`/<type>/{<type>}/usage-light`) to each entity type
  whose `active_on` flag is TRUE and that has an editable edit-form.
- `RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`) creates route
  `entity.<type>.usage_light` for each such link template, controller
  `UsageController::list`, gated by the `access entity_usage_light information` permission.
- `Plugin\Derivative\LocalTask` + `entity_usage_light.links.task.yml` render the "Usage"
  local task; `hook_entity_operation` → `EntityTypeInfo::entityOperation()` adds a "Usage"
  operation (guarded by the access permission).
- `UsageController::list()` (`src/Controller/UsageController.php`) reads the host bundle's
  third-party settings (`entity_type_ids`, `entity_type_views`), walks references via
  `extractEntityIdsFromEntity()` / `extractEntityIdsFromText()`, caches per host entity,
  then renders either a configured View or `getTable()`.

See [api/tracking.md](api/tracking.md) for the detection algorithm and
[config/settings.md](config/settings.md) for the config keys.
