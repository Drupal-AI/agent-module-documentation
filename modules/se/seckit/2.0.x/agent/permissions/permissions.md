# Security Kit permissions

From `seckit.permissions.yml`:

- `administer seckit` (restricted) — configure all Security Kit features (the settings form
  at `/admin/config/system/seckit`).

Note: the CSP violation report endpoint `/report-csp-violation` (route `seckit.report`) is
intentionally open (`_access: TRUE`) so browsers can POST reports to it.
