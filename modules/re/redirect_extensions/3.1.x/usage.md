<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect Extensions is an add-on to the Redirect module that adds bulk editing of redirects (change the status code or the destination of a whole selection at once), a replacement admin listing View with a CSV export, and per-redirect tracking of who created or last changed each one.

---

Redirect stores each redirect as an entity with a source, a destination and an HTTP status code, and its stock admin UI edits them one at a time and records nothing about authorship. That is fine until a migration leaves hundreds of redirects pointing at a path that has since moved, or a batch created as 302 should have been 301, or someone asks who added a particular redirect and when. This module fills those gaps without a settings page. It replaces Redirect's built-in listing with its own `url_redirects` View (disabling the core `redirect` View on install) so the extra columns fit, and the listing carries a bulk-operations checkbox column feeding two Views Bulk Operations actions: "Bulk edit redirect type" routes the selection to a confirm form at `/admin/config/search/redirect/edit/status` offering a status-code select, and "Bulk edit redirect destination" routes to `/admin/config/search/redirect/edit/dest` offering a new destination (internal path, alias, `<front>`, or external URL, with a guard against self-redirect loops). Both forms reuse Redirect's own `administer redirects` permission rather than declaring a new one, and each action also checks per-entity edit access. Alongside that, the View exposes a CSV export at `/admin/config/search/redirect/redirects.csv` via the Views Data Export module, and a small `redirect_extensions` table — populated from `hook_redirect_insert`/`update`/`delete` through the `redirect_extensions.redirect_storage` service — records the created-by user and the created/modified timestamps shown in the listing. Worth knowing when planning: bulk changes are applied uniformly to every selected redirect and are not reversible through the UI, and redirect status codes carry SEO weight (301 signals a permanent move and transfers ranking signals, 302 does not), so a bulk status change is a deliberate decision. Two portability notes: `views_data_export` (plus `rest`, `serialization`, `csv_serialization`) is pulled in transitively, and the storage service is written against the MySQL driver specifically.

---

- Change many redirects from 302 to 301 in one operation.
- Repoint a batch of redirects to a new destination.
- Fix redirects after a site section moves.
- Clean up redirects created by a migration.
- Correct a status code that was applied in error.
- Bulk-update redirects after a rebrand.
- Consolidate a set of redirects onto one target page.
- Fix a destination typo repeated across many redirects.
- Prepare and tidy redirects before a launch.
- Export the full redirect list to CSV for review.
- Hand a redirect list to an SEO consultant as a spreadsheet.
- Audit redirect coverage after a migration.
- See who created a given redirect and when.
- Find recently modified redirects using the tracking columns.
- Sort or filter redirects in the admin list by status code.
- Apply an SEO recommendation to a group of redirects at once.
- Replace the stock redirect listing with one showing authorship.
- Point a group of legacy paths at a replacement URL.
- Reduce manual, one-at-a-time editing of redirect entities.
- Take a reviewable export before a redirect cleanup.
- Set the same permanent (301) status across a section's redirects.
- Track redirect churn by created and modified timestamps.
