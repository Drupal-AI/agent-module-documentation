<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Google Analytics Cookieless

Route `google_analytics_cookieless.admin_settings_form` at `/admin/config/system/google-analytics-cookieless`.

Config object `google_analytics_cookieless.settings`:
- `account` — UA property id, must match `^UA-\d+-\d+$` or nothing is emitted.
- `js_file_address` — URL of the tracking JS the bundled library loads.
- `anonymise_ip` — passed to `drupalSettings` as `ga_anonymise_ip`.
- `track_logged_in_users` — when false, authenticated users are not tracked.
- `request_path_mode` — 0 = track all except listed pages, 1 = only listed pages, 2 = never (path).
- `request_path_pages` — newline list of paths for the visibility rule.

Emission logic (`hook_page_attachments`): skip if account fails the UA regex, or the path fails `_google_analytics_cookieless_visibility_pages()`, or (`!track_logged_in_users` and the user is authenticated). Otherwise attach `google_analytics_cookieless/google_analytics_cookieless` and set `drupalSettings.google_analytics_cookieless` = {ga_js_file_address, ga_account, ga_anonymise_ip}.

## Permission note
The route requirement is `_permission: 'administer google analytics'` (the classic google_analytics module's permission), but `google_analytics_cookieless.permissions.yml` defines `administer google analytics cookieless`. Install/align the permission you intend to use; otherwise only user 1 can reach the form.
