# API — the notification-update REST endpoint

The dropdown's "mark read", "delete" and "clear all" actions post to a core REST resource plugin
(`rest` is a hard dependency).

- **Plugin:** `Drupal\notifications_widget\Plugin\rest\resource\NotificationWidgetUpdateResource`
- **Resource id:** `notifications_update_widget`
- **Method / path:** `POST /api/notification_update`
- **Enabled by:** `config/optional/rest.resource.notifications_update_widget.yml` — installed
  automatically when `notifications_widget`, `serialization`, and `user` are present. Configured for
  `granularity: method`, `POST` only, `supported_formats: [json]`, `supported_auth: [cookie]`.
- **Access requirement:** the current user must hold core permission **`access content`**.

## Request

Send JSON with `?_format=json`, a `Content-Type: application/json` header and (for cookie auth) an
`X-CSRF-Token` header fetched from `/session/token`:

```json
{ "notiId": 123, "notification_action": "read" }
```

| Field | Values | Meaning |
|---|---|---|
| `notification_action` | `read` \| `delete` \| `clearall` | Which operation to record. |
| `notiId` | numeric (or null for `clearall`) | The `notifications.id` the JS read from the list item's `data-id`. Non-numeric is coerced to `NULL`. |

## What each action writes (always as the current user's uid)

| Action | Table | Row written |
|---|---|---|
| `read` | `notifications_actions` | `notification_id`, `uid`, `status = 1`, `created`. |
| `delete` | `notifications_actions` | `notification_id`, `uid`, `status = 2`, `created`. |
| `clearall` | `notifications_clear_all` | `notification_id` (the newest visible id), `uid`, `created` — the per-user hide watermark. |

Response body on success: `{ "status": "success updated" }`.

## Client flow (`js/notifications.js`, library `notifications_widget/drupal.notifications`)

Attached by the block. Each click handler (`.notification-msg` read, `.notification-remove` delete,
`.clear-all-notification` clear-all, plus a direct-link handler on `.noti-store-msg`) first GETs
`session/token`, then POSTs the payload above with the `X-CSRF-Token` header, and updates the DOM
(unread count, slide/hide, redirect to the item's `data-link`) optimistically.
