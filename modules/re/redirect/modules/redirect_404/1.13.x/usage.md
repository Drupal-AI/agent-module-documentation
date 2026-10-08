Submodule of Redirect that logs every 404 (page not found) request and lets you turn the most frequently requested missing pages into real redirects from one admin screen.

---

`redirect_404` adds an event subscriber (`Redirect404Subscriber`) that records each 404 request — the path, language and a hit counter — into a dedicated SQL store (`SqlRedirectNotFoundStorage`, tagged `backend_overridable`). A **Fix 404 pages** report (`/admin/config/search/redirect/404`) lists these misses sorted by count so you can see which broken URLs matter, then add a redirect for each with one click (it hands off to Redirect's add form pre-filled with the source path). Paths you don't care about can be **ignored** so they drop off the list, and an exclude-pattern setting (`pages`) plus a `row_limit` keep the log bounded; `purgeOldRequests()` trims it on cron. A `suppress_404` option and a logger decorator (`Redirect404LogSuppressor`) can stop routine 404s from flooding the standard log. It is the practical way to find and repair broken inbound links and post-migration dead URLs, protecting SEO and user experience. Requires the parent Redirect module and Views.

---

- See which missing URLs are hit most often, ranked by count.
- One-click create a redirect for a frequently requested 404 path.
- Find broken inbound links from other sites after a relaunch.
- Discover dead URLs left over from a content migration.
- Ignore specific 404s (e.g. bot/scanner noise) so they leave the report.
- Set an exclude pattern so certain paths are never logged.
- Cap the 404 log size with a row limit, trimmed on cron.
- Stop routine "page not found" entries from flooding the dblog (`suppress_404`).
- Prioritize which broken pages to fix based on real traffic.
- Let a non-admin editor ignore 404s without giving full settings access.
- Audit 404 patterns to spot a systematic linking mistake.
- Recover SEO value from external links pointing at old URLs.
- Filter/search the 404 report by path.
- Redirect a mistyped-but-popular URL to the correct page.
- Track whether a fix worked (the path stops reappearing).
- Feed a custom 404-handling workflow via the overridable storage service.
- Keep a rolling record of missing-page demand for content planning.
- Clean up after deleting content by redirecting its old path when it still gets hits.
