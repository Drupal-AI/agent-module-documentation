<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orejime Register (orejime_register) — agent index

Records the cookie-consent decisions visitors make through the **Orejime** consent banner into a
dedicated database table (`orejime_register__cookie_register`), giving a site a GDPR
accountability log of what each visitor accepted or declined. No settings form: the module works as
soon as it is enabled.

- Depends on `orejime:orejime` (composer `drupal/orejime:^3`); core `^10.1 || ^11 || ^12`.
- `configure` route is the report listing, `orejime_register.list` (`/admin/reports/orejime-register/list`).
- Defines **no** permissions, drush commands, plugin types or config schema. The admin routes reuse
  Orejime's own `administer orejime entities` permission.

Solution docs:
- **How consent gets recorded (register route, JS, service pipeline) / query or purge in PHP** → [api/database.md](api/database.md)
- **Hooks it implements (per-service columns, page attachment)** → [hooks/hooks.md](hooks/hooks.md)
- **View the register, purge all / purge by date, retention** → [configure/admin.md](configure/admin.md)

Key facts:
- Service id **`orejime_register.database`** → `Drupal\orejime_register\Services\Database`.
- Table constant `Database::TABLE_NAME` = `orejime_register__cookie_register`; base columns `id`
  (serial), `created_at` (datetime). One extra tinyint column **per Orejime service**, named
  `{service_name}_{service_id}`, added by `createColumn()` and renamed by `updateColumn()`.
- Routes: `orejime_register.register` (`/orejime_register`, the write endpoint hit by the JS),
  `orejime_register.list`, `orejime_register.purge`, `orejime_register.purge_by_date`
  (the last three under `/admin/reports/orejime-register/*`, permission `administer orejime entities`).
- Hooks (attribute-based, `src/Hook/OrejimeRegisterHooks`): `orejime_service_insert`,
  `orejime_service_presave`, `page_attachments`. Library `orejime_register/cookies-register`
  (js/cookies-register.js).
