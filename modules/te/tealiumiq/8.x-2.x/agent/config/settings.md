<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Two config objects, schema in `config/schema/tealiumiq.schema.yml`.

## `tealiumiq.settings`
Form `Drupal\tealiumiq\Form\Settings` at `/admin/config/services/tealiumiq/settings`
(route `tealiumiq.settings`, permission `administer tealium settings`). Install defaults from
`config/install/tealiumiq.settings.yml`.

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `account` | string | `''` | Tealium account; first path segment of the CDN loader URL (unused when `fpd_url` is set). |
| `profile` | string | `''` | Tealium profile; second path segment. |
| `fpd_url` | string (url) | `''` | First-party-domain base URL. When set, loader = `{fpd_url}/{profile}/{environment}/…` and `account` is omitted. Form field is `#type: url`, `#required`, pattern `^https://.*$`. |
| `environment` | string | `dev` | `dev`, `qa`, or `prod`; last path segment. |
| `tag_load` | string | `async` | `async` (JS-injected loader via `hook_page_attachments`) or `sync` (inline `utag_data` + `<script>` via Twig). |
| `sync_load_position` | string | `bottom` | `top` or `bottom` — where the sync block renders (`hook_page_top` / `hook_page_bottom`). Only relevant when `tag_load: sync`. |
| `utagsyncjs_load` | bool | (unset) | Also add `utag.sync.js` to `html_head`. Form field name `enable_utagsyncjs`. |
| `utaganonymous_only` | bool | (unset) | Suppress the loader (utag.js/utag.sync.js) for authenticated users. Form field name `anonymous_only`. |
| `api_only` | bool | `false` | Headless mode: module outputs nothing; build/emit the data layer yourself. |
| `defaults_everywhere` | bool | `true` | Merge `tealiumiq.defaults` values under every page's data layer. |
| `defer_fields` | bool | `false` | If TRUE, entity field tags are applied *after* defaults/events instead of before. |
| `json_encoded` | string | `drp` | `dru` → `Json::encode` (hex-safe), `php` → `json_encode`. The shipped value `drp` matches neither and falls through to `Json::encode`. |

## `tealiumiq.defaults`
Form `Drupal\tealiumiq\Form\Defaults` at `/admin/config/services/tealiumiq/defaults`
(route `tealiumiq.defaults`, permission `manage global tealium tags`). One key per `@TealiumiqTag`
plugin id; values may contain tokens. Install defaults from `config/install/tealiumiq.defaults.yml`:

| Key | Install default |
|---|---|
| `page_name` | `[current-page:title]` |
| `page_url` | `[current-page:url:absolute]` |

The `Defaults` form is rendered by `Tealiumiq::form()` (one fieldset per group, one textfield per tag,
maxlength 255) and includes the Token browser (`token_tree_link`).

## Drush (read/write via core config)
```
drush cget tealiumiq.settings
drush cset tealiumiq.settings account MYACCOUNT -y
drush cset tealiumiq.settings tag_load sync -y
drush cget tealiumiq.defaults
```
