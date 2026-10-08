<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds bulk CSV import and export for the Redirect module so many redirects can be created or downloaded at once.

---

The import form at `/admin/config/search/redirect/sage_import` accepts redirects as pasted text or an uploaded file; each CSV line is `source, destination, language code, status code` (source and destination required, language defaults to `und`/site default, status defaults to 301 and is validated to the 3xx range). A Batch API run (`RedirectImport::ImportLine`) parses each line — splitting query strings and, on multilingual sites, a URL-prefix language code — computes the Redirect hash, and updates an existing redirect or creates a new one via the Redirect entity API, logging skipped/invalid rows to dblog. The export form at `.../sage_export` filters by source (CONTAINS), HTTP code and language, then streams a `redirect-export.csv` download built with `fputcsv`.

Both routes require the `administer redirects` permission, so the feature is limited to redirect administrators. It is primarily a migration/maintenance tool for moving large redirect sets between environments or seeding them from a spreadsheet. Redirects are written through the Redirect entity API rather than raw SQL, and imports run in batches to handle large files.

---
- Import many redirects from a pasted CSV block
- Import redirects from an uploaded CSV file
- Set per-row destination and source
- Specify a per-row language code (or default/und)
- Specify a per-row HTTP status code (301–399)
- Update an existing redirect when the source hash matches
- Create new redirects for unmatched sources
- Handle query strings on source and destination URLs
- Respect URL-prefix language negotiation on multilingual sites
- Export all redirects to a CSV file
- Filter exports by source substring
- Filter exports by HTTP status code
- Filter exports by language code
- Review skipped/invalid import rows in the dblog
- Migrate redirect sets between environments
- Seed redirects from a spreadsheet
