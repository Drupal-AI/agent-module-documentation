# Permissions

From `google_analytics.permissions.yml`:

- `administer google analytics` — access the settings form and perform maintenance. Gates route `google_analytics.admin_settings_form`.
- `opt-in or out of google analytics tracking` — user may toggle tracking on their own profile (shown when `visibility.user_account_mode` is enabled).
- `use PHP for google analytics tracking visibility` — enter PHP code for visibility (`restrict access: true` — security sensitive).
- `add JS snippets for google analytics` — enter the custom "before"/"after" JavaScript code snippets (`restrict access: true` — security sensitive).

Grant the two `restrict access` permissions only to fully trusted roles — they allow arbitrary
PHP/JS execution.
