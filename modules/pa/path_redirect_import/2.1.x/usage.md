Path Redirect Import bulk-creates `redirect` entities from a CSV file, so you can load hundreds of URL redirects at once instead of adding them one by one. It also bulk-deletes redirects listed in a CSV and exports existing redirects back out to CSV.

---

Path Redirect Import adds a **Migrate** and an **Export** tab to the Redirect admin listing (**Admin → Configuration → Search and metadata → URL redirects**), plus two Drush commands. You upload a CSV whose header row is exactly `source,destination,language,status_code`; each data row becomes a redirect from the source path to the destination, in the given language, with the given HTTP status code (defaulting to 301 when omitted). Import is powered by the Migrate API: the module ships a `path_redirect_import` migration using a custom `csv_redirect` source plugin (a subclass of Migrate Source CSV) that decodes and normalizes the source path and writes to the `entity:redirect` destination, run through a batch via Migrate Tools. The upload form validates each line — headers must match, values must be UTF-8, no cell may be empty/null, and source may not equal destination — deleting the file on failure. A "Delete redirects defined in the spreadsheet" checkbox instead matches rows by redirect hash and sends them to Redirect's multiple-delete confirm form. Because import runs through Migrate, re-importing updates existing rows rather than duplicating them. It depends on `redirect`, `migrate_source_csv`, and `migrate_tools`, and reuses Redirect's `administer redirects` permission for both routes.

---

- Bulk-import hundreds of URL redirects from a spreadsheet during a site relaunch.
- Load a redirect map exported from a legacy CMS as a CSV.
- Migrate redirects captured in a spreadsheet by the SEO team without hand-entering each one.
- Set a per-row HTTP status code (e.g. 301 permanent vs 302 temporary) in the `status_code` column.
- Default any row with no status code to a 301 permanent redirect.
- Import language-specific redirects using the `language` column (e.g. `en`, `und`).
- Redirect old paths to `<front>` or to absolute external URLs like `https://example.com`.
- Preserve query strings on the source path (e.g. `source-path-other?param=value`).
- Re-run an import to update existing redirects in place instead of creating duplicates.
- Bulk-delete a set of redirects by uploading the same CSV with the "Delete" checkbox ticked.
- Export all existing redirects to a CSV for backup or review.
- Round-trip redirects: export from one environment, import into another.
- Automate redirect imports in CI or deploy scripts with `drush path_redirect_import:import file.csv`.
- Automate redirect exports with `drush path_redirect_import:export` (alias `prie`).
- Validate a redirect CSV's structure before import (header, encoding, empty cells, self-redirects).
- Seed a fresh site with a canonical set of redirects from a versioned CSV.
- Consolidate many legacy URLs onto new canonical paths in one batch.
- Hand editors a simple CSV template (source, destination, language, status code) to fill in.
- Import redirects contributed by non-developers who only know spreadsheets.
- Normalize leading slashes automatically — the importer strips a leading `/` from source paths.
- Feed redirects produced by another migration into the Redirect module in bulk.
- Reduce manual data entry when moving from a static site to Drupal.
- Keep a master redirect list in version control and apply it via Drush on deploy.
- Run the import as a batch so large CSV files process without timing out.
