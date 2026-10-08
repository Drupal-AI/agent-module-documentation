<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Version History (entity_version_history) — agent index

Sub-module of **entity_version**. Adds a **"History" local task** to revisionable content entities
whose bundle has a configured main version field, rendering the distinct version numbers across the
entity's revisions in a table. Depends on `entity_version`. Core `^10 || ^11`. GPL-2.0-or-later.
No config of its own.

- **The history route, controller, access, revision query, and the local-task wiring** →
  [routes/history.md](routes/history.md)

## What it provides (from source)

- **Hook** `entity_version_history_entity_type_alter()` (`entity_version_history.module`) — for each
  `entity_version.settings.*` config whose target entity type is revisionable **and** has a canonical
  link template, sets an `entity-version-history` link template at `{canonical}/history`.
- **Route subscriber** `EntityVersionHistoryRouteSubscriber` (service
  `entity_version_history.route_subscriber`) — adds route `entity.{type}.entity_version_history` for
  each entity type with that link template; controller `EntityVersionHistoryController::historyOverview`,
  custom access `::checkAccess`, title `::title`.
- **Controller** `EntityVersionHistoryController` — builds a **Version / Title / Date / Created by**
  table; `getRevisionIds()` runs a grouped query on the field's dedicated revision table for distinct
  `major.minor.patch` values (highest revision id per version, entity language).
- **Local task** `HistoryLocalTask` deriver (`src/Plugin/Derivative/`) + menu plugin
  (`src/Plugin/Menu/`), link `entity_version_history.entity.history` ("History", weight 20).
- **Permission**: `access entity version history`. **Config schema**: none. **Drush**: none.

## Route & access

- Path: `{entity canonical}/history` (e.g. `/node/{node}/history`), `_admin_route: TRUE`.
- Access (`checkAccess`): entity present in route **and** an `entity_version_settings` mapping exists
  for its type+bundle **and** the account has `access entity version history`.
