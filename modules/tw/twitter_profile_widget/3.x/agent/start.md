<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twitter Profile Widget (twitter_profile_widget) — agent index

**Displays read-only Twitter/X feeds through configuration-driven block_content widgets, authenticating server-side with an application-only bearer token.**

- **Version:** 3.x
- **Core:** ^10 || ^11
- **Depends on:** block_content (core)
- **Configure route:** `twitter_profile_widget.settings` → `/admin/config/media/twitter_profile_widget` (App key + secret, cache time)
- **Permission:** `administer twitter widget entities` (restrict access: true) — gates the only route
- **Content model:** block_content bundle `twitter_widget` with a `TwitterWidgetItem` field, rendered by `TwitterWidgetFormatter` via the `twitter-profile-widget` Twig template
- **Key classes:** `Authorization::getToken()` (OAuth2 client-credentials → state), `TwitterProfile::pull()`/`request()` (Guzzle GET to `https://api.twitter.com/1.1`)
- **Token storage:** Drupal state key `twitter_api_access_token` (not config)
- **Caching:** per-widget max-age from `twitter_widget_cache_time`; `twitter_profile_widget` cache tag; `TwitterWidgetSubscriber` event subscriber

**Security:** Admin settings route is permission-gated (`administer twitter widget entities`, restrict access). No anonymous or mutating endpoints. API calls use HTTPS with Guzzle default TLS verification; the bearer token is stored in state, and the App key/secret are entered in the admin form (plaintext config). Uses the legacy Twitter API v1.1.

See [configure/setup.md](configure/setup.md)
