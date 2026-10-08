<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The native statistics tracker for the Advertisement module: counts ad impressions and clicks locally, either immediately or through a cron-processed queue.

---

`ad_track` is the tracker half of the `ad` framework. It registers two tracker plugins — **Local ad
event tracker** (id `local`, writes immediately) and **Queue-based local ad event tracker** (id
`delayed_local`, queues events for cron/`ad_track_queue`) — that ad buckets call on every impression
and click. It maintains a denormalized `ad_track_total` table (total clicks/impressions per ad,
race-safe via `INSERT … ON DUPLICATE KEY UPDATE`) and, when event tracking is on, an
`ad_track_event` entity storing per-event metadata (URL, page title, referrer, IP, user agent,
session, page-view id). A click route `/ad/track/click/{bucket_id}/{uuid}` records the click and
redirects to the ad's stored target URL. Everything is configured at
`/admin/config/content/ad/ad-track`, where each metadata field can be toggled for privacy, and all
event data can be flushed. On install it flips any `null` tracker to `local`. Depends only on `ad`;
integrates with Views for reporting, including a click-through-rate field.

---

- Count total impressions and total clicks per advertisement.
- Record individual impression and click events with page context for detailed reporting.
- Choose immediate tracking (`local`) for accuracy or queued tracking (`delayed_local`) for low write load.
- Defer event writes to cron via the `ad_track_queue` queue worker (120s per run).
- Redirect ad clicks through `/ad/track/click/{bucket_id}/{uuid}` so each click is counted.
- Compute and display click-through rate (%) in Views with the `ad_track_click_through` field.
- Toggle whether IP address is stored, to comply with privacy regulations.
- Toggle whether user agent, URL, page title, and referrer are stored.
- Exempt admin/editor roles from impression counting (`bypass track impression`).
- Exempt admin/editor roles from click counting (`bypass track click`).
- Disable heavy impression tracking on high-traffic sites while keeping click totals.
- Flush the entire event data table from the settings form ("Clear event data").
- Report ad performance with the totals fields exposed on the ad entity (`total_impression`, `total_click`).
- Build custom dashboards over the `ad_track_event` entity via its Views data.
- Sanitize stored referrer/URL/user-agent/title values before saving (validity + character filtering).
- Tie a click event to its originating impression via the parent-event id.
- Keep counters correct under concurrency using per-ad DB transactions.
- Turn the native trackers on automatically for existing sources at install time.
