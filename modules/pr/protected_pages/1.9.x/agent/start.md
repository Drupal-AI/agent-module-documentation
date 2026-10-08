# protected_pages — agent start

Password-protects specific paths/pages (and private-file paths) with a per-path prompt that
is separate from Drupal user accounts. A response event subscriber redirects a visitor to a
`/protected-page` password form; a correct password unlocks the path for the session. Protected
paths live in the `protected_pages` DB table (service `protected_pages.storage`); text/password/
session settings live in the `protected_pages.settings` config object. Depends on core
`path_alias`. Admin UI: **Admin → Config → System → Protected Pages**
(`/admin/config/system/protected_pages`); settings route `protected_pages_settings`.

- Add a protected path + password, global settings, session length, prompt text, email → [configure/protected_pages.md](configure/protected_pages.md)
- Permissions (bypass, access screen, administer) → [permissions/protected_pages.md](permissions/protected_pages.md)
- Storage service & how the redirect/unlock works in code → [api/protected_pages.md](api/protected_pages.md)
