# Redirect Bulk — agent index

Adds two admin screens to the Redirect module for creating many `Redirect` entities at once: a manual
multi-row form and a CSV importer. Depends on `redirect`. `configure` = `redirect_bulk.form`.

- **The two forms, routes, CSV format, validation rules, destination handling** →
  [configure/forms.md](configure/forms.md)
- **Permissions (`administer bulk redirects`, autocomplete `access content`)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `/admin/config/search/redirect/add-bulk` (`RedirectBulkForm`) — AJAX repeater of source/destination/
  status/(language) rows.
- `/admin/config/search/redirect/add-csv` (`CsvForm`) — upload `from,to,code,langcode` CSV (langcode optional).
- Both gated by own permission `administer bulk redirects` (NOT `restrict access: true`). Creates core
  `Redirect` entities; no own storage/schema.
- `/node/autocomplete` (`RedirectBulkController`) backs the "To" autocomplete — `access content`,
  access-checked & parameterized entity query, published nodes only.
- Destinations classified external / `node/*` entity / internal. External destinations are allowed
  (open redirect by design of the Redirect module; same trust level as core `administer redirects`).
