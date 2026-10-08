Protect Views Flood Control rate-limits Views Exposed Form submissions per view/display using Drupal's Flood API, and can cap the number of active filters/options a submission may use — to blunt scraping and abusive filter-combination traffic.

---

The module registers a **Views display extender** (`protect_views_flood_control`, enabled globally in `views.settings` on install) that adds a "Flood control" section to each View display's *Advanced* panel. There you enable protection and set a `window` (seconds) and `threshold` (allowed submissions), plus an optional "by IP range" mode and an optional "maximum filters / options per filter" cap. A `hook_form_views_exposed_form_alter` appends a static `#validate` handler; on submit, if the display has protection enabled and the request actually carries non-empty exposed input, it builds a per-view/display flood key (`views_exposed:<view>:<display>`) and consults `protect_form_flood_control`'s Flood manager. Over the limit, **non-AJAX** requests throw a `TooManyRequestsHttpException` (HTTP 429 with `Retry-After` and `X-RateLimit-Limit`) — aimed at scraper bots — while **AJAX** requests get a friendly form validation error instead (and are optionally logged). Under the limit, the submission is registered in the flood table. The separate max-filters check counts active exposed filters (and options within array filters) and sets form errors when exceeded. Limits apply only to exposed-filter submissions, not initial page loads or pagination, and only when the exposed form is actually executed (a fully cached result is not counted). IP whitelisting and blocked-submission logging are configured in the parent **Protect Form Flood Control** module. Requires core `views` and `protect_form_flood_control`.

---

- Throttle a public search/listing View so a bot can't hammer its exposed filters.
- Limit exposed-form submissions to N per T seconds per view display (default 5 / 30s).
- Return HTTP 429 with `Retry-After` to non-AJAX scrapers so well-behaved bots back off.
- Show a human-friendly "try again later" error on AJAX-driven exposed forms.
- Apply different thresholds/windows to different displays of the same View.
- Protect only specific displays (Page, Block) while leaving others open.
- Group throttling by IP subnet (IPv4 /24, IPv6 /48) instead of exact IP to catch rotating addresses.
- Cap the maximum number of filters a visitor can apply at once (anti combinatorial-scraping).
- Cap the maximum number of options selectable within a single multi-value filter.
- Reduce database/search load from AI crawlers trying every filter permutation.
- Reuse the parent module's IP whitelist so trusted crawlers/monitors are exempt.
- Log blocked submissions for analysis via Protect Form Flood Control settings.
- Protect a faceted product/catalog listing from filter-combination abuse.
- Keep a members' directory View from being scraped through its exposed search.
- Rate-limit an exposed autocomplete/keyword filter that hits an expensive backend.
- Combine with Cloudflare/edge rate limiting for layered defense.
- Leave initial page loads and pager clicks unthrottled so normal browsing is unaffected.
- Tune the window minimum (10s) and threshold (min 1) per display via the Advanced panel.
- Encourage cron (Ultimate Cron / Simple Cron) to clear the flood table frequently.
- Apply protection without writing code — purely via the Views UI.
- Signal rate limits to clients with the `X-RateLimit-Limit` header on 429 responses.
