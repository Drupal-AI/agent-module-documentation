Google Analytics adds the Google gtag.js tracking snippet to every page of your Drupal site so visits and events are recorded in a Google Analytics 4 property, configured entirely through an admin form.

---

The module injects the Google `gtag.js` JavaScript tracker (keyed by one or more GA4 Measurement IDs) into the head of pages via `hook_page_attachments`, and caches the remote tracking library locally, refreshing it daily on cron. A single settings form at Admin → Configuration → Services → Google Analytics controls which measurement IDs are used, which pages and user roles are tracked (with allow/deny path lists and optional PHP-based visibility), and whether users may opt in or out of tracking on their profile. It provides built-in tracking of outbound links, mailto/tel links, file downloads (by extension), Colorbox popups, cross-domain and sub-domain modes, URL fragments, and site-search result counts. Custom dimensions, metrics, and arbitrary "before"/"after" JavaScript code snippets can be added, and the emitted `gtag("config")` and `gtag("event")` calls are built through a symfony event system so other modules can inject configuration and events. Two user tokens (`[user:role-names]`, `[user:role-ids]`) are added for use in custom code. Permissions gate administration, opt-in/out, and the security-sensitive PHP-visibility and custom-JS features. It requires only core `path_alias`, and Token is recommended for richer placeholder support.

---

- Add GA4 tracking to an entire Drupal site by entering a Measurement ID.
- Track multiple GA4 properties at once with several measurement IDs.
- Exclude admin or specific paths from tracking with a deny-list.
- Track only a specific set of pages with an allow-list.
- Exempt certain user roles (e.g. administrators) from being tracked.
- Let authenticated users opt in or out of tracking on their profile.
- Track outbound link clicks as GA events.
- Track `mailto:` email link clicks.
- Track `tel:` phone link clicks.
- Track file downloads filtered by extension (pdf, docx, zip, …).
- Track clicks inside Colorbox lightbox popups.
- Enable cross-domain tracking across several domains.
- Configure sub-domain / multiple-domain tracking modes.
- Include URL fragments (`#anchor`) in tracked page paths.
- Report internal site-search result counts to Analytics.
- Add custom dimensions and metrics to the tracker.
- Inject custom "before" JavaScript snippets ahead of the tracker.
- Append custom "after" JavaScript to fire extra events.
- Enable local caching of the gtag.js library for privacy/performance, refreshed daily.
- Turn on debug mode to load the uncompressed tracker for troubleshooting.
- Track Drupal 403 and 404 error pages.
- Use `[user:role-names]` / `[user:role-ids]` tokens in custom snippets.
- Programmatically add `gtag("config")` parameters via the ADD_CONFIG event.
- Programmatically push `gtag("event")` calls via the ADD_EVENT event.
- Restrict who can enter PHP visibility code or custom JS with dedicated permissions.
- Migrate legacy Google Analytics settings from Drupal 7 via migrate process plugins.
