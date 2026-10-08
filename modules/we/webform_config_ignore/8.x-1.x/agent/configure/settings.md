# Configuration & behavior

There is NO settings form, NO configure route, and NO config object. `webform_config_ignore.settings` does not exist (verified: `drush config:get` errors). Enabling the module is the entire setup; the filter then runs automatically on every config import/export.

## What it does

Implements one plugin: `@ConfigFilter` id `config_webform_ignore`, weight 100
(`src/Plugin/ConfigFilter/WebformConfigFilter.php`). The `config_filter` module
runs this filter as part of the sync storage pipeline (`drush config:import`,
`config:export`, and the core config sync UI).

Matched config names (`matchConfigName()`) — ignored when the name begins with:
- `webform.webform.` — webform entities
- `webform.webform_options.` — reusable options lists

For matched names the filter reads from **active** config storage instead of the
sync/export storage:
- `filterRead` / `filterReadMultiple` — return the active-storage version, so
  import does not overwrite the live webform and export emits the live version
  (effectively keeping it out of a clean deploy diff).
- `filterExists` — a matched name counts as existing if it exists in active
  storage, so import will not delete a production webform that is missing from
  the sync directory.
- `filterListAll` — merges matched active config names into the listing.
- `filterCreateCollection` / `filterGetAllCollectionNames` — the filter applies
  across ALL config collections (e.g. `language.*` overrides), not just default.

New-webform fallback: `activeRead()` returns the incoming `$data` when there is
no active version, so a brand-new webform present only in the sync directory
still imports normally.

## The only control: disable via settings.php

Add to `settings.php` (or a per-environment `settings.local.php`):

```php
$settings['webform_config_ignore_disabled'] = TRUE;
```

When TRUE, every filter method returns data unchanged — webforms sync like any
other config. Default is FALSE (filter active). Read once in the constructor via
`Settings::get('webform_config_ignore_disabled', FALSE)`.

Typical pattern: leave it unset (filter on) in production; set TRUE on
development so you can pull production webforms down and push webform changes up.

## Notes

- Requires the `config_filter` module (^1); webform is not a declared dependency
  in info.yml but the filter only matters when webform config is present.
- The list of ignored patterns is hard-coded (all webforms + all webform
  options). There is no UI or config to ignore only specific webforms.
