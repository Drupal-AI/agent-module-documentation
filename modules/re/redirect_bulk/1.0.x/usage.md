Redirect Bulk adds two admin screens to the Redirect module for creating many URL redirects at once — a repeatable multi-row form and a CSV importer — instead of adding redirects one by one.

---

The module depends on core-contrib `redirect` and creates standard `Redirect` entities; it adds no storage of its own. Its own permission `administer bulk redirects` (not `restrict access: true`) gates both entry points: a manual bulk form at `/admin/config/search/redirect/add-bulk` (`RedirectBulkForm`) with an "Add redirect"/"Remove" AJAX repeater where each row has a source Path, a destination "To" field with node autocomplete, a redirect status code, and (on multilingual sites) a language; and a CSV importer at `/admin/config/search/redirect/add-csv` (`CsvForm`) that accepts a `from,to,code,langcode` CSV (langcode optional). Both validate entries before saving: they reject empty/duplicate sources, sources starting with `/` or `?`, anchor fragments, `<front>` as a source, self-redirects, and sources that already have a redirect (linking to the existing one); the CSV importer also checks the status code is 300–307 and the langcode is a real language. Destinations are classified as external URLs (`UrlHelper::isExternal`), `node/*` entity paths, or internal paths, and saved into the redirect entity's `redirect_redirect` URI accordingly. An "Add Bulk redirects" and "Import CSV" action link is placed on the core redirect list. A separate `/node/autocomplete` route (permission `access content`) backs the destination autocomplete, returning access-checked, published node paths matching the typed string. Because destinations may be external URLs, bulk-created redirects can point off-site — this is the Redirect module's normal behavior and is gated behind the module's `administer bulk redirects` admin permission (the same trust level as core Redirect's own non-restricted `administer redirects` permission).

---

- Add dozens of URL redirects in one form submission after a site migration.
- Import a `from,to,code,langcode` CSV of legacy URLs exported from an old CMS.
- Bulk-create 301 permanent redirects when restructuring a site's URL scheme.
- Create 302 temporary redirects for a campaign in bulk.
- Map old node paths to new content by typing titles into the autocomplete "To" field.
- Redirect retired pages to relevant replacements en masse.
- Set per-redirect language on a multilingual site during bulk entry.
- Point old URLs to external destinations (e.g. a moved microsite) in bulk.
- Add and remove redirect rows dynamically before saving via AJAX.
- Reject duplicate source paths within a single bulk submission automatically.
- Prevent self-redirect loops (source equals destination) at validation time.
- Catch sources that already have a redirect and jump to edit the existing one.
- Enforce that source paths don't start with a slash or contain anchors.
- Bulk-load redirects from a spreadsheet workflow for content teams.
- Choose the redirect status code (300–307) per row or per CSV line.
- Fall back to the site's default redirect status code for CSV rows without a code.
- Seed a fresh site's redirects from a prepared CSV during launch.
- Speed up SEO redirect maintenance versus the one-at-a-time core form.
- Use `<front>`-aware destination handling for internal targets (front page as destination).
- Provide editors a single place to paste many old→new URL pairs.
