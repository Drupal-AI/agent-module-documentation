<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, credentials & settings

## Install / enable
```
composer require drupal/cision
drush en cision -y
```
Pulls in dependencies `image`, `media`, `key`, `imagecache_external` and the `embed/embed` PHP library.

## Credentials (Key module)
`config/install/` ships two Key entities, both empty by default with `key_provider: config` and
`key_type: authentication`:
- `key.key.cision_username` (label "Cision Username")
- `key.key.cision_password` (label "Cision Password")

Set their values at `/admin/config/system/keys/manage/cision_username` and
`/admin/config/system/keys/manage/cision_password`. `Api::getAuthToken()` reads them via
`KeyRepository`; if either is empty every API method returns `NULL`. (The shipped provider is `config`;
an admin may switch a key to the env/file provider for stronger secret storage.)

## Settings form
`Drupal\cision\Form\CisionSettingsForm` (`getFormId()` = `cision_cision_settings`), route
`cision.cision_settings` → `/admin/config/services/cision`, permission
`administer site configuration`.

- Single field `placeholder_image_id` (`#type => number`, required) — the id of a **Media** entity used
  as the default placeholder image for the block.
- `validateForm()` rejects the value unless `Media::load($id)` succeeds.
- `submitForm()` saves it to `cision.settings:placeholder_image_id`.

## Config objects
- `cision.settings` → `placeholder_image_id` (integer; note: not covered by a shipped `config/schema`
  entry — only the block settings schema is provided).
- `block.settings.cision_cision_total_mentions` → `sid`, `start_date`, `end_date`, `max_results`
  (per-block instance config; see the block doc).

## Operate
1. Enable module, set both keys, set a placeholder Media id at the settings form.
2. Place the "Cision Total Mentions" block; choose a search, date range, max results, image style, and
   upload/confirm a placeholder image.
3. Responses cache for 1h (`Api::CACHE_EXPIRATION`); the block render caches with `max-age = 3600`.
   Clear caches to force a refresh.
