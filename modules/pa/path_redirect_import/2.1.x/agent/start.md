# path_redirect_import — agent start

Bulk-imports (and deletes/exports) `redirect` entities from a CSV file via the Migrate API.
Adds **Migrate** + **Export** tabs to the Redirect admin list at
**Admin → Config → Search and metadata → URL redirects** (`/admin/config/search/redirect`).
Depends on `redirect`, `migrate_source_csv`, `migrate_tools`. CSV header must be exactly
`source,destination,language,status_code`. Both routes require the `administer redirects`
permission (from the redirect module — this module defines none of its own).

- Import/delete/export via the admin forms, CSV column format, routes → [configure/path_redirect_import.md](configure/path_redirect_import.md)
- Import & export from the CLI (Drush commands) → [drush/path_redirect_import.md](drush/path_redirect_import.md)
