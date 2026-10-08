# Cookie Consent Notice by CookieYes — agent index

Injects the third-party **CookieYes** consent-management `<script>` into every front-end page
from an admin form. No dependencies, no config schema, no Drush, no plugins, no submodules.
Requires a CookieYes (external SaaS) account for the actual script/banner.

- **Settings form, config keys, the injection logic, and two shipped defects to work around** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `cookie_consent_notice_by_cookieyes.settings`: `scripts` (pasted `<script>` snippet),
  `enable` (bool).
- Permission `cookieyes_scripts_settings` (`restrict access: TRUE`); config UI route
  `cookie_consent_notice_by_cookieyes.admin` → `/admin/config/development/cookie_consent_notice_by_cookieyes`.
- `hook_page_attachments_alter()` injects the script into `<head>` on non-admin routes only,
  when `enable` is set and `scripts` non-empty; regex extracts `src=` and optional `id=` (default `cookieyes`).
- BUG: route `_form` targets a non-existent class `\Drupal\cookieyes_scripts\Form\BodyForm`
  (real class namespace is `cookie_consent_notice_by_cookieyes`) → settings page errors.
- BUG: default config file `config/install/cookie_consent_notice_by_cookieyes.settings` lacks
  the `.yml` extension → no default config installed.
