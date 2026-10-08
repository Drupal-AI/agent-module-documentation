Link checker extracts the hyperlinks from your content when it is saved and periodically re-checks them, flagging broken (404/error) links in a report at Administration → Reports → Broken links.

---

Link checker scans fields on fieldable entities (nodes, and optionally custom blocks) for links, storing each unique URL as a `linkcheckerlink` content entity in the `linkchecker_link` table. Extraction happens on entity insert/update (and in bulk on cron via `linkchecker.extractor_batch`); pluggable **LinkExtractor** plugins pull URLs out of a field — `html_link_extractor` reads configured HTML tags (`<a>`, `<img>`, `<iframe>`, `<audio>`, `<video>`, `<object>`, `<embed>`) from formatted text, while `link_link_extractor` reads core Link fields. You choose which fields to scan per content type via a "Scan broken links" checkbox and an Extractor selector added to each field's config form. On cron, `linkchecker.checker` queues links whose check interval has elapsed and the `linkchecker_check` queue worker issues HTTP(S) requests (Guzzle, with concurrency limits) and records the response code, method and error on each link. Response-code **LinkStatusHandler** plugins can act on results — `unpublish_404` unpublishes content after repeated 404s and `repair_301` rewrites permanently-moved links (both gated by settings). Broken links surface in the `broken_links_report` view at `/admin/reports/linkchecker`, and administrators tune extraction, HTTP behaviour, ignored response codes and logging at `/admin/config/content/linkchecker`. Drush commands (`linkchecker:analyze`, `linkchecker:clear`) let you re-extract/re-check or purge links from the CLI.

---

- Find broken (404) outbound links across all your node content automatically.
- Check both internal (`node/123`) and external (`https://example.com/...`) links, or restrict to one type via `check_links_types`.
- Enable link scanning per field by ticking "Scan broken links" on a content type's field.
- Choose the HTML-tag extractor vs. the Link-field extractor per field.
- Scan `<a>`/`<area>` links in body text (the default) for dead links.
- Also scan `<img>`, `<iframe>`, `<audio>`, `<video>`, `<object>`, `<embed>` sources for broken media URLs.
- Include links inside custom blocks by enabling `scan_blocks`.
- Ignore links in unpublished content with `search_published_contents_only`.
- Review all broken links in one place at Reports → Broken links (`/admin/reports/linkchecker`).
- Give editors a personal broken-links report scoped to their own content (`access own broken links report`).
- Let cron re-check links on a schedule (default interval 4 weeks / 2419200s).
- Limit crawler load with max simultaneous connections and per-domain connection caps.
- Skip checking specific hosts by listing them in `disable_link_check_for_urls`.
- Treat certain HTTP codes as non-errors via `ignore_response_codes` (defaults ignore 200/206/302/304/401/403).
- Automatically unpublish nodes whose links 404 after a configurable failure count (`action_status_code_404`).
- Automatically rewrite links that return 301 Moved Permanently to their new target (`action_status_code_301`).
- Set a custom User-Agent string for the link-checking requests.
- Impersonate a specific user account when checking internal links behind access control.
- Re-extract and re-check every link on demand from the CLI with `drush linkchecker:analyze`.
- Purge all stored links and start fresh with `drush linkchecker:clear`.
- Blacklist text filters (e.g. `filter_align`, `smiley`) so their markup is not mis-parsed as links.
- Set a base path / default URL scheme so scheme-relative and internal links resolve correctly.
- Add a new extractor plugin to pull links from a custom field type.
- Add a new status-handler plugin to react to other HTTP response codes.
- Alter the outgoing request headers per link via the `linkchecker.build_header` event.
- Adjust logging verbosity of the module's watchdog activity.
- Audit link health after a large content migration or site relaunch.
