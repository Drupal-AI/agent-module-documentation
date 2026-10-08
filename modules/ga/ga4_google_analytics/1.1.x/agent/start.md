<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GA4 Google Analytics — agent index

Injects the GA4 `gtag.js` snippet site-wide from a single **Measurement ID**, with optional
per-role and per-page visibility. All state is the simple config object
`ga4_google_analytics.config` (no `config/install` default — it does not exist until the
settings form is saved once). No plugins, services, Drush, or field types.

- **Settings keys, config object, visibility (roles/pages), Klaro attributes, drush cget/cset** →
  [configure/settings.md](configure/settings.md)
- **How the snippet is injected (`hook_page_attachments`, theme hook, request_path condition)** →
  [api/injection.md](api/injection.md)
- **The one permission that gates the settings form** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `ga4_google_analytics.config` with keys `measurement_id`,
`scripts_custom_attributes`, `ga4_access_roles` (sequence), `ga4_access_pages`
(request_path mapping: `id`/`negate`/`pages`). Config route
`ga4_google_analytics.configure` at `/admin/config/services/ga4-google-analytics`.
Permission string is the misspelled `ga4 configre`.
