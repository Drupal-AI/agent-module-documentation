<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twitter Profile Widget pulls tweets from the Twitter/X REST API and renders them through block_content "twitter_widget" bundles you place as blocks.
---
The module solves the problem of embedding a site-owned Twitter/X feed without relying on Twitter's client-side embed JavaScript. It authenticates to the Twitter API v1.1 using OAuth2 "application-only" (client-credentials) flow: you enter a Twitter App key and secret at `/admin/config/media/twitter_profile_widget`, and `Drupal\twitter_profile_widget\Authorization::getToken()` exchanges them for a bearer access token that is stored in Drupal state (`twitter_api_access_token`). Requests are made server-side with Guzzle over HTTPS (`https://api.twitter.com/1.1`), so no API credentials are exposed to the browser.

Content editors create one or more block_content entities of the `twitter_widget` bundle (each carrying a `TwitterWidgetItem` field), choosing the account, feed type (user timeline, favorites, list/timeline, or search), and whether to include replies and retweets. `TwitterProfile::pull()` builds the appropriate endpoint, fetches up to 10 tweets, and the field formatter renders them via the `twitter-profile-widget` Twig template. A configurable cache max-age (`twitter_widget_cache_time`) is applied to each rendered widget through `hook_block_content_view_alter()`, and an event subscriber plus the `twitter_profile_widget` cache tag control invalidation. Security posture is sound: the only route is the admin settings form gated by the `administer twitter widget entities` permission (restrict access: true), all API traffic is HTTPS with default TLS verification, and the access token lives in state rather than in exported config. Note the module targets the legacy Twitter API v1.1, which may require an appropriate X API tier to function.
---
- Install and enable the module to add the `twitter_widget` block_content bundle
- Register a Twitter/X developer App and copy its consumer key and secret
- Enter the App key and secret at `/admin/config/media/twitter_profile_widget`
- Let the module exchange the key/secret for an application-only bearer token
- Grant the `administer twitter widget entities` permission to trusted admins only
- Create a block_content "twitter_widget" entity to display a user's timeline
- Configure a widget to show a specific account's favorited tweets
- Display tweets from a named Twitter list owned by an account
- Show results of a Twitter-wide search query in a widget
- Toggle inclusion of replies per widget
- Toggle inclusion of retweets per widget
- Place a configured Twitter widget block in any theme region
- Set the per-widget cache lifetime via `twitter_widget_cache_time`
- Override the `twitter-profile-widget.html.twig` template in your theme to restyle output
- Detach the bundled CSS library by removing the attach_library call in the Twig template
- Refresh the API token by re-saving the settings form when it expires
- Diagnose feed failures via the `twitter_profile_widget` logger channel
- Invalidate cached widgets sitewide using the `twitter_profile_widget` cache tag
- Run multiple widgets with different accounts/feed types on the same page
- Use the field formatter/widget to embed a feed inside a custom entity display
