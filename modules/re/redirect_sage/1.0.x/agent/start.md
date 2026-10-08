<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Sage (redirect_sage) — agent index
**Bulk CSV import/export for the Redirect module.**

- **Version:** 1.0.x
- **Core:** ^9.3 || ^10
- **Depends on:** Redirect
- **Routes:** `redirect_sage.import_form` (`/admin/config/search/redirect/sage_import`) and `redirect_sage.export_form` (`/admin/config/search/redirect/sage_export`), both `_permission: 'administer redirects'`
- **Import:** Batch API `RedirectImport::ImportLine` — CSV `source,destination,langcode,statuscode`; update-by-hash or create via Redirect entity API
- **Export:** filtered query → streamed `redirect-export.csv` via `fputcsv`

**Security:** both routes gated by `administer redirects`; no anonymous or public endpoints. Redirects written through the entity API (no raw SQL); imports batched.

See [configure/csv.md](configure/csv.md)
