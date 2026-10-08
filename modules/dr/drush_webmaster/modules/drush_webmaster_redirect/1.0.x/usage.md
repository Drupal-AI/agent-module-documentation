<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Webmaster: Redirect adds `wm:redirect:*` Drush commands for managing URL redirects (list, search, add, update, delete, stats, and CSV import/export) from the command line for AI-assisted site administration.

---

This submodule of Drush Webmaster provides a `RedirectCommands` class (backed by a `RedirectManager`
service) that wraps the contributed Redirect module's storage and repository. It lets an agent or
webmaster list and filter redirects, search or find them by source/target path, create/update/delete
them with `--dry-run` validation, report statistics, and bulk import or export redirects as CSV.
Status codes are validated against the standard 3xx set, targets are normalised to internal/external
URIs, and duplicate sources are detected before creation. Like the rest of Drush Webmaster it is
CLI-only with no routes or admin UI. It requires the base `drush_webmaster` module and the
contributed `redirect` module. This is a 1.0.0-beta1 pre-release.

Because it manages real redirects that affect live traffic, prefer `--dry-run` and CSV export as a
backup before bulk changes.

---

- List all redirects with filters by status code, language and enabled state (`wm:redirect:list`).
- Get full details for one redirect by id (`wm:redirect:get`).
- Search redirects by partial match on source and/or target path (`wm:redirect:search`).
- Find a redirect by exact source path before creating a new one (`wm:redirect:find`).
- Create a redirect from a source path to an internal path or external URL (`wm:redirect:add`).
- Choose the HTTP status code (301/302/303/307/308) when adding a redirect.
- Restrict a redirect to a specific language, or all languages.
- Update a redirect's source, target, status code, language or enabled flag (`wm:redirect:update`).
- Disable a redirect instead of deleting it (`--enabled=0`).
- Delete a redirect permanently (`wm:redirect:delete`).
- Report redirect statistics: total, enabled/disabled, counts by status code (`wm:redirect:stats`).
- Bulk import redirects from a CSV file with source/target/status_code/language columns (`wm:redirect:import`).
- Update existing redirects during import with `--update-existing`.
- Export redirects to a CSV file or to stdout, filtered by status code/language (`wm:redirect:export`).
- Back up all redirects before a migration by exporting to CSV.
- Preview any create/update/delete/import with `--dry-run` first.
- Let an AI assistant manage redirects safely through structured commands.
