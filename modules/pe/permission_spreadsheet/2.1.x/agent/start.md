# Permission Spreadsheet — agent index

Import/export the role→permission matrix as a spreadsheet (XLSX/XLS/ODS/CSV/TSV) via
PhpSpreadsheet. Three routes, three permissions. Config UI at
`/admin/config/people/permission_spreadsheet` (route `permission_spreadsheet.settings`).
Depends on core `file` + `user`. No Drush, no plugins. Provides a config schema.

- **Settings keys, export/import forms, the spreadsheet column layout & grant/revoke rules** →
  [configure/settings.md](configure/settings.md)
- **The three permissions and exactly what each gates** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `permission_spreadsheet.export` (`/admin/people/permissions/spreadsheet/export`),
  `permission_spreadsheet.import` (`/admin/people/permissions/spreadsheet/import`),
  `permission_spreadsheet.settings`.
- Import applies changes with core `user_role_change_permissions($rid, $permissions)`.
- **Admin roles are skipped** (`loadNonAdminRoles()` yields only `!$role->isAdmin()`); all other
  roles are editable. There is **no filter on which permissions** may be granted.
- Spreadsheet: col D = permission machine name, row 1 of cols E+ = role IDs, cell non-empty &
  not a configured "revoked" text = granted.
- Config object `permission_spreadsheet.settings` (import.text_revoked, import.auto_preview,
  export.filename/sheet_title/text_granted/text_revoked; filename & title accept tokens).
