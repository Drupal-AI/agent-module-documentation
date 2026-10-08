<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS Feed Authentication — setup

## Prerequisites
Enable core `basic_auth` and contrib `simple_oauth`, then `vrssfa`.

## Configure — `/admin/config/views_rss_authentication/settings`
Permission: `administer site configuration`. Config object `views_rss_authentication.settings`:
- `authentication_type` — `basic_auth` or `oauth2`.
- `view_rss_feed_url` — one feed path per line (e.g. `/article-rss-feed.xml`).

## How it applies
`RouteSubscriberViewsrssFeed::alterRoutes()` runs on route rebuild: it splits the path list, looks each path up with `router.route_provider` (`getRoutesByPattern`), and for every matched route calls `setOption('_auth', [$type])` and `setRequirement('_user_is_logged_in', 'TRUE')`. Missing config or unresolved paths are logged (warning/notice) rather than throwing.

## Operate
- Rebuild caches (`drush cr`) after changing paths so the subscriber re-applies.
- Clients must send valid credentials: HTTP Basic header for `basic_auth`, or a Bearer token for `oauth2`.
- Any feed path not listed remains anonymously accessible — keep the list complete.
