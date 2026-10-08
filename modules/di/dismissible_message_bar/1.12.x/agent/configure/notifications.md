<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure notifications

There is **no admin settings form** (`configure` is null). Configuration is: (1) create notification
entities, (2) place the block. All state lives on the `dmb_notifications_entity` content entity, not in
config.

## Entities & taxonomy created on install
- Content entity type `dmb_notifications_entity` (label "DMB Notification") with a `default` bundle
  (`dismissible_message_bar.type.default`). Add more bundles at `/admin/structure/dmb_notification_types`.
- Taxonomy vocabulary `dmb_notification_type` — terms used to categorize notifications and to scope a block.
- A view `dmb_notifications` (admin listing).

## Create a notification
1. `/dmb_notifications/add` → pick a type → fill fields → save.
2. Place block `dmb_notifications_block` ("DMB Notifications block") at `/admin/structure/block` in a region.
   In the block form, optional **Notification type** (`taxonomy_block`, an autocomplete to a
   `dmb_notification_type` term) scopes the block to one type.

## Default-bundle fields (all created by `config/install` + `.install` updates)
| Field | Type | Purpose |
|---|---|---|
| `field_p_content` | entity_reference_revisions (Paragraphs) | The bar's content. Edit the field to allow the Paragraph types you want. |
| `field_notification_date_range` | daterange (datetime_range) | Start/end window the bar may display. |
| `field_sitewide` | boolean | Show on all pages, ignoring path limits (still overridden by excluded pages). |
| `field_notification_pages` | string_long | Newline-separated allowed path patterns; `*` wildcard. |
| `field_excluded_pages` | string_long | Newline-separated excluded patterns; **overrides** sitewide. |
| `field_content_types` | entity_reference (node_type) | Limit to specific content types. |
| `field_notification_type` | entity_reference (taxonomy term) | Category; its name becomes a CSS class on the bar. |
| `field_cookie_expiration` | integer (default 365) | Days a dismissal cookie persists. |
| `field_cookie_off` | boolean | If set, dismissal is NOT remembered (adds `cookie-off` class). |
| `field_auto_dismiss` | boolean | Auto-hide the bar after a delay. |
| `field_dismiss_time` | integer (default 15, max 120) | Seconds before auto-dismiss / display time. |

## Path pattern syntax
Server side (`DmbNotificationService`) and client side both normalize each non-empty line: trailing
slash trimmed (except `/`), leading slash enforced, and a leading `!` negates (`!/admin/*`). `*` is a
wildcard. Path matching uses core `path.matcher`.

## How display is decided
- The block renders only a placeholder container and attaches `drupalSettings.dmbNotificationEntities`
  = `DmbNotificationService::returnAllNotifications()` (each entry: pre-rendered `content`, `startTime`,
  `endTime`, `contentTypes`, `sitewide`, `pathLimit`, `excluded`, `id`).
- `js/dismissible_message_bar.js` selects which bars to show by path / content type / date, injects the
  rendered markup, and binds the close link. Closing appends the id to the `dismissible_message_bar`
  cookie so it stays hidden for `field_cookie_expiration` days.
- Block cache: contexts `url.path` + `cookies:dismissible_message_bar`; max-age =
  `returnNextChangeSecondsFromNow()` (so bars appear/expire on schedule); cache tag `dmb_block`.

## Theming
- Twig template `dmb_notification.html.twig`; theme hook `dmb_notification`.
- Suggestions per view mode, bundle, and id (e.g. `dmb_notifications_entity__default`,
  `dmb_notifications_entity__<id>`).
- `hook_preprocess_html` adds body class `dmb-notification` when the current page has visible bars.
- Library `dismissible_message_bar/dismissible_message_bar` (the JS + CSS) is attached by the block.
