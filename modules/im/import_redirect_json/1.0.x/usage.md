<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Import redirect JSON imports redirects from a JSON file, creating Redirect-module redirects in bulk.

---

Import redirect JSON imports URL redirects from a JSON file — mapping source→destination pairs into
Redirect-module redirects in bulk, useful when migrating a site and carrying over a large redirect map. It
depends on the Redirect module and core Database Logging, is configured at `import_redirect_json.mapping`,
and provides its own permissions.

Use it to bulk-load redirects during migrations or launches. Because it creates redirects (which control
where URLs send visitors), restrict the import permission to trusted administrators, and validate the JSON
source (a malicious/erroneous redirect map could send users to unexpected or external destinations). It is
an import/site-structure tool acting with the importer's privileges. Configure the field mapping and run
the import.

---

- Import redirects from JSON.
- Bulk-create Redirect-module redirects.
- Carry over a redirect map on migration.
- Depend on the Redirect module.
- Configure at import_redirect_json.mapping.
- Provide its own permissions.
- Restrict the import to trusted admins.
- Validate the JSON source.
- Avoid malicious redirect destinations.
- Map source to destination.
- Load many redirects at once.
- Act with the importer's privileges.
- Configure the field mapping.
- Support launches/migrations.
- Import redirect pairs.
- Handle redirects in bulk.
- Run the JSON import.
- Create redirects from a file.
- Manage redirect imports.
- Bulk-load redirects.
