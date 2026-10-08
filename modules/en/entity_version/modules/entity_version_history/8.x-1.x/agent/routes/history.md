<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The version "History" tab

## Install & enable

```bash
drush en entity_version_history -y
```

Depends on `entity_version`. The tab only appears after you configure a **main version field** for a
bundle at `/admin/config/entity-version/settings` (see the parent module's config doc) — and only for
entity types that are revisionable and have a canonical link template.

## How the route is created

1. `entity_version_history_entity_type_alter()` (`entity_version_history.module`) loads all
   `entity_version.settings` config via the config factory (using config factory, not entity storage,
   to avoid an alter-time loop). For each config's `target_entity_type_id`, if the entity type has a
   `canonical` link template **and** `isRevisionable()`, it sets link template
   `entity-version-history` = `{canonical}/history`.
2. `EntityVersionHistoryRouteSubscriber::alterRoutes()` (service
   `entity_version_history.route_subscriber`) iterates all entity type definitions; for each with the
   `entity-version-history` link template it adds a route named
   **`entity.{entity_type_id}.entity_version_history`** with:
   - `_controller` → `EntityVersionHistoryController::historyOverview`
   - `_title_callback` → `EntityVersionHistoryController::title`
   - `_custom_access` → `EntityVersionHistoryController::checkAccess`
   - options `_entity_type_id`, `_admin_route: TRUE`, and a `{entity_type_id}` parameter of
     `type: entity:{entity_type_id}` (so the entity is upcast from the path id).
3. `HistoryLocalTask` deriver (`src/Plugin/Derivative/HistoryLocalTask.php`) adds a **"History"**
   local task (`entity_version_history.entity.history`, weight 20) for every entity type with the link
   template, `base_route => entity.{type}.canonical`. The menu plugin
   (`src/Plugin/Menu/HistoryLocalTask.php`) is a bare `LocalTaskDefault`.

## Access — `checkAccess()`

Returns `AccessResult::forbidden()` unless **all** hold, else `allowed()`:

1. an entity is present in the route (`getEntityFromRouteMatch()` reads the `_entity_type_id` param);
2. an `entity_version_settings` config exists for the entity's **type.bundle**
   (`$storage->load($type.'.'.$bundle)`);
3. the account has the **`access entity version history`** permission.

Cacheability: adds `route` and `user.permissions` contexts, the entity and the config entity as
cacheable dependencies, and the settings-entity list cache tags.

## The page — `historyOverview()`

- Reads the **main version field** name from the bundle's `entity_version_settings`
  (`getTargetField()`) and the entity type's `revision_created` metadata key.
- `getRevisionIds()` finds the field storage's **dedicated revision table** via the table mapping
  (`getDedicatedRevisionTableName()`) and runs:

  ```sql
  SELECT CONCAT(v.{field}_major,'.',v.{field}_minor,'.',v.{field}_patch) AS version,
         MAX(v.revision_id) AS highest_revision_id
  FROM {revision_table} v
  WHERE v.langcode = :lang AND v.entity_id = :id
  GROUP BY version
  ORDER BY highest_revision_id DESC
  ```

  So one row per **distinct** version, keeping the newest revision that carries it, in the entity's
  language. `entity_id`/`langcode` are bound conditions; the column names come from the configured
  field's storage definition (not from request input).
- For each returned revision id it loads the revision, translates it to the display language, and
  builds a row: the version string, a **link** to the revision (`toLink(label, 'revision')`) — or to
  the entity itself for the current/default revision — the `short`-formatted revision date, and the
  revision author via `#theme => 'username'`.
- Renders `#theme => 'table'` (header **Version, Title, Date, Created by**) with the entity type's
  list cache tags, plus a `#type => 'pager'`.

## Notes

- No configuration schema, no forms, no state-changing routes — the tab is read-only (GET), so there
  is no CSRF surface.
- Bundles with a version field but **no** `entity_version_settings` mapping have no tab (both the
  link-template alter and `checkAccess` require the config).
