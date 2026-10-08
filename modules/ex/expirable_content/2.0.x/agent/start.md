<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expirable Content (expirable_content) — agent index

Adds two computed base fields — `expiration_date` and `warning_date` — to any content entity bundle you
configure as expirable, and mirrors them into an internal tracking entity. It **only records dates; it takes
no action** (no cron, no unpublish, no delete). Acting on expiration is left to Views / Rules / ECA / Message.

- **Version:** 2.0.0-rc1 (pre-release). **Core:** `^10.1 || ^11`. **License:** GPL-2.0-or-later. **Package:** Custom.
- **Dependencies:** none declared in `.info.yml`. Views integration is used only when the Views module is present.
- **No composer.json**, no drush commands, no libraries, no submodules.

## What it provides

- **Config entity `expirable_content_type`** (`ExpirableContentType`, config prefix `type`): per-bundle policy
  — `entity_type`, `entity_bundle`, `field` (base date field), `days`, `warn`, `status`. Admin UI at
  `/admin/structure/expirable_content_types`.
- **Internal content entity `expirable_content`** (`ExpirableContent`, `internal = TRUE`): revisionable,
  translatable tracking record holding `expiration`, `warning`, and the source `content_entity_*` ids. No
  routes / no display; not meant to be used directly.
- **Computed base fields** `expiration_date` + `warning_date` (`ExpirableContentFieldItemList`), added to every
  entity of an expirable bundle via `hook_entity_base_field_info()`.
- **Service** `expirable_content.information` (`ExpirableContentInformation`): `isExpirableEntity()` /
  `isExpirableEntityType()`.
- **Entity hooks** (`EntityOperations`): insert/update/delete/revision_delete keep the tracking entity in sync.
- **Views handlers** `expirable_content_field` / `expirable_content_filter` / `expirable_content_sort`
  (`ViewsData` + join trait), added to the target entity's base and revision tables.
- **Permission** `administer expirable_content types` (restrict access) — the only permission; gates the admin UI.

## Solution docs

- [Configuration & the type bundle](config/settings.md) — enabling a bundle, config keys/schema, admin routes/permission.
- [Computed fields & date calculation](fields/computed-dates.md) — how `expiration_date`/`warning_date` are derived.
- [Architecture & API](api/architecture.md) — tracking entity, entity-sync hooks, `information` service.
- [Views integration](views/integration.md) — the field/filter/sort handlers and the join.
