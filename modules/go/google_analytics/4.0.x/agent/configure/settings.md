# Configure Google Analytics

Settings form: `/admin/config/services/google-analytics` (route
`google_analytics.admin_settings_form`, permission `administer google analytics`). Stored in
simple config `google_analytics.settings` (schema in `config/schema/google_analytics.schema.yml`).

## Key config keys (`google_analytics.settings`)
- `account` — one or more GA4 **Measurement IDs** (e.g. `G-XXXXXXXX`); newline-separated for multiple properties.
- `domain_mode` / `cross_domains` — single/sub-domain/multi-domain tracking and the cross-domain list.
- `visibility.request_path_mode` + `request_path_pages` — deny-list (mode 0, default excludes `/admin*`, `/user/*/*`, …) or allow-list (mode 1) of paths.
- `visibility.user_role_mode` + `user_role_roles` — restrict tracking to / from specific roles.
- `visibility.user_account_mode` — 0 off, 1 track-by-default (opt-out), 2 not-tracked-by-default (opt-in); surfaces a toggle on the user profile form.
- `track.outbound`, `track.mailto`, `track.tel`, `track.files` (+ `files_extensions` regex), `track.colorbox`, `track.urlfragments`, `track.site_search`, `track.userid`, `track.displayfeatures` — feature toggles.
- `privacy.anonymizeip` — anonymize visitor IPs.
- `custom.parameters` — custom dimensions/metrics.
- `codesnippet.before` / `codesnippet.after` — raw JS injected before/after the tracker (needs `add JS snippets…` permission).
- `cache` — locally cache gtag.js (refreshed daily via `hook_cron`); `debug` — load uncompressed tracker.

## Deploy as config
Export/import `google_analytics.settings.yml` with `drush config:import`, or set one value with
`drush config:set google_analytics.settings account G-XXXXXXXX`.
