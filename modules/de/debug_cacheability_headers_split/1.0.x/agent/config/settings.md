<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & thresholds

## Install / enable
```
drush en debug_cacheability_headers_split -y
```
No dependencies. The module only has an effect while core's debug cacheability headers are on. Enable those in `settings.php`/`settings.local.php`:
```php
$config['system.performance']['debug_cacheability_headers'] = TRUE;
// or in services.yml: parameters.http.response.debug_cacheability_headers: true
```

## Config object
`debug_cacheability_headers_split.settings` (simple config, shipped in `config/install/debug_cacheability_headers_split.settings.yml`):
- `header_size_limit`: `8192` — a header longer than this many bytes is split.
- `header_chunk_size`: `8000` — max bytes per emitted chunk when splitting.

Note: the module ships no `config/schema`, so these keys are untyped config.

## Settings form
`Form\DebugCacheabilityHeadersSplitSettingsForm` (`ConfigFormBase`), form id `debug_cacheability_headers_split_settings_form`, editable config `debug_cacheability_headers_split.settings`.
- Route `debug_cacheability_headers_split.settings` → `/admin/config/development/settings/cacheability`, title "Debug Cacheability Headers", permission `administer site configuration`. Appears as a local task under the core Development settings page (`system.development_settings`).
- Both fields are `#type => number`, `#required`. `header_size_limit` has `#min` 1024 (`MIN_HEADER_SIZE`); `header_chunk_size` has `#min` 512 (`MIN_HEADER_SIZE / 2`).

## Validation (`validateForm`)
- `header_size_limit` must be ≥ 1024, else error "The header limit must be at least 1024 bytes."
- `header_chunk_size` must be ≥ 512, else error "The max header chunk size must be at least 512 bytes."
- `header_size_limit` must be greater than `header_chunk_size`, else error "The header limit must be greater than the max chunk size."

## Override via settings.local.php
```php
$config['debug_cacheability_headers_split.settings']['header_size_limit'] = 5120;
$config['debug_cacheability_headers_split.settings']['header_chunk_size'] = 5000;
```
Use this to keep thresholds environment-specific without exporting them into site config.
