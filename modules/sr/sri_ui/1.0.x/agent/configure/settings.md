<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — SRI settings (`/admin/config/services/sri`)

Route `sri_ui_config.admin_config_sri`, form `Drupal\sri_ui\Form\AdminSettingsForm`
(`getFormId()` = `sri_ui_settings_form`), permission `administer site configuration`. Editable config:
`sri_ui.settings`. There is **no `config/schema/`** — the config is written verbatim by the form, so
values are not schema-typed.

## Config keys (`sri_ui.settings`)

- `status` — int `0`/`1`. Master switch. Default install value is **`0` (off)**; both apply-hooks
  early-return unless `status == 1` (`sri_ui_integrity_status()`).
- `key_refresh_timout` — string seconds (default `'3600'`). Minimum gap between auto refreshes in the
  per-request path. Form field `key_refresh_timout`, validated integer by `::validateTimestamp`
  (`AdminSettingsForm.php:166`).
- `last_refresh_timout` — unix timestamp of the last successful auto refresh. Hidden field
  (`#access => FALSE`); set by the service after a refresh that changed something.
- `assets` — list; one entry per external URL. Each entry has:
  - `asset` — full external URL, e.g. `https://static.addtoany.com/menu/page.js`. **Must match**
    exactly the key/`src` Drupal uses for the asset (see "why it may not apply").
  - `integrity` — the `sha256-…` (or other) checksum. Left blank it will be filled by the next
    hash-refresh run; you can also paste one from https://www.srihash.org/.
  - `crossorigin` — e.g. `anonymous`. **Required for SRI to actually work**: the browser needs a
    CORS-mode fetch and the host must send permissive CORS headers; without it a hashed script
    *fails to load* rather than merely failing to verify.
  - `query_string` — optional cache-buster appended to the emitted `src` (e.g. `v1`).
  - `is_check_update` — checkbox "Auto hash refresh on page request." Only entries with this ON are
    considered by the per-request subscriber path.
  - `add_async` — checkbox; when set, an `async` attribute is added to the tag.

`submitForm()` trims every field, drops rows whose `asset` is empty, and re-indexes. It stores
`is_check_update`, `add_async`, `asset` always, and `integrity`/`crossorigin`/`query_string` only when
non-empty (`AdminSettingsForm.php:80-108`). The form always renders an extra empty "New Asset"
details group to add one more entry per save.

## How the attributes get applied (both require `status == 1`)

1. `hook_library_info_alter()` (`sri_ui.module:13`) — walks every library's `js` and `css` entries;
   for entries with `type == 'external'` it looks up `sri_ui_get_integrity($key)` where `$key` is the
   library entry key (for external assets, the URL as declared in the module's `*.libraries.yml`). On a
   match it merges `integrity`/`crossorigin`/`async` into the entry `attributes` (existing attributes
   win via `+=`). The `query_string` value is *not* used on this path (it is unset).
2. `hook_page_attachments_alter()` (`sri_ui.module:117`) — walks `#attached['html_head']` and
   `['html_footer']` render arrays; for `#tag == 'script'` elements whose `#attributes['src']` is
   external (`UrlHelper::isExternal`) and matches a configured `asset`, it merges the same attributes
   and, if `query_string` is set, appends `?<query_string>` to the `src`. It also attaches cache tag
   `sri_ui:library_attachments_cache_tag`.

**Why an entry may not apply:** (a) `status` is off; (b) the asset is not declared as
`type: external` (locally hosted/aggregated assets are skipped); (c) the `asset` URL does not match the
key/`src` byte-for-byte (path 1 matches on the library entry *key*, path 2 on the rendered `src`); (d)
you added the entry but did not rebuild caches — the form's own markup reminds you to "clear all caches
to reflect new sri option in frontend after saving this form."

## Drush / cron / auto-refresh

Hashes are (re)computed by `sri_ui.hashgeneration`; see [../api/services.md](../api/services.md) for the
`check_all` (cron + Drush) vs `check_one_by_one` (per-request, throttled by `key_refresh_timout`)
behaviour and the `file_get_contents` fetch of each configured URL.
