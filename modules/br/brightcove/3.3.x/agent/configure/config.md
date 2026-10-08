# Configure Brightcove

## API Clients — `/admin/config/media/brightcove_api_client`

Config entity `brightcove.brightcove_api_client.*` (`BrightcoveAPIClient`,
`BrightcoveAPIClientForm`). Routes are all under `entity.brightcove_api_client.*`
(collection/add/edit/delete), permission `administer brightcove configuration`. Fields:

| Field | Meaning |
|---|---|
| `id` / `label` | Machine name + label of the client. |
| `account_id` | Brightcove Account ID. |
| `client_id` | OAuth Client ID. |
| `secret_key` | OAuth client secret. |
| `default_player` | Player used by default for this account's videos. |
| `max_custom_fields` | Cap on custom fields fetched for the account. |

On save the form calls `authorizeClient()`, which exchanges client_id/secret for an OAuth access
token (`Client::authorize()`), caches it in the `brightcove_access_token` expirable key-value store
(keyed by client_id, expiry = token TTL − 30s), and verifies the account by calling
`CMS::countVideos()`. Client status is surfaced (`CLIENT_OK` / error message).

## Module settings — `brightcove.settings`

Defaults (`config/install/brightcove.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `defaultAPIClient` | `''` | Fallback API client id. |
| `notification.callbackExpirationTime` | `86400` | TTL (s) for notification callback tokens. |
| `disable_cron` | `false` | Skip the Brightcove sync in `hook_cron`. |
| `ingestion.marked_field_expiry` | `600` | TTL (s) for fields marked pending ingestion. |

Cron behavior is also editable via `/admin/config/system/brightcove_cron`
(`brightcove_cron.settings`, `BrightcoveCronSettingsForm`).

## Subscriptions — `/admin/config/system/brightcove_subscription`

Config entity `brightcove_subscription` registers a Brightcove **notification** endpoint so remote
changes are pushed back to the site (handled at `brightcove/notification-callback`). Controller
routes (`entity.brightcove_subscription.*`): list, add, delete, create, enable, disable,
create-defaults — all `administer brightcove configuration`. Subscriptions cannot be edited (only
created/deleted/toggled).

## Shipped config (installed with the module)

- Taxonomy vocabulary `brightcove_video_tags` (+ form/view displays) — video tags; the module
  forbids editing/deleting this vocabulary and its terms (`hook_entity_access`).
- Image style `brightcove_videos_list_thumbnail`.
- Views `brightcove_video` (all videos) and `brightcove_videos_by_api_client`.

## Status Overview — `/admin/reports/brightcove`

`StatusOverviewForm` shows sync queue status and lets an admin re-run/clear the sync queues
(permission `administer brightcove configuration`).
