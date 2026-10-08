<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Track — capture mechanism & storage

How config changes get recorded. Source: `config_track.module`, `config_track.install`,
`src/EventSubscriber/ConfigTrackSubscriber.php`, `src/Extension/ModuleHandler.php`,
`src/Config/ConfigTrackLanguageConfigOverride.php`.

## Install / enable

`ddev drush en config_track -y`. `hook_install()` (`config_track.install`) queues a batch running
`config_track_init()`, which iterates `\Drupal::configFactory()->listAll()` in chunks of 50 and
inserts one baseline `create` row per config object (uid 0, collection `''`), plus one row per
language override per language when `language` is enabled. This seeds the table so later diffs have
a "previous" to compare against. Uninstall drops the `config_track` table.

## The `config_track` table (hook_schema)

Columns: `revision_id` (serial, PK), `timestamp` (int, request time), `uid` (int, acting user),
`operation` (varchar: `create` / `update` / `delete` / `rename`), `collection` (config collection,
e.g. `''` or `language.de`), `name` (config object name), `data` (big blob — PHP-`serialize`d
config array, or NULL for delete/rename), `debug_backtrace` (big blob). `config_track_update_9001`
added the `debug_backtrace` column.

## Two capture paths, ordered

Config entities and simple config are handled separately so save order is preserved:

- **Simple configuration** — `ConfigTrackSubscriber` subscribes at priority 10 to
  `ConfigEvents::SAVE` (`onConfigSave`), `DELETE` (`onConfigDelete`), `RENAME` (`onConfigRename`).
  `onConfigSave`/`onConfigDelete` early-return when `configManager->getEntityTypeIdByName($name)`
  is non-NULL (i.e. the config belongs to a config entity — handled by the entity path instead).
  When `language` is loaded it also subscribes to `LanguageConfigOverrideEvents::SAVE_OVERRIDE` /
  `DELETE_OVERRIDE`; original override data is read via
  `ConfigTrackLanguageConfigOverride::getOriginalByConfig()` (a subclass exposing the protected
  `originalData`).
- **Config entities** — `Extension\ModuleHandler` decorates core `module_handler`
  (decoration_priority 9). Its `invokeAll()` / `invokeAllWith()` call
  `config_track_entity_presave_first` / `_predelete_first` **before** the inner handler for the
  relevant `{type}_presave` / `{type}_predelete` hooks (detected via
  `getConfigEntityTypeIds()`, built from `entity.last_installed_schema.repository`), and
  `config_track_entity_presave_last` / `_predelete_last` **after** for the generic
  `entity_presave` / `entity_predelete` hooks. The "first" hook stamps uuid + operation; the
  "last" hook fills in `name`, `collection`, current `data` (`$entity->toArray()`) and
  `original_data` (`$entity->original->toArray()`), plus a `debug_backtrace()`. This first/last
  bracketing guarantees Config Track sees the entity's true pre/post state around all other modules.

## Deferred write on shutdown

All captured changes accumulate in a per-request static, `config_track_static()` (a plain `static`
array, deliberately not `drupal_static()` so it survives static-cache clears during `drush updb`).
The first captured change registers `config_track_shutdown()` via
`drupal_register_shutdown_function()`; the subscriber's `onKernelTerminate` (priority 10000 on
`KernelEvents::TERMINATE`) also calls it, so writes happen before service destruction.

`config_track_shutdown()`:
- Bails with a logged `alert` if the `config_track` table is gone (uninstall).
- For each buffered change: converts any `MarkupInterface` values to strings
  (`config_track_convert_markup_to_string`, needed for later YAML dumping); **skips the row when the
  diff is empty** via `ConfigTrackController::isDiffEmpty()` (avoids noise from dependent re-saves);
  stamps `timestamp` + `uid`; `serialize`s `data`; stores `debug_backtrace` **only for anonymous
  requests** (else NULL), and drops it entirely if the installed schema is `< 9001`; inserts the row.
- On any writes, invalidates cache tag `config-revision-list`.

## Operating notes

- No settings; nothing to configure. The report reflects the table directly.
- Rows accumulate on every config change — plan pruning/growth for long-lived sites (no built-in GC).
- The baseline snapshot only runs at install; config that existed before install has a single
  `create` row as its starting point.
