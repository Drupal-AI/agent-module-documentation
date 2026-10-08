<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instagram fetcher (feeds_instagram_fetcher)

Source: `src/Feeds/Fetcher/FeedsInstagramFetcher.php` plus the two form classes and `feeds_instagram.services.yml`.

## Install & enable
```
composer require drupal/feeds_instagram
drush en feeds_instagram -y
```
Pulls in `feeds` and `pcb`; `facebook/graph-sdk ^5.0` is required via composer.json. Prerequisite: an Instagram Business Account connected to a Facebook Page you administer (Instagram Graph API Getting Started, steps 1-2), and a Facebook Developer App.

## The plugin
`FeedsInstagramFetcher extends PluginBase implements ClearableInterface, FetcherInterface`. Annotated `@FeedsFetcher(id = "feeds_instagram_fetcher", title = "Instagram")` with two forms:
- `configuration` → `Form\FeedsInstagramFetcherForm`
- `feed` → `Form\FeedsInstagramFetcherFeedForm`

The class calls `\Drupal::` statically (messenger, cache service, path, renderer, date.formatter) — it is not dependency-injected.

## Configuration (no config object / schema of its own)
`defaultConfiguration()` (plugin-level, stored on the feed type):
- `facebook_app_id` — `''`
- `facebook_app_secret` — `''`
- `import_limit` — `50`

`defaultFeedConfiguration()` (per-feed):
- `facebook_page_id` — `''`
- `instagram_business_account_id` — `''`

`FeedsInstagramFetcherForm::buildConfigurationForm()` renders App ID, App Secret, and import limit (number, `#min 1`, required). `submitConfigurationForm()` `trim()`s all string values before `setConfiguration()`. There is no separate settings route; these live in the feed type's fetcher settings.

## Graph SDK client
`getClientFactory($feed_id)` builds `new Facebook(['app_id' => …, 'app_secret' => …, 'default_graph_version' => 'v9.0'])` only when both app id and secret are set (otherwise a messenger warning "Facebook Open Graph access is not configured."). If a cached access token exists it is added as `default_access_token`. TLS is handled by the SDK's HTTP client (cert verification on by default); the module sets no verify override.

## OAuth token flow (per-feed form)
`FeedsInstagramFetcherFeedForm::buildConfigurationForm()`:
1. No token yet → shows the required redirect URI and an "Authenticate Facebook Account" link built from `$client->getRedirectLoginHelper()->getLoginUrl($redirect_uri, ['pages_read_engagement','pages_show_list','instagram_basic'])`.
2. Facebook returns with a `code` query param → `$helper->getAccessToken()`; if the token is not long-lived, `$client->getOAuth2Client()->getLongLivedAccessToken()` exchanges it. The token is saved via `cache.feeds_instagram_tokens->set($cid, $token, Cache::PERMANENT, [tags])` then the form redirects back.
3. Token present → shows expiry, a "Revoke access" checkbox, and a Facebook Page `select` populated from `me/accounts?fields=id,name`.

`submitConfigurationForm()`: if revoke is checked, `Cache::invalidateTags([cid])` and a status message; otherwise, for the chosen page it requests `{page_id}?fields=instagram_business_account` and stores `facebook_page_id` + `instagram_business_account_id` into the feed config.

## Token cache
Service `cache.feeds_instagram_tokens` (`feeds_instagram.services.yml`) is a `cache.bin` with `default_backend: cache.backend.permanent_database` — this is why `pcb` is a dependency. Cache id: `getAccessTokenCacheId($feed_id)` → `feeds_instagram:facebook_access_token:{feed_id}`. `hook_uninstall()` calls `deleteAllPermanent()` on the bin.

## Fetch lifecycle
- `fetch(FeedInterface $feed, StateInterface $state)` reads the feed's `instagram_business_account_id`, calls `get()`, and wraps the JSON string in `RawFetcherResult` (empty string if `get()` returns FALSE).
- `get($feed_id, $ig_business_account_id)` requests `{account_id}/media`, then walks the Graph edge with a `do/while` that calls `$client->next($media_edge)` for paging, collecting up to `import_limit` items (min clamped to 1). Empty result → status "No media items found."
- `getClientResponse(Facebook $client, $request)` wraps `$client->get()` in try/catch for `FacebookResponseException` / `FacebookSDKException`, adding messenger warnings with `t()` placeholders.
- `clear()` (ClearableInterface) delegates cleanup per feed.

## Parsed media fields (`parseMediaItem()`)
Requests `{media_id}?fields=id,ig_id,shortcode,timestamp,media_type,media_url,thumbnail_url,caption,permalink,like_count,comments_count,owner,username,is_comment_enabled,children,comments` and returns an array with keys: `id`, `instagram_id` (ig_id), `shortcode`, `published_datetime`, `published_timestamp`, `type` (media_type), `media_url`, `thumbnail_url`, `caption`, `title` (caption truncated to 255, else "Instagram post by @username (@ig_id)"), `permalink`, `like_count`, `comments_count`, `owner_id`, `username`, `is_comment_enabled` (1/0), `children`, `comments`. The full list is `json_encode`d for the parser.

## Parser mapping
`hook_help` recommends the JsonPath parser from Feeds extensible parsers with Context `$.*` on the Mapping tab; map the returned keys onto your target entity fields.
