<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Smart IP Locale Redirect

Settings form: `/admin/config/search/smart_ip_locale_redirect` (permission `access smart IP locale redirect settings`).

## Prerequisites
- Enable and configure `smart_ip` (geolocation data source) and set its "roles to geolocate".
- Enable `redirect`, `locale`, `path_alias`.

## Settings (`smart_ip_locale_redirect.settings`)
- `mappings`: country_code (lowercase ISO) → langcode. Determines the target language per country.
- `cookie_settings`: `duration` (seconds, default 432000), `path` (default `/`), `domain`.
- `excluded_user_agents`: newline-separated regex patterns; matching UAs are never redirected.

## Behaviour notes
- The subscriber runs at KernelEvents::REQUEST priority 256, before RouterListener.
- Redirect is skipped for: admin routes, `entity.node.edit_form`, non-GET/HEAD, maintenance mode, `/sites/default/files/` paths, and excluded UAs.
- The `update_hl` query param sets the language cookie explicitly; the `smart_ip_hl` cookie overrides geolocation on subsequent requests.
- Page cache is killed only while negotiating; once on the correct prefix the subscriber returns early.
