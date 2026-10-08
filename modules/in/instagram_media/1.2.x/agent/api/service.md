# API client service

Service id `instagram_media.instagram_media_service` → `Drupal\instagram_media\Service\InstagramMediaService`. Constructor args: `@http_client`, `@entity_type.manager`, `@file_system`, `@logger.factory`, `@database`, `@config.factory`. All Graph API calls use the base constant `API_URL = 'https://graph.facebook.com/v22.0/'` (HTTPS).

```php
$svc = \Drupal::service('instagram_media.instagram_media_service');
$svc->updateInstagramMediaData();   // re-fetch + download for every instagram_media block
```

## Public methods

| Method | Graph API call | Returns |
|---|---|---|
| `getFacebookPageId($token)` | `GET me/accounts?fields=id` | first page id or NULL |
| `getInstagramBusinessId($pageId, $token)` | `GET {pageId}?fields=instagram_business_account` | IG business id or NULL |
| `fetchInstagramMedia($igId, $token, $limit=6, $hideVideo=FALSE)` | `GET {igId}/media?fields=id,media_type,media_url,permalink,caption,like_count,comments_count,timestamp,thumbnail_url&limit=` | array of posts (`$limit` capped at 25); when `$hideVideo`, videos become their `thumbnail_url` image |
| `getInstagramLinks($igId, $token)` | `GET {igId}?fields=name,username,profile_picture_url,media_count,followers_count,follows_count` | profile array (falls back to bundled `misc/images/placeholder-avatar.jpg`) or NULL |
| `fetchAndSaveLocalMedia($sourceUrl, $destPath)` | `GET {sourceUrl}` (the `media_url` from the API response) | local file URI, saved under `public://instagram_media/<block_id>/`, or NULL |
| `submitInstagramMediaData($token,$limit,$blockId,$post_caption,$insights,$links,$media_path,$hide_video)` | orchestrates the above for one block | NULL (writes DB) — called from the block submit handler |
| `updateInstagramMediaData()` | same, for **all** `instagram_media` blocks | NULL — called from cron |
| `checkTokenExpiry($token,$appId,$appSecret)` | `GET debug_token` | `expires_at` epoch or NULL |
| `refreshFacebookToken($token,$appId,$appSecret)` | `GET oauth/access_token?grant_type=fb_exchange_token` | new token or NULL |
| `tokenRefresh()` | per block: refreshes when < 24h to expiry and writes new token back to `settings.token` | new token / NULL / FALSE — called from cron |

## Flow (submit and cron)
1. Resolve IG business id: `getFacebookPageId()` → `getInstagramBusinessId()`.
2. `fetchInstagramMedia()` → for each post, `fetchAndSaveLocalMedia()` downloads the media file locally (the directory is purged and recreated first via `prepareMediaDirectory()`).
3. If caption/insights/links are enabled, `getInstagramLinks()` fetches the profile row.
4. `processDatabaseInsertion()` writes rows in a transaction: on submit it deletes only this `block_id`'s rows first; on cron (`updateInstagramMediaData`) it **truncates the whole table** before insert.

## Data tables (`instagram_media.install`)
- `instagram_media_posts` — `id, block_id, media_type, media_url` (local uri), `caption, like_count, comments_count, timestamp, permalink`.
- `instagram_media_links` — `id, block_id, name, username, profile_url, profile_picture_url, media_count, followers_count, follows_count`.

Captions/names are passed through `removeInvalidCharacters()` (strips non-BMP characters, truncates to 255) before storage. `hook_uninstall` deletes `public://instagram_media`.
