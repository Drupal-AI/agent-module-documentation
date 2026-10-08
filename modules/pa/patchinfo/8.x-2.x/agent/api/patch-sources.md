# Patch collection mechanism, `PatchInfoSource` plugins, DB, drush (API)

How patch information is gathered, stored, rendered and queried. Everything below is in
`patchinfo.module`, `patchinfo.install`, `src/`, and the three submodules. patchinfo defines **no
routes and no permissions of its own** — it only augments the core `update` module's admin pages.

## Collection pipeline — `hook_system_info_alter`

`patchinfo_system_info_alter($info, Extension $file, $type)` (`patchinfo.module:21`) fires for every
extension whose `.info.yml` is parsed. For each scanned extension it:

1. Loads every source plugin from `plugin.manager.patchinfo_source`, `createInstance()`s it, and
   calls `->getPatches($info, $file, $type)`, merging the results (`array_merge_recursive`).
2. Deletes the old rows for that extension: `_patchinfo_clear_db($file->getName())` removes
   `patchinfo` rows where `source_module = <scanned extension>` (`patchinfo.module:162`).
3. Writes the fresh rows: `_patchinfo_process_module($source_module, $module, $info)`
   (`patchinfo.module:276`) — for each patch it splits a leading URL out of the free-text `info`
   (kept only if `filter_var($first, FILTER_VALIDATE_URL) !== FALSE`), then `merge()`s a row keyed by
   `(source_module, module, id)` where `id = arrayIndex + 1`.

So the table is a cache of "extension X declares a patch against module Y". `source_module` is who
*declared* the patch; `module` is the patched target (they differ, e.g. a submodule declaring a
patch for its parent, or root `composer.json` declaring a patch for `system`/core).

## Storage — the `patchinfo` table (`hook_schema`)

`patchinfo.install:13`. Columns: `module` varchar(50), `id` int (patch index within a module),
`url` text, `info` text, `source_module` varchar(50), `source` text. Primary key
`(source_module, module, id)`. Reads/writes use the DB query builder (`merge`/`select`/`delete` with
`condition()`/`keys()`/`fields()`) — parameterized, no raw SQL. Update hooks `patchinfo_update_8201..8204`
add the `source_module`/`source` fields and re-index for upgrades from `8.x-1.x`; `_8204` auto-enables
`patchinfo_source_info` for 8.x-1.x compatibility.

## Read helpers

- `_patchinfo_get_info($raw = FALSE)` (`patchinfo.module:219`) — returns all rows keyed by target
  `module`. With `$raw = TRUE` each entry is `['url','info','source']` (used by drush). With
  `$raw = FALSE` each entry is a render-safe value: a `Link::fromTextAndUrl($text, Url::fromUri($url))`
  when a URL exists, else `Html::escape($info)`; when `source` is set it is wrapped as
  `t('@text <abbr title="@source">(src)</abbr>')`. Output is escaped via `t()` placeholders /
  `Html::escape`, and `Url::fromUri` strips dangerous protocols at render time.
- `_patchinfo_get_patches($patch_info, $project_info)` (`patchinfo.module:193`) — collapses patches
  for a single update-manager project across all of its `includes` (submodules) into one flat list.

## Rendering surfaces — all on the core `update` module's admin pages

patchinfo adds **no page of its own**; it alters update-module output (which requires the
`administer software updates` / update-report admin permissions):

- `patchinfo_form_update_manager_update_form_alter` (`:59`) — injects a `#theme => patchinfo_patches`
  list into each project row of the update manager form (`/admin/reports/updates/update`), and a
  warning above `manual_updates` when core itself is patched.
- `patchinfo_theme_registry_alter` (`:346`) + `patchinfo_preprocess_update_report` (`:380`) +
  `patchinfo_preprocess_update_project_status` (`:398`) — repoint the `update_report` and
  `update_project_status` templates to this module's `templates/` and add `patches` /
  `excluded_modules` variables on the status report (`/admin/reports/updates`). The registry alter
  also reorders/removes update's own preprocess so patch keys survive update's `sort()` (handles the
  Drupal 11.2+ `UpdateThemeHooks` initial-preprocess change).
- `patchinfo_update_projects_alter` (`:49`) — drops any project listed in config
  `patchinfo.settings:exclude from update check` from the update check entirely.
- `patchinfo_form_update_settings_alter` (`:121`) — adds the **"Exclude modules from update check"**
  textarea to update's settings form (route `update.settings`, the module's `configure` route);
  submit handler `patchinfo_update_settings_form_submit` (`:142`) saves the newline-split list to
  `patchinfo.settings`.

Themes registered (`patchinfo_theme`, `:328`): `patchinfo_patches`, `patchinfo_excluded_modules`
(templates in `templates/`). Library: `patchinfo/patchinfo` (`css/patchinfo.css`).

## Plugin type — `PatchInfoSource`

The one plugin type patchinfo defines. Each plugin turns one storage location into patch records.

- Manager service: `plugin.manager.patchinfo_source` (`Drupal\patchinfo\PatchInfoSourceManager`,
  extends `DefaultPluginManager`; `patchinfo.services.yml`).
- Discovery dir: `Plugin/PatchInfo/Source`. Interface: `Drupal\patchinfo\PatchInfoSourceInterface`.
  Base class: `Drupal\patchinfo\PatchInfoSourceBase` (injects `logger.factory`).
- Annotation: `@PatchInfoSource(id, label)` (`Drupal\patchinfo\Annotation\PatchInfoSource`).
- Alter hook: **`hook_patchinfo_source_alter(&$definitions)`** (`alterInfo('patchinfo_source')`);
  cache bin key `patchinfo_source`.

Interface contract:

```php
// Drupal\patchinfo\PatchInfoSourceInterface
public function getLabel();
public function getPatches(array $info, Extension $file, string $type);
```

`getPatches()` returns an array keyed by **target module machine name**, each an integer-indexed list
of `['info' => '<url> <description>', 'source' => '<human-readable origin>']` (URL optional). Example:

```php
$return['pathauto'][] = [
  'info'   => 'https://www.drupal.org/node/1739718 Issue 1739718, Patch #32',
  'source' => 'modules/contrib/pathauto/pathauto.info.yml',
];
```

### Bundled source plugins (in submodules)

| Plugin id | Class | Submodule | Reads |
|---|---|---|---|
| `patchinfo_info_yml` | `InfoYmlSource` | `patchinfo_source_info` | the `patches:` YAML list in each `*.info.yml` (legacy 8.x-1.x format). Malformed (unquoted, colon-bearing) entries are logged and replaced with a warning string. |
| `patchinfo_composer` | `ComposerJsonSource` | `patchinfo_source_composer` | `extra.patches` / `extra.patches-file` in `composer.json` (assumes `cweagans/composer-patches`); **only `drupal/*` packages**; `drupal/core`+`drupal/drupal` map to `system`, and for `system` it also scans root, `../`, and `core/` composer.json. |

### Write your own source

Create `my_module/src/Plugin/PatchInfo/Source/MySource.php` extending `PatchInfoSourceBase`, annotate
`@PatchInfoSource(id = "my_source", label = @Translation("My source"))`, implement `getPatches()`
returning the shape above, then enable your module and clear caches. It participates automatically via
`hook_system_info_alter`.

## Drush commands

| Command | Aliases | Class / service | Notes |
|---|---|---|---|
| `patchinfo:list` | `pil`, `patchinfo-list`, `pi-list` | `Drupal\patchinfo\Commands\PatchInfoCommands` (service `patchinfo.commands`, arg `@update.manager`) | Reports patches per project. Options `--projects=<a,b>`, `--format=<table|yaml|csv|…>`, `--fields=` from `name,label,delta,info,url,source`. Joins `_patchinfo_get_info(TRUE)` against `update.manager->getProjects()`. |
| `patchinfo_drupalorg:list` | `patchinfo-do-list` (`@hidden`) | `PatchInfoDrupalorgCommands extends PatchInfoCommands` (submodule `patchinfo_drupalorg`) | Same rows, enriched with drupal.org issue metadata (title/status/priority/category/author/dates). |
| legacy `patchinfo-list` | `pil`, `pi-list` | `patchinfo.drush.inc` (`hook_drush_command`, Drush 8 style) | Same data; also runs `drush_command_invoke_all_ref('patchinfo_list_row_alter', …)`. |

`patchinfo_drupalorg` issue lookup: `PatchinfoDrupalorgService::getIssue($issue_number)` parses the
issue id out of the patch text with regex (`(?P<issuenumber>\d+)`, digits only), then fetches
`https://www.drupal.org/api-d7/node.json?nid=<n>` via `http_client_factory` (host hard-pinned,
default TLS, `timeout: 10`), caching the result for ~3700s in `cache.default`. CLI-only.

## Integrator hook

`hook_patchinfo_list_row_alter(array &$patchinfo_list_row, array $patch)` (`patchinfo.api.php`) — lets
a module add/edit columns of the legacy drush `patchinfo-list` output.

## Config

`patchinfo.settings` (`config/schema/patchinfo.schema.yml`): single key `exclude from update check`,
a `sequence` of module machine names. Default install value `[]`. Edited via the update settings form
textarea (above), read by `patchinfo_update_projects_alter` and the excluded-modules report notice.
