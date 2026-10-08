<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Editoria11y SI (SiteImprove) imports quality-assurance data from the SiteImprove API and surfaces broken links, misspellings, and reading-level (Flesch–Kincaid) issues to content authors through the Editoria11y accessibility checker interface, plus admin report views.

---

Editoria11y SI pulls three kinds of SiteImprove QA data — **pages with broken links**, **misspellings**, and **reading scores** — via SiteImprove's REST API (`api.siteimprove.com/v2`), authenticating with credentials stored in a **Key** entity (username, api_key, site, optional group). A cron helper (`editoria11y_si_queue_cronjob()`, run via drush or the settings form's manual buttons) fetches each page from the API, diffs it against stored `editoria11y_si` content entities (removing stale rows), and queues per-page items processed by the `editoria11y_si_import_processor` queue worker, which upserts rows keyed by a content hash. On node view, a `hook_preprocess_node` gathers the stored data for the current path and passes it to `drupalSettings`; a shipped JS custom-test file registers three Editoria11y tests (`ed11ySiBrokenLinks`, `ed11ySiMisspellings`, `ed11ySiReadingScore`) that render the issues as in-page Editoria11y tips linking back to the SiteImprove page report. Each data type also has an admin View at `/admin/reports/editoria11y/si-*` gated by the `view editoria11y checker` permission. The settings form (`/admin/config/content/editoria11y/si`) selects the Key, sets the site domain to strip from URLs, toggles each check, and sets the reading-score error grade level. This is major version 3.0, requiring Editoria11y `^3.0`. Note: the queue worker type-hints Purge services that are not declared as a dependency.

---

- Import SiteImprove broken-link data into Drupal.
- Import SiteImprove misspelling data.
- Import SiteImprove reading-score (Flesch–Kincaid grade level) data.
- Show broken links to authors as in-page Editoria11y tips.
- Show misspellings with a suggested correction inline.
- Flag pages whose reading level is below a configured grade.
- Link each in-page issue to its SiteImprove page report.
- List all broken links in an admin report view.
- List all misspellings in an admin report view.
- List reading scores per page in an admin report view.
- Store SiteImprove credentials securely as a Key entity.
- Filter API results by an optional SiteImprove group id.
- Strip the site domain from SiteImprove URLs to match internal paths.
- Toggle each QA check (broken links / misspellings / reading score) independently.
- Manually trigger an import from the settings form per data type.
- Schedule imports via cron (`editoria11y_si_queue_cronjob()`).
- Automatically prune stored issues no longer reported by SiteImprove.
- Deduplicate imports with a per-row content hash.
- Track the last successful import time per data type.
- Combine SiteImprove QA findings with Editoria11y's own in-page checks.
- Bulk-clear stored data via `drush entity:delete editoria11y_si`.
