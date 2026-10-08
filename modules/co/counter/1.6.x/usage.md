Counter is a self-hosted page-hit and visitor counter for Drupal. It writes one database row per web request — capturing IP, URL, timestamp, user id, node id/type, and a User-Agent-derived browser and platform — into its own `counter` table, then surfaces the aggregates through blocks, two admin report pages, and Views. It keeps all traffic data inside the site with no third-party analytics service.

---

Recording happens along two paths so both dynamic and cached pages are counted: a `kernel.request` event subscriber handles uncached requests (honouring "skip admin" and "only pages" settings and skipping `/sites/`, history-read, and the module's own admin paths), while an HTTP stack middleware catches responses served from the internal page cache (`X-Drupal-Cache: HIT`). Display is driven by the `counter.settings` config object, whose ~20 toggles decide which metrics appear: total site counter, unique visitors (by distinct IP), registered/unregistered/blocked user counts, published/unpublished node counts, server and client IP, "counter since" date, and rolling today/week/month/year figures — each optionally seeded with an initial offset. Three blocks (`counter_block`, `configurable_counter_block`, `counter_day_block`), an admin dashboard with top-node and top-URL lists, and a Chart.js statistics page (fed by an admin-only JSON endpoint) present the data; a Views base table exposes the raw rows. All admin routes are gated by the `administer counter` permission, and blocks stay cacheable via the `counter_data_refresh` tag that `hook_cron` invalidates. Note that `matomo/device-detector` is declared in composer.json but is not actually used — browser detection is hand-rolled. Because rows are never pruned, plan retention on busy sites.

---

- Show a "you are visitor number N" counter block in a footer or sidebar.
- Display total page views for the whole site without external analytics.
- Count unique visitors based on distinct IP addresses.
- Show rolling visitor stats for today, this week, this month, and this year.
- Display counts of registered, unregistered, and blocked users.
- Display published and unpublished node counts to editors.
- Show the visitor their own client IP address.
- Show the web server's IP address on an admin/status block.
- Seed the counter with an initial value when migrating from another counter.
- Provide traffic statistics on a fully self-hosted / air-gapped intranet.
- Give admins a dashboard of top-viewed nodes and top-viewed URLs.
- Plot a time-series views/visitors chart with period comparison on the admin statistics page.
- Build a custom Views report of raw hits filtered by IP, URL, date, node, or browser.
- Relate counter rows to user accounts through the Views `uid` relationship.
- Exclude administrators from being counted via the "skip admin" setting.
- Count only real page views by limiting recording to main-request GETs.
- Anonymise or drop specific hits using the `hook_counter_data_alter` integration hook.
- Suppress counting for chosen paths using the `hook_counter_request_alter` hook.
- Show a compact "today's views" badge that links admins to the dashboard.
- Report content and traffic volume to stakeholders from inside Drupal.
- Break down traffic by detected browser and operating-system platform.
- Provide a nostalgic hit counter for a community or hobby site.
- Keep a per-URL popularity ranking to surface trending pages.
- Restrict all counter configuration and reports to a trusted admin role.
- Refresh cached counter blocks automatically on cron runs.
