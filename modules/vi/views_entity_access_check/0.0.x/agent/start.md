<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views entity_access check (views_entity_access_check) — agent index

Implements **`hook_views_pre_render()`** and, for each view whose machine name is listed in config,
walks `$view->result` and calls **`$row->_entity->access('view')`** for the current user, `unset()`ing
every row that fails. No plugin, no field handler, no query alteration — one hard-coded loop.
Depends on core `views`. Version **0.0.4** (`0.0.x` — deliberately never stable).
Core requirement `^8.9 || ^9 || ^10 || ^11`. Maintained by DROWL.

## What it is for
The gap it addresses is one of Drupal's oldest, and the module names it: core issue **777578**, open
since 2010.
- Views filters its **SQL query** using **node access grants** (nodes) or `hook_query_TAG_alter()`
  (other entities) — both SQL-level.
- `hook_entity_access()` / `hook_node_access()`, where many access modules decide in **PHP** when code
  calls `$entity->access('view')`, is **not consulted for listings**.
- So a view can list entities the viewer cannot open — title, row fields and often a teaser rendered,
  access-denied on click. This module drops those rows after the query.

## Mechanism (exact)
- File: `views_entity_access_check.module`, function `views_entity_access_check_views_pre_render()`.
- Reads `views_entity_access_check.settings:views` (a sequence of view machine names).
- If `in_array($view->id(), $handleViews)`, loops results:
  `if (!empty($value->_entity) && !$value->_entity->access('view')) { unset($view->result[$key]); }`.
- Operation is **always `'view'`**, account is **always the current user** (no `$account` passed).
- `access('view')` returns a boolean here (default `$return_as_object = FALSE`).

## Configuration
- Settings form route `views_entity_access_check.settings_form` at
  `/admin/config/system/views-entity-access-check`, menu link under System.
- `SettingsForm` (`src/Form/SettingsForm.php`) is a `ConfigFormBase`; a multi-select of all views
  (`Views::getAllViews()`), stored as a list of view IDs.
- The route requires permission `administer views_entity_access_check configuration`, but the module
  **defines no `.permissions.yml`** — that permission is never declared, so only user 1 can reach the
  form on a stock install (`provides_permissions` is false).
- Config schema: `config/schema/views_entity_access_check.schema.yml` (`views` sequence of strings).

## Two consequences of filtering after the query — plan for both
1. **Pager / total count are wrong.** They are computed from the unfiltered query; a page of ten can
   show fewer, and the total is off.
2. **One entity load + access check per row** — exactly the work the query avoided. Enable per-view,
   only where needed, never globally. The settings form itself warns it "impacts performance and
   caching."

## Files
- `views_entity_access_check.module` — the entire behavior (one hook).
- `src/Form/SettingsForm.php` — the config form.
- `*.routing.yml`, `*.links.menu.yml`, `config/schema/*.schema.yml`, `*.info.yml`.

## Solution types
- `views/` — enabling and mechanics of the row-level entity access filter.
