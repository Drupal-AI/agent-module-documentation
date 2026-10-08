# Redirect metrics — agent index

Adds usage tracking to the `redirect` entity: two base fields (`access_count`, `last_access`)
plus a response-event subscriber that increments them, and two Views report pages. No config
form, no permissions of its own, no Drush, no plugins. Requires the contrib `redirect` module
and core `views`.

- **The two base fields, the event subscriber, and reading/querying metrics in code** →
  [api/metrics.md](api/metrics.md)
- **The shipped reports (Popular / Stale redirects), their paths, sorts, filters, local tasks** →
  [configure/views.md](configure/views.md)

Key facts:
- Fields live directly on the `redirect` entity: `access_count` (integer, init 0),
  `last_access` (timestamp). No custom table.
- Counting happens in `redirect_metrics.request_subscriber` on `KernelEvents::RESPONSE`,
  keyed off the `X_REDIRECT_ID` response header set by the `redirect` module.
- Reports: `admin/config/search/redirect/popular` (View `redirect_metrics` display `page_1`,
  sort `access_count` DESC) and `admin/config/search/redirect/stale` (display `page_2`,
  filter `last_access < -6 months`). Access gated by redirect's "administer redirects".
