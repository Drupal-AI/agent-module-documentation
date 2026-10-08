# Matomo settings

Form `matomo.admin_settings_form` at `/admin/config/system/matomo`; permission
`administer matomo`. Stored in config `matomo.settings` (`config/schema/matomo.schema.yml`),
so it exports with `drush config:export`. Key sections (see `config/install/matomo.settings.yml`):

| Section | Keys | Purpose |
|---|---|---|
| Server | `site_id`, `url_http`, `url_https` | Matomo site ID and instance URLs. Required. |
| Visibility | `visibility.request_path_mode` + `request_path_pages`, `user_role_mode` + `user_role_roles`, `user_account_mode` | Where/who to track: path allow/deny lists, role lists, and per-user opt-in/out. |
| Track | `track.mailto`, `track.files` + `files_extensions`, `track.colorbox`, `track.userid`, `track.site_search`, `track.messages` | Which events/links/downloads to record. |
| Privacy | `privacy.donottrack`, `privacy.disablecookies` | Honor DNT; cookie-less tracking. |
| Custom | `custom.variable` | Custom variables/dimensions sent on every hit. |
| Code snippet | `codesnippet.before`, `codesnippet.after` | Raw JS injected around the tracker (gated by `add js snippets for matomo`). |
| Advanced | `page_title_hierarchy`, `translation_set`, `disable_tracking`, `cache` | Title hierarchy, disable switch, and local caching of `matomo.js`. |

Notes:
- `request_path_pages` defaults to excluding `/admin`, `/admin/*`, `/batch`, `/node/add*`,
  `/node/*/*`, `/user/*/*`.
- With `cache: true`, matomo.js is stored locally and refreshed on cron
  (`hook_cron` → `matomo_clear_js_cache()`).
- The snippet is emitted via `hook_page_attachments`; `use php for matomo tracking
  visibility` allows PHP-snippet visibility rules (restricted permission).
