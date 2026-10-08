<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Instagram is a Feeds fetcher that imports an Instagram Business Account's media through the Facebook (Meta) Graph API.

---

Feeds Instagram adds one Feeds fetcher plugin (`feeds_instagram_fetcher`, "Instagram") built on the `facebook/graph-sdk` library. You enter a Facebook App ID and App Secret in the fetcher's plugin configuration on a feed type, then authenticate each feed to Facebook via an OAuth 2.0 login flow and pick the Facebook Page whose connected Instagram Business Account you want to import. On import the fetcher queries the account's `/media` edge, pages through results up to a configurable import limit, requests per-item fields (id, caption, media/thumbnail URLs, permalink, like/comment counts, username, timestamps, children, comments), and returns a JSON array for the Feeds parser to map onto content fields. It requires an Instagram Business Account connected to a Facebook Page you administer, and depends on the `feeds` and `pcb` modules. Supports Drupal 9.3, 10, and 11.

---

- Import Instagram Business Account media into Drupal as content via Feeds.
- Add the "Instagram" fetcher (`feeds_instagram_fetcher`) to a Feeds feed type.
- Fetch media through the Facebook (Meta) Graph API using `facebook/graph-sdk`.
- Configure a Facebook App ID and App Secret in the fetcher plugin configuration.
- Set an import limit for the total number of media items pulled per run.
- Authenticate a feed to Facebook with the built-in OAuth 2.0 login flow.
- Exchange a short-lived Facebook token for a long-lived access token automatically.
- Cache the access token in a dedicated `cache.feeds_instagram_tokens` bin.
- Select the Facebook Page whose connected Instagram Business Account to import.
- Resolve and store the Instagram Business Account ID per feed.
- Revoke a feed's cached Facebook access token from the feed form.
- Map imported fields (media URL, thumbnail, caption, permalink) onto node or entity fields.
- Import engagement metadata such as like_count and comments_count.
- Import each item's shortcode, permalink, and published timestamp/datetime.
- Import carousel children and comments arrays for richer content.
- Use the JsonPath parser (Feeds extensible parsers) with context `$.*` as recommended.
- Display a site-hosted Instagram feed built from imported content.
- Refresh imported Instagram media periodically on cron via Feeds.
- Truncate long captions into a usable title automatically.
- Fall back to a generated title ("Instagram post by @username") when a caption is empty.
- Keep imported Instagram content in Drupal for search, listing, and Views.
- Run on Drupal 9.3, 10, or 11 alongside the Feeds and Permanent Cache Bust modules.
