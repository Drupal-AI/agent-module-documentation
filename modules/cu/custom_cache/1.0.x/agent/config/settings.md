<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_cache — configuration (settings.php only)

There is **no admin form, no config entity, no config schema, and no permissions**. Everything is
read at runtime from Drupal's `Settings` (i.e. `$settings[...]` in `sites/default/settings.php`),
via `Drupal\Core\Site\Settings::get()`.

## Install / enable
```
composer require drupal/custom_cache
drush en custom_cache
```
Enabling the module only registers the `cache.backend.custom_cache` service. Nothing changes until
you assign it to a bin.

## 1. Assign the backend to cache bins
The backend takes effect per bin. In `settings.php`:
```php
$settings['cache']['bins']['render']              = 'cache.backend.custom_cache';
$settings['cache']['bins']['dynamic_page_cache']  = 'cache.backend.custom_cache';
$settings['cache']['bins']['page']                = 'cache.backend.custom_cache';
```
Any bin you do not list keeps its normal backend. Because the backend extends core
`DatabaseBackend`, entries are still stored in the standard `cache_<bin>` database tables — this is
a lifetime-capping backend, not an alternate store (it does not replace Redis/Memcache; it replaces
the *database* backend).

## 2. Set the TTL cap — `custom_cache_melt_time`
```php
$settings['custom_cache_melt_time'] = 86400; // seconds; default 86400 (1 day)
```
Read in `CustomCacheDatabaseBackend::setMultiple()`. Any item written with
`expire === Cache::PERMANENT` (or no `expire`) is rewritten to
`\Drupal::time()->getRequestTime() + custom_cache_melt_time`. Items that already have a finite
expiry are left unchanged. If the setting is absent, the code default `86400` applies.

Choose the value against **acceptable staleness**: a missed invalidation becomes visibly wrong for
up to this long before it self-corrects. Too short and you lose the caching benefit (more
recomputation); too long and it masks real invalidation bugs.

## 3. Keep chosen cids permanent — `custom_cache_exclude_cids`
```php
$settings['custom_cache_exclude_cids'] = [
  '/node/',
  '/taxonomy/term/',
  '/sites/default/files/',
  '/user/',
];
```
Read in `setMultiple()`. Each entry is a **substring**; the intent is that if a cid *contains* any
listed substring, that item is not written by this backend (kept at its original lifetime). Default
is `[]` (exclude nothing). **Caveat:** as implemented the skip does not reliably take effect — the
excluded item is still added to the write batch (see [../api/cache-backend.md](../api/cache-backend.md)
for the exact `continue`/fall-through quirk), so do not rely on this list to protect a cid.

## Removing it
Revert the `settings.php` lines (and optionally `drush pmu custom_cache`). Because there is no config
or schema, nothing else needs cleanup; a cache rebuild (`drush cr`) repopulates bins with the normal
backend.

See [../api/cache-backend.md](../api/cache-backend.md) for the class-level behaviour and the
`hook_custom_cache_cid_alter` extension point.
