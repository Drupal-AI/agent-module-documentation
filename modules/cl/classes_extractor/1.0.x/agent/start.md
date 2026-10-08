<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Classes Extractor (classes_extractor) — agent index

Developer utility that **collects CSS class names that are already stored in Drupal configuration**
and exports the deduplicated list. It does **not** scan CSS files, source code, or "modules", and it
renders nothing. A pluggable extraction system walks specific config entities/objects and pulls out
values whose array key contains `class`/`classes`/`attributes`; the union is written to a file (via
Drush) or returned as JSON (via an admin-only route). Typical use: build a safelist for a CSS
optimiser (Tailwind/PurgeCSS) from classes an editor configured in the CMS. Installed **1.0.1**
(version dir `1.0.x`). Core `^10 || ^11`. License GPL-2.0-or-later.

## Dependencies

- **None declared.** `classes_extractor.info.yml` lists no `dependencies:`, no `composer.json`,
  no PHP-library requirement. Individual plugins *soft-check* for optional modules at runtime
  (Display Suite `ds`, `layout_builder`, `filter`, `views`) — see extraction.md.
- `.module` file is an empty stub (no hooks). No `.install`, `.permissions.yml`, `.libraries.yml`,
  and **no `config/` schema** (the config object `classes_extractor.configform` is unschema'd).

## What it provides (from source)

- **Plugin type** `classes_extractor` — manager `ClassesExtractorPluginManager`
  (service `plugin.manager.classes_extractor`, namespace `Plugin/ClassesExtractor`, annotation
  `@ClassesExtractor` with `id`/`label`, interface `ClassesExtractorPluginInterface::getClasses(): array`,
  base `ClassesExtractorBase`). Four built-in plugins ship: `ds_classes_extractor`,
  `editor_formatter_classes_extractor`, `entity_display_classes_extractor`, `views_classes_extractor`.
- **Aggregator service** `classes_extractor.manager` (`ClassesExtractorManager`, arg
  `@entity_type.manager`) — `getAllClasses()` instantiates every plugin, calls `getClasses()`,
  splits on whitespace/`|`, dedupes (`array_unique`+`array_filter('strlen')`), returns a
  **space-separated string**; `recursiveGetClasses()` is the shared config-walker helper.
- **Config form** route `classes_extractor.settings` → `/admin/config/classes-extractor`
  (`Form/ClassesExtractorConfigForm`, `ConfigFormBase`), permission **`administer site configuration`**,
  `_admin_route: TRUE`. Single field **`file_path`** (textfield, required, max 255, displayed with a
  read-only `DRUPAL_ROOT . '/'` prefix that is *not* stored) saved into config object
  **`classes_extractor.configform`**. This is the route named by `configure:` in info.yml.
- **API route** `classes_extractor.api` → `GET /api/v1/classes-extractor`
  (`Controller/ClassesExtractorController::getClasses`), permission **`administer site configuration`**.
  Returns a `CacheableJsonResponse` `{ "classes": "<space-separated list>" }`. No request input.
- **Drush command** `class_extractor:create` (alias **`cec`**, `Drush/ClassesExtractorCommands`,
  tag `drush.command`) — reads `file_path` from `classes_extractor.configform`, runs
  `getAllClasses()`, and `file_put_contents($file_path, $classes)`; writes an info log line.

## Correcting the stub / README

- The README ("extract Backend classes from **specified modules**") and any "scan the modules you
  select" wording are **inaccurate**. There is no module selector and no module scanning — the only
  configurable option is the output `file_path`. Sources are the fixed set of config entities the
  four built-in plugins read.
- The JSON endpoint is **`/api/v1/classes-extractor`** (admin-permission gated), **not**
  `/api/extracted-classes` and **not** public.
- The config object holding settings is **`classes_extractor.configform`**; `classes_extractor.settings`
  is the *route* name.

## Solution docs

- **Plugin system, the four built-in extractors, the recursive class-walker, and how to add a custom
  extractor** → [extraction.md](extraction.md)
