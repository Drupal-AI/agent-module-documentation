# Block — the notification bell dropdown

- **Plugin id:** `notification_widget_block`
- **Class:** `Drupal\notifications_widget\Plugin\Block\NotificationsWidgetBlock`
- **Admin label / category:** "Notification widget block" / "Notifications widget"
- **Theme hook:** `notifications_widget` (template `templates/notifications-widget.html.twig`)
- **Library attached:** `notifications_widget/drupal.notifications`
- **Cache:** `getCacheMaxAge()` returns 0 (never cached).

Place it via *Structure → Block layout* (or config). It renders a Bootstrap-style bell with an unread
badge and a dropdown list; the template expects Bootstrap/Glyphicon CSS to be present in the theme.

## Access

`blockAccess()` returns allowed for **any authenticated user** (`$account->isAuthenticated()`). It does
not define or check a module permission.

## Per-instance settings (`blockForm`)

| Setting | Type | Meaning |
|---|---|---|
| `block_notification_type` | select | `0` = "As Admin", `1` = "As Logged-In user". |
| `block_notification_logs_display` | checkbox "Skip Display to own activities" | Default TRUE. Combined with the type to pick the uid filter (below). |

## What `build()` queries

1. Look up the current user's newest `notifications_clear_all` row → `startingNotiId` (0 if none).
2. Select from `notifications` where `id > startingNotiId`, then apply the uid filter chosen by the
   two settings:

| `block_notification_type` | `…logs_display` | Extra condition | Effect |
|---|---|---|---|
| 1 (logged-in user) | 1 (skip own) | `entity_uid <> current uid` | Items whose recipient isn't you. |
| 1 (logged-in user) | 0 | (none) | All items. |
| 0 (admin) | 1 (skip own) | `uid <> current uid` | Activity by users other than you. |
| 0 (admin) | 0 | (none) | All items. |

3. Order by `created` DESC. For each row, look up the current user's `notifications_actions` marker
   for that `notification_id`: `status == 2` (deleted) rows are skipped; `status == 0` counts toward the
   unread total.
4. Pass to the template: `uid`, `notification_type`, `total`, `unread`, and `notification_list`
   (each item: `id`, `nas_id`, `message`, `status`, `created`).

The template prints each `message` with the `raw` filter (messages are stored as pre-rendered,
token-replaced anchor HTML) and wires the `data-id`/`data-nas-id` attributes the JS posts back.
