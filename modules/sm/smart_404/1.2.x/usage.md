Smart 404 automatically logs every 404 response into an aggregated database table and gives administrators an in-backend overview to review those broken URLs and turn them into redirects with intelligent, alias-based destination suggestions.

---

Smart 404 captures each 404 through a Symfony response subscriber (with an optional exception-level hook for Search 404 integration), normalizes the requested path (lowercase, trailing slash and query string stripped), and upserts it into `smart_404_log`, aggregating repeat hits per host+path so the table never bloats. A separate `smart_404_log_daily` table records per-day hit counts that drive a 30-day timeline on each path's detail page. The `/admin/reports/smart-404` overview is a filterable, paginated table (path, host, hits, first/last seen, referer, bot flag, status) with bulk actions to create redirects, ignore, or delete rows. A suggestion engine ranks existing path aliases by Levenshtein distance to propose a redirect destination, and redirects are created through the standard Redirect module — but only 301/302 redirects to a validated internal path, from a source that is re-checked to still be a genuine 404, so the `create smart_404 redirects` permission can be delegated without the Redirect module's own administration permission. Bot traffic is detected by user-agent substring matching (only a bot/not-bot flag is stored, never the raw UA), glob-based ignore patterns keep known probes out of the log, and cron enforces configurable retention (age and max-record cap). The module is privacy-conscious by design: no IP addresses, no user-agent strings, external referers stored domain-only. It depends on the Redirect module and provides four granular permissions plus three Drush commands.

---

- Discover which non-existent URLs visitors and crawlers are hitting, without downloading or grepping server logs.
- Find and fix broken internal links left behind after a site migration or content restructuring.
- Create a 301 redirect for a renamed page in one click, straight from the 404 overview.
- Accept an auto-suggested destination based on the closest existing path alias instead of typing it by hand.
- Bulk-create redirects for many logged 404s at once from a single confirmation screen with per-row editing.
- Bulk-ignore or bulk-delete noise rows (scanner probes, one-off typos) from the overview.
- Filter the 404 log by path fragment, host, status, minimum hit count, or to hide bot traffic.
- Segment 404s per domain on a multi-domain / multi-site install using the stored Host value.
- Inspect a single path's 30-day hit timeline to tell a slow trickle apart from a sudden spike.
- See which referring pages (internal path or external domain) are sending traffic to a broken URL, so you can ask the source to fix its link.
- Exclude known false-positives (WordPress probes, `*.php`, sitemap variants, `/.well-known/*`) from ever being logged via glob ignore patterns.
- Delete already-logged history that matches an ignore pattern in one confirmed action while editing the pattern list.
- Keep the log table bounded automatically with cron-driven retention by age and a maximum-record cap.
- Run retention cleanup on demand with `drush smart404:cleanup` instead of waiting for cron.
- List logged 404s from the command line with `drush smart404:list` (filter by status, host, min-hits).
- Create a redirect for a logged path from the CLI with `drush smart404:redirect <id> <destination>`.
- Delegate day-to-day 404 triage to editors with a read-only `view smart_404 log` permission.
- Let a trusted non-admin create redirects (`create smart_404 redirects`) without granting full Redirect administration.
- Keep 404 statistics complete on sites running Search 404 by logging at the exception level before the response is rewritten.
- Monitor 404 trends over time for SEO purposes and reduce link-equity loss from dead URLs.
- Run a privacy-first 404 log that stores no IP addresses, no raw user agents, and no external-service calls (GDPR-friendly).
- Distinguish crawler-driven 404s from human ones using the bot indicator, and optionally stop logging bots entirely.
