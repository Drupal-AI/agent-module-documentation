<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Local Data Sanitiser (local_data_sanitiser) — agent index

**CLI-only Drush tooling to delete webform submissions and anonymise user/content PII on LOCAL databases; guarded against non-local environments.**

- **Version:** 1.2.x (dev branch; no packaged version) · **Core:** ^10.3 || ^11 · **Package:** Development · `hidden: true`
- **Command:** `drush local-data:sanitise` (alias `lds`) — options `--tasks`, `--list-tasks`, `--entity-types`, `--batch-size`, `--force`.
- **Tasks (plugins):** `WebformSubmissionsTask`, `UserAccountsTask`, `ContentEntityFieldsTask` via `plugin.manager.local_data_sanitiser_task`.
- **Services:** `local_data_sanitiser.field_sanitiser` (`FieldSanitiser`), `local_data_sanitiser.sanitiser`. Config filter: `LocalDataSanitiserConfigFilter`.
- **Guard:** aborts unless a local environment is detected (`UserAbortException`); `--force` overrides; interactive confirm + pre-flight warning.
- **Security:** no web surface at all — no routes, permissions, or UI (CLI-only, hidden). Anonymises data **in place**; does NOT expose originals via any route/export. Only risk is operator error on production, mitigated by the local-env guard + `--force`. No security findings.

See [drush/sanitise.md](drush/sanitise.md)
