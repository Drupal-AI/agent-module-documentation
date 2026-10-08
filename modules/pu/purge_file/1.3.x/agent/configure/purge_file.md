# Configure Purge File

## Route / UI

- Config route: `purge_file.settings` (the module's `configure` route).
- Path: `/admin/config/development/performance/purge-file` (a local task tab under
  *Configuration > Development > Performance*).
- Permission: `administer site configuration` (core; the module defines none of its own).
- Form: `Drupal\purge_file\Form\SettingsForm`.

## Config object: `purge_file.settings`

Default install values (`config/install/purge_file.settings.yml`):

```yaml
workflow: queue
wildcard: false        # legacy; removed by update 10002, replaced by invalidation_type
debug: false
base_urls: ''
invalidation_type: url
```

Keys:

| Key | Type | Values | Meaning |
|---|---|---|---|
| `workflow` | string | `immediate` \| `queue` | `immediate` = invalidate at once via the module's immediate processor; `queue` = add to the Purge queue for later processing (e.g. cron). Required. |
| `invalidation_type` | string | `url` \| `path` \| `wildcardurl` \| `wildcardpath` | Which Purge invalidation plugin to build. Must be one enabled by a purger or nothing is purged. Required. |
| `base_urls` | string | comma-separated | Base URLs to prepend for `url`/`wildcardurl` types (e.g. split front/back-office domains). Empty → uses the current request scheme+host+base path. Ignored for `path`/`wildcardpath` (relative paths). |
| `debug` | bool | | Log every file purge and the exact URLs sent to Purge (channel `purge_file`). Debug only. |
| `wildcard` | bool | | Legacy pre-1.x-10002 flag; superseded by `invalidation_type`. Update 10002 maps `wildcard: true` → `wildcardurl`, else `url`. |

Set via Drush:

```bash
drush config:set purge_file.settings workflow immediate -y
drush config:set purge_file.settings invalidation_type wildcardurl -y
drush config:set purge_file.settings base_urls 'https://cdn.example.com,https://www.example.com' -y
drush config:set purge_file.settings debug 1 -y
```

## How it works (behavior, no config needed to trigger)

- Hooks `hook_file_insert`, `hook_file_update`, `hook_file_delete` call `purge_file_purge()`.
- On **update** it only purges if the file's URI or size changed; if the resulting file
  URL differs from the original, the original URL is purged too.
- Files in the `temporary://` stream are skipped.
- Purging is a no-op (returns FALSE) if: no URL-capable purger is enabled, `workflow` is
  empty, or the selected `invalidation_type` is not among the enabled purger types.
- Wildcard behavior: when `invalidation_type` is `wildcardurl`/`wildcardpath` (and that
  type is enabled), a `*` is appended to each purge URL.

## Plugins it provides to Purge (not new plugin types)

- Processor `purge_file_immediate_processor` (used when `workflow: immediate`).
- Queuer `purge_file_queuer` (used when `workflow: queue`; pair with a queue processor
  such as `purge_processor_cron`).

## Status report

`hook_requirements` (runtime) adds *"Purge file: URL Purgers enabled"* — ERROR if no
purger supports any of `url, wildcardurl, path, wildcardpath`, otherwise OK listing the
enabled ones.
