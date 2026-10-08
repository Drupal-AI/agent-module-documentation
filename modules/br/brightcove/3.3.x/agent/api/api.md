# Brightcove entities, services & API wrappers

## Entities

| Entity type | Kind | Notes |
|---|---|---|
| `brightcove_api_client` | config | OAuth credentials + account (see configure/config.md). |
| `brightcove_video` | content | Local mirror of a Brightcove video; source of truth for pushes. |
| `brightcove_playlist` | content | Local mirror of a Brightcove playlist. |
| `brightcove_text_track` | content | Captions/subtitles for a video. |
| `brightcove_player` | config-like | Brightcove players for an account. |
| `brightcove_custom_field` | config-like | Account custom fields. |
| `brightcove_subscription` | config | Notification subscription registration. |

Access handlers: `BrightcoveVideoAccessControlHandler`, `BrightcovePlaylistAccessControlHandler`,
`BrightcoveTextTrackAccessControlHandler` (map to the permissions in permissions/permissions.md).

## `BrightcoveUtil` (static helper — `src/BrightcoveUtil.php`)

The entry point for talking to Brightcove from custom code. Key static methods:

```php
use Drupal\brightcove\BrightcoveUtil;

$client = BrightcoveUtil::getApiClient($id);   // BrightcoveAPIClient config entity
$cms    = BrightcoveUtil::getCmsApi($id);      // \Brightcove\API\CMS
$di     = BrightcoveUtil::getDiApi($id);       // \Brightcove\API\DI (Dynamic Ingest)
$pm     = BrightcoveUtil::getPmApi($id);       // \Brightcove\API\PM (Player Management)
```

Other helpers: `convertDate()`, `checkUpdatedVersion()`, `getStatusQueues()` /
`runStatusQueues($type, $queueFactory)` / `runQueue()` / `clearQueue()` (the sync queue machinery),
`getDefaultPlayer()`, `saveOrUpdateTags()`, `getDefaultSubscriptionUrl()`, and
`runWithSemaphore(callable, ?LockBackendInterface)` (used to serialize callback processing).

`createOrUpdate()` static factories on `BrightcoveVideo` / `BrightcoveTextTrack` build/refresh local
entities from an SDK object.

## Services (`brightcove.services.yml`)

- `brightcove.settings` — typed access to `brightcove.settings`.
- `brightcove.ingestion` — Dynamic Ingest orchestration (mark fields for ingest, expiry).
- `brightcove.logger` — module logger channel wrapper.
- `brightcove.session_manager` / redirect subscriber — post-action redirects.
- `brightcove.expirable_access_token_storage` — OAuth token cache (`brightcove_access_token`).
- `brightcove.access_check` — the `_brightcove_csrf_callback_access_check` route access checker.
- `brightcove.parameter_converter.subscription` — route param converter for subscriptions.

## Inbound callbacks

- `brightcove/ingestion-callback/{token}` → `BrightcoveVideoController::ingestionCallback`. The
  `{token}` is a per-video value stored in the `brightcove_callback` expirable store;
  `CSRFCallbackAccessCheck` allows the request only while that token exists. Finalizes a pushed
  video (TITLE/ASSET handling), runs inside `runWithSemaphore()`.
- `brightcove/notification-callback` → `BrightcoveSubscriptionController::notificationCallback`.
  `_access: 'TRUE'` — on a `video-change` event it loads the API client by the
  posted `account_id`, fetches the video from the CMS API, and creates/updates/deletes local video +
  text-track entities.

## Sync flow

`BrightcoveUtil::runStatusQueues('sync', …)` enqueues each API client; queue workers pull from the
Brightcove CMS API and call the `createOrUpdate()` factories. Triggered by cron (unless
`disable_cron`), the Status Overview form, or the Drush command.
