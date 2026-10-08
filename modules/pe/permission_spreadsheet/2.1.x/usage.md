Permission Spreadsheet exports the site's role→permission matrix to a spreadsheet (XLSX/XLS/ODS/CSV/TSV) and imports an edited spreadsheet back to bulk-assign permissions across roles — handy for sites with many roles or for copying permissions between roles.

---

The module (built on PhpSpreadsheet) adds two admin operations under People: **Export**
(`/admin/people/permissions/spreadsheet/export`) writes a downloadable sheet where columns A–C
are human-readable permission info, column D is the machine permission name, and columns E+ are
one-per-role grant columns (a configurable "granted" mark such as `Y`); and **Import**
(`/admin/people/permissions/spreadsheet/import`) reads such a sheet back, diffs it against the
current state, shows a colour-coded preview of grants/revocations per role, and on submit applies
the changes with core's `user_role_change_permissions()`. Import reads role IDs from row 1 of
columns E onward and permission machine names from column D; a cell is treated as *granted* when
it is non-empty and not one of the configured "revoked" texts. A settings form
(`/admin/config/people/permission_spreadsheet`, permission `administer permission spreadsheet`)
controls the export filename/sheet-title/granted/revoked texts (filename and title support
tokens) and whether import auto-previews on upload. Three permissions gate the three routes.
**Admin (super-user) roles are deliberately excluded** from both export and import — the module
iterates only non-admin roles (`Role::isAdmin() === FALSE`), so it can never edit the permissions
of a role flagged "is admin". It does not otherwise restrict *which* permissions may be assigned.

---

- Export the full role/permission matrix of a site to an Excel/ODS/CSV/TSV file.
- Bulk-edit many permissions across many roles in a spreadsheet instead of the admin form.
- Copy the permission set of one role onto another by duplicating its column.
- Review the exact grant/revoke changes in a per-role preview before applying an import.
- Diff a spreadsheet against the live site to see what an import would change.
- Hand a spreadsheet to a non-technical stakeholder to mark desired permissions, then import it.
- Migrate a permission configuration between environments via a portable spreadsheet.
- Audit which roles hold which permissions by scanning the exported sheet.
- Customize the "granted" mark (e.g. `Y`, `x`, `1`) used in exports.
- Define one or more "revoked" texts so specific cell values count as a revocation on import.
- Tokenize the export filename and sheet title (e.g. include the site name or date).
- Auto-generate a preview immediately on file upload (toggle in settings).
- Remove role columns you do not want to touch before importing (columns after a gap are ignored).
- Remove permission rows you do not want to change before importing.
- Produce a CSV or TSV of permissions for processing in external tooling.
- Keep a versioned snapshot of a site's permission matrix in source control as a spreadsheet.
- Reset a role's permissions to a known-good baseline by re-importing a saved sheet.
- Apply the same permission change to several roles at once in a single import.
- Onboard a new role quickly by pasting an existing role's grants into a new column.
- Verify that admin/super-user roles are untouched (they are skipped by design) while editing others.
