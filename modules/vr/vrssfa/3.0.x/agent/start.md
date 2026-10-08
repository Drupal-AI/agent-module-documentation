<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS Feed Authentication (vrssfa) — agent index

**Adds an authentication requirement (OAuth2 via simple_oauth, or core HTTP Basic) plus a logged-in check to selected Views RSS feed routes.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11 — depends on simple_oauth:simple_oauth and drupal:basic_auth.
- **Configure:** `/admin/config/views_rss_authentication/settings` (`views_rss_authentication.settings`) — permission `administer site configuration`. Set `authentication_type` (`basic_auth`|`oauth2`) and `view_rss_feed_url` (one path per line).
- **Mechanism:** `RouteSubscriberViewsrssFeed::alterRoutes()` resolves each configured path via the route provider and sets `_auth` option + `_user_is_logged_in: 'TRUE'` requirement on the matched routes.

**Security:** This module *tightens* access rather than exposing anything — it only adds auth requirements to existing feed routes. Config form is gated by `administer site configuration`. No `_access: 'TRUE'`, no raw SQL, no unverified callbacks, no disabled TLS. Operational note: protection is only as good as the configured path list — a feed path not listed (or that fails to resolve) stays anonymous, and the subscriber logs such cases. No security findings.

See [configure/setup.md](configure/setup.md).