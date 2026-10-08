# security_review — agent start

Runs a checklist of ~20 plugin-based security/configuration checks and reports pass/fail/warn
results in the admin UI, on the Status Report, and via Drush. It **reports** issues — it does
not fix them. Checks are `SecurityCheck` plugins; results live in Drupal **state**, settings in
config `security_review.settings`.

- Run/review UI, settings form, config keys, marking untrusted roles, skipping/hushing checks → [configure/settings.md](configure/settings.md)
- The `SecurityCheck` plugin type + how to add a custom check → [plugins/security_check.md](plugins/security_check.md)
- Services & programmatic API (`security_review`, plugin manager, CheckResult) → [api/services.md](api/services.md)
- `drush secrev` command, options, CI usage → [drush/secrev.md](drush/secrev.md)
- Permissions that gate the pages and runs → [permissions/permissions.md](permissions/permissions.md)
- Alter hooks (unsafe tags/extensions, ignored/temp files) & check-info alter → [hooks/hooks.md](hooks/hooks.md)
- Theme hooks/templates for results & help → [theming/theming.md](theming/theming.md)

Built-in check IDs: `account_creation`, `admin_permissions`, `admin_user`, `error_reporting`,
`executable_php`, `failed_logins`, `fields`, `file_permissions`, `headers`, `input_formats`,
`last_cron_run`, `name_passwords`, `private_files`, `query_errors`, `temporary_files`,
`trusted_hosts`, `upload_extensions`, `vendor_directory`, `views_access`.
