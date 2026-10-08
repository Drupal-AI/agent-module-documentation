<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Twitter Profile Widget

## 1. Credentials
Route: `/admin/config/media/twitter_profile_widget` (form `SettingsForm`, permission `administer twitter widget entities`).
Fields: Twitter App **consumer key** and **secret**, plus **cache time** (`twitter_widget_cache_time`, seconds).
On save, `Authorization::getToken($key, $secret)` POSTs to `https://api.twitter.com/oauth2/token` with `grant_type=client_credentials`; the returned `access_token` is written to state `twitter_api_access_token` and the `twitter_profile_widget` cache tag is invalidated.

Drush equivalents:
```
drush cget twitter_profile_widget.settings
drush sget twitter_api_access_token   # inspect stored bearer token
```

## 2. Create a widget (block content)
Add a `twitter_widget` block_content entity at `/admin/structure/block/block-content`. The `TwitterWidgetItem` field captures:
- `account` (screen name)
- `list_type` — '' (user timeline), `favorites`, `timeline` (named list), or `search`
- `timeline` (list name, when list_type=timeline), `search` (query, when list_type=search)
- `replies` (0/1), `retweets` (0/1)

At render time `TwitterProfile::pull($instance)` builds the endpoint (`/statuses/user_timeline.json`, `/favorites/list.json`, `/lists/statuses.json`, or `/search/tweets.json`), requesting `count=10`.

## 3. Place & theme
Place the widget as a block in any region. Copy `templates/twitter-profile-widget.html.twig` into your theme to customize; remove the `attach_library('twitter_profile_widget/twitter-profile-widget')` call to drop the bundled CSS.

## Notes
- Uses Twitter/X **API v1.1**; a compatible X API access tier is required.
- If `twitter_api_access_token` is empty, `TwitterProfile::pull()` logs an error and returns FALSE (widgets render empty).
