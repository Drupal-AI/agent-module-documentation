# Social Feed services & API

Defined in `socialfeed.services.yml`:

| Service | Class | Role |
|---|---|---|
| `socialfeed.facebook` | `FacebookPostCollectorFactory` | Builds a Facebook collector (`createInstance($app_id, $secret, $user_token, $page_name)`). Uses `facebook/php-business-sdk` + `@http_client`. |
| `socialfeed.twitter` | `TwitterPostCollectorFactory` | Builds an X collector using `noweh/twitter-api-v2-php`; caches responses in `@cache.default`. |
| `socialfeed.instagram` | `InstagramPostCollectorFactory` | Builds an Instagram collector using `socialfeed.instagram_api`. |
| `socialfeed.instagram_api` | `InstagramApiService` | Low-level Instagram Graph API (`@http_client`): OAuth token exchange + media fetch. |

## Collector usage (as blocks do it)

```php
$factory = \Drupal::service('socialfeed.facebook');
$fb = $factory->createInstance($appId, $secret, $userToken, $pageName);
$posts = $fb->getPosts((string) $pageId, $postTypesOrTrue, $count);
// each $post is an array (message, permalink_url, full_picture/picture, video, created_time, status_type)
```

Blocks catch exceptions from collectors and log them to the `socialfeed` logger channel, rendering an
empty list on failure.

## `InstagramApiService` (`socialfeed.instagram_api`)

Constants: `API_BASE_URL=https://api.instagram.com`, `GRAPH_BASE_URL=https://graph.instagram.com`,
`FACEBOOK_GRAPH_BASE_URL=https://graph.facebook.com` (Graph version `v24.0`). Key methods:

- `setCredentials($appId, $appSecret, $redirectUri)`
- `getLoginUrl()` — builds the OAuth authorize URL (scope `user_profile,user_media`).
- `getOauthToken($code)` — exchange auth code → short-lived token.
- `getLongLivedToken($token)` — exchange for a ~60-day token.
- `setGraphVersion($version)`

The OAuth callback controller (`InstagramAuthController::accessToken()`, route
`socialfeed.instagram_auth`) wires these together and persists the resulting token to
`socialfeed.instagram.settings`. The callback route requires `administer socialfeed`.

## Theme registration

`socialfeed_theme()` registers `socialfeed_facebook_post`, `socialfeed_twitter_post`, and three
Instagram hooks (`_image`, `_video`, `_carousel_album`), each with a preprocess `.theme.inc` — see
[../theming/render.md](../theming/render.md). No custom plugin types are defined; the blocks use core's
Block plugin type.
