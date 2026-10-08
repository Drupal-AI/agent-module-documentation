# W3C Validator — agent index

Validates site pages (front + nodes, optionally admin/router pages) against a configured W3C Markup
Validator endpoint and reports HTML validity. Wraps `rexxars/html-validator`. Report at
`/admin/reports/w3c_validator` (the `configure` route). Config schema present; no Drush.

- **Settings (`validator_url`, `use_token`, `admin_pages`), the report & batch validation flow** →
  [configure/settings.md](configure/settings.md)
- **Permissions and routes** → [permissions/permissions.md](permissions/permissions.md)
- **The token auth provider used to validate access-restricted pages "as a user"** →
  [api/token-auth.md](api/token-auth.md)

Key facts:
- Config `w3c_validator.settings`: `validator_url` (''), `use_token` (TRUE), `admin_pages` (FALSE).
  Empty `validator_url` -> library default (`validator.nu`).
- Core service `w3c.processor` (`W3CProcessor`): `findAllPages()`, `validatePage()`,
  `validateAllPages()` (batch), results stored in the `w3c_validator` table.
- Access: all routes require `administer w3c_validator` (`restrict access: true`); report/confirm also
  allow `access site reports`.
- Validation targets the SITE's own pages; the endpoint is admin-configured behind a restricted
  permission, so there is no low-privilege SSRF (no security note warranted).
