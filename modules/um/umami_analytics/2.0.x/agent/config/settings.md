<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# umami_analytics — settings

Single config object **`umami_analytics.settings`** (schema `config/schema/umami_analytics.schema.yml`,
defaults `config/install/umami_analytics.settings.yml`). Edited via the form at
`/admin/config/services/umami-analytics` (route `umami_analytics.admin_settings_form`,
`SettingsForm`, permission **`administer umami analytics`**, `restrict access: true`).

## Keys the emitted tracker actually uses
| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `src` | string | `''` | Umami script URL (e.g. `https://umami.example.com/script.js`). **Required** — nothing is injected while empty. Rendered as the `<script src>`. |
| `website_id` | string | `''` | Umami site UUID. **Required** — nothing is injected while empty. Rendered as `data-website-id`. |
| `script_mode` | string | `onload` (new installs) | `onload` = deferred inline bootstrap appended on `window.load`; `async_defer` = plain `<script async defer>`. Missing key falls back to `async_defer`. |
| `domain_mode` | integer | `0` | `1` emits `data-domains`; `0` omits it. |
| `domains` | string | `''` | Comma-separated domain list, emitted as `data-domains` only when `domain_mode == 1`. |
| `visibility.request_path_mode` | integer | `0` | `0` = track everywhere **except** listed paths; `1` = track **only** listed paths. |
| `visibility.request_path_pages` | string | admin/batch/node-edit/user paths | One path per line; `*` wildcard; `<front>` token; matched against path and alias, case-insensitive. |
| `visibility.user_role_mode` | integer | `0` | With roles selected: `0` = track only selected roles; `1` = track all except selected. Empty selection = track all. |
| `visibility.user_role_roles` | sequence | `{}` | Role IDs to include/exclude. |

## Keys present in schema but INERT in 2.0.0-beta4 (do not rely on them)
`host_url`, `auto_track`, `do_not_track`, `cache`, `local_cache` — stored in config/schema
but never read into the emitted `<script>`. `local_cache` (+ `hook_cron` daily sync in
`JavascriptLocalCache`) is stubbed: `hook_cron()` returns immediately (`@TODO`) and the form's
Advanced/`local_cache` section is unreachable dead code after an early `return parent::buildForm()`.
`fetchJavascript()` consequently always returns the remote `src` unchanged.

## Set from the CLI
```
drush cset umami_analytics.settings src 'https://umami.example.com/script.js' -y
drush cset umami_analytics.settings website_id 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' -y
```
