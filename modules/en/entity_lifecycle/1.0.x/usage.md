Entity Lifecycle tracks content freshness by stamping a lifecycle status on every entity save, scanning enabled bundles on cron against configurable condition plugins, and showing editors a banner and review dashboards for content that has gone stale.

---

Entity Lifecycle adds five base fields to the content entity types you enable (nodes and media out of the box; user accounts and any bundleless type via submodules/hooks): a lifecycle status, a last-reviewed timestamp, a per-entity exclude flag, a custom review-period override, and a stored summary of the conditions that last matched. Statuses are configurable `lifecycle_status` config entities — the install ships Current, Needs Review and Outdated, each with a color, weight, a "default" flag and a "requires review" flag, and you can add your own at `/admin/config/content/entity-lifecycle/statuses`. Saving or editing content resets it to the default status with a new timestamp (so an edit is treated as a review), while a cron scan and Drush commands evaluate each bundle's condition rules (content age, published state, a catch-all, plus optional broken-link, entity-usage, engagement and user-account conditions) and re-assign statuses in bulk. Conditions can be combined into groups with AND/OR logic. Content whose status "requires review" gets an alert banner on its page (for users with the dashboard permission), and Views-based dashboards under Content, Media and People list what needs attention with bulk operations and a colored status summary. Everything is configured at `/admin/config/content/entity-lifecycle` and per-bundle on the content-type / media-type edit forms; the `LifecycleCondition` plugin type and a family of alter hooks let other modules add conditions, register new entity types and customize the summaries.

---

- Flag site pages that have not been updated in N months so editors can refresh or retire them.
- Detect content older than a chosen age since creation and route it into a review queue.
- Track unpublished or draft content that has been left in limbo and needs cleanup.
- Give every content type its own review cadence via a per-bundle "review validity" period.
- Let editors mark a specific node as reviewed simply by saving it (status resets to Current).
- Exclude individual pieces of content from scanning with a per-entity "exclude" checkbox.
- Override the review period for one important page without changing the bundle default.
- Show a prominent "please review" banner to editors when they open stale content.
- Provide a "Lifecycle Review" and "Needs Review" dashboard on /admin/content with bulk actions.
- Add the same review dashboard to the media library at /admin/content/media/lifecycle.
- Identify inactive user accounts by last-login date or account age (User submodule).
- Find content referenced nowhere else on the site as candidates for archival (Entity Usage submodule).
- Surface content containing broken links for editorial follow-up (Link Checker submodule).
- Prioritize review of low-engagement content using visitor metrics (Radioactivity submodule).
- Combine several criteria into one rule with AND/OR condition groups (e.g. old AND unpublished).
- Assign different statuses from different rules, evaluated in weight order.
- Run scans on a schedule (every cron run, 6h, 12h, daily, 2 days, or weekly) or disable automatic scanning.
- Trigger an on-demand scan or full rebuild of one bundle from confirmation forms in the admin UI.
- Script scans, rebuilds, statistics and config dumps from the CLI with `drush entity-lifecycle:*`.
- Preview what a scan would change with the `--dry-run` option before applying it.
- Build custom editorial reports with the lifecycle status Views filter and the lifecycle summary area.
- Drive email reminders and other automation off lifecycle status changes using ECA (ECA submodule).
- Support multilingual sites in either shared (one status per entity) or per-translation status mode.
- Keep lifecycle metadata visible only to content editors and administrators, hidden from anonymous visitors.
- Extend the system with your own condition plugins for domain-specific "staleness" rules.
- Register additional bundleless entity types for lifecycle tracking via a hook.
- Get an at-a-glance colored breakdown of how much content sits in each status per entity type.
