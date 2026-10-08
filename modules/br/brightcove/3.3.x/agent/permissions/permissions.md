# Brightcove permissions

From `brightcove.permissions.yml`.

## Configuration

| Permission | Gates |
|---|---|
| `administer brightcove configuration` | API clients, subscriptions, cron settings, status overview — all admin config/report routes. |

## Video entities (`brightcove_video`)

| Permission | Gates |
|---|---|
| `add brightcove videos` | Create videos. |
| `access brightcove videos overview page` | The `/admin/content/brightcove_video` list. |
| `administer brightcove videos` (restricted) | Video admin/settings form. |
| `edit brightcove videos` | Edit videos (also the manual `/brightcove_video/{id}/update` route, + CSRF). |
| `delete brightcove videos` | Delete videos. |
| `view published brightcove videos` | View published videos. |
| `view unpublished brightcove videos` | View unpublished videos. |

## Playlist entities (`brightcove_playlist`)

Same shape as videos: `add` / `access … overview page` / `administer` (restricted) / `edit` /
`delete` / `view published` / `view unpublished` **brightcove playlists**. `edit brightcove
playlists` also gates `/brightcove_playlist/{id}/update` (CSRF-protected).

## Text Track entities (`brightcove_text_track`)

`add` / `delete` / `view published` / `view unpublished` **brightcove text track entities**.

## Notes

- The two inbound callback routes are **not** gated by these permissions: the ingestion callback
  uses a per-video token access check; the notification callback uses `_access: TRUE`.
- `administer brightcove videos` / `administer brightcove playlists` are flagged
  `restrict access: true` (grant only to trusted admins).
