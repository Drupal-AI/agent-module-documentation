<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Locks down selected Views RSS feed URLs by adding an authentication requirement (OAuth2 or HTTP Basic) and a logged-in check to those routes.

---

Views can publish RSS feeds at arbitrary paths, and by default those feeds are anonymously accessible. This module lets you require authentication on specific feed paths so only authenticated clients can consume them. A route subscriber (`RouteSubscriberViewsrssFeed`) reads the configured list of feed paths and the chosen authentication type, resolves each path to its route via the route provider, and on each matched route sets the `_auth` option to the chosen provider and adds the `_user_is_logged_in: 'TRUE'` requirement. It depends on core `basic_auth` and the contrib `simple_oauth` module to supply the actual authentication providers.

Configuration is a settings form at `/admin/config/views_rss_authentication/settings` (permission `administer site configuration`): pick the authentication type (`basic_auth` or `oauth2`) and enter one feed path per line (e.g. `/article-rss-feed.xml`). The subscriber logs warnings when config is missing or a path resolves to no route, so misconfiguration is visible in the log rather than silently failing. Because it only tightens access (adds an auth requirement + login check) it does not itself expose any data.

Setup: enable the module (with `simple_oauth` and `basic_auth`), configure the feed paths and auth type, and clear caches so the route subscriber re-applies the requirements. Clients must then present valid credentials/tokens to fetch those feeds.

---

- Require authentication to access a Views RSS feed
- Protect a feed path with HTTP Basic authentication
- Protect a feed path with OAuth2 (simple_oauth) tokens
- Restrict multiple feed URLs from one settings form
- Add a logged-in requirement to selected feed routes
- Serve subscriber-only RSS feeds behind auth
- Keep private syndication feeds from anonymous access
- Choose the authentication provider per site
- List feed paths one per line for protection
- Apply auth requirements via a dynamic route subscriber
- Log when a configured feed path resolves to no route
- Gate configuration behind administer site configuration
- Reuse core basic_auth for simple credential protection
- Integrate simple_oauth token auth for API-style clients
- Protect machine-readable exports published as RSS
- Enforce authentication without editing each view by hand
- Re-apply protection automatically after cache rebuilds
- Limit feed consumption to authenticated integrations
