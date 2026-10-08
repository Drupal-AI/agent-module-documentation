<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dismissible Message Bar lets site builders create dismissible notification messages (built from Paragraphs) that render in a block, target specific paths/content types, expire on a date range, and stay dismissed via a browser cookie once a visitor closes them.

---

The module defines a content entity type `dmb_notifications_entity` ("DMB Notification") with a default bundle, plus a `dmb_notification_type` taxonomy vocabulary used to categorize notifications. On install it ships a set of fields on the default bundle: `field_p_content` (Paragraphs content shown in the bar), `field_notification_date_range` (start/end via datetime_range), `field_notification_pages` / `field_excluded_pages` (newline-separated path patterns with `*` wildcards and `!` negation), `field_sitewide`, `field_content_types`, `field_notification_type`, `field_cookie_expiration`, `field_cookie_off`, `field_auto_dismiss`, and `field_dismiss_time`. You place the "DMB Notifications block" (optionally scoped to one notification type) in a region; the block renders a placeholder container and attaches every visible notification's pre-rendered markup and display rules to `drupalSettings.dmbNotificationEntities`, and `js/dismissible_message_bar.js` decides client-side which bars to show based on path, content type, and date, then wires the close button. Closing a bar writes the notification id into the `dismissible_message_bar` cookie (kept for `field_cookie_expiration` days) so it will not reappear; `field_cookie_off` disables that persistence. `DmbNotificationService` (`returnAllNotifications()`, `currentPageHasNotifications()`, `returnNextChangeSecondsFromNow()`) does the server-side query, Paragraph rendering, path/date filtering, and block cache-max-age. Access is permission-gated per operation (add / edit / delete / view published / view unpublished). Rendering goes through the standard Paragraph view builder and Drupal renderer, so notification markup is sanitized by core field formatters.

---

- Show a sitewide announcement banner (e.g. maintenance notice) to every visitor.
- Display a promotional message only on specific paths using `/section/*` wildcard patterns.
- Exclude certain paths from an otherwise sitewide notification (excluded pages override sitewide).
- Limit a notification to specific content types (e.g. only on `article` nodes).
- Schedule a notification to appear and disappear automatically within a start/end date range.
- Let visitors dismiss a message and remember the dismissal via a cookie for a configurable number of days.
- Force a message to reappear on every page load by turning its cookie off.
- Auto-dismiss a bar after a set number of seconds without user interaction.
- Build rich message content (buttons, images, text) using any allowed Paragraph type.
- Categorize notifications with the `dmb_notification_type` taxonomy and scope a block to one type.
- Place multiple notification blocks, each targeting a different notification type, in different regions.
- Publish/unpublish notifications to stage them before they go live.
- Add a body class (`dmb-notification`) when the current page has visible notifications, for theming hooks.
- Style notification bars per type via the type-name-derived CSS class added to each bar.
- Grant a content-editor role the ability to create and edit notifications without full admin access.
- Restrict who can view unpublished (draft) notifications via a dedicated permission.
- Override the notification bar markup with the `dmb_notification` Twig template and entity/bundle/view-mode template suggestions.
- Query current-page notification state programmatically via the notification service.
- Set the block cache max-age to the next scheduled notification change so bars appear/expire without a manual clear.
- Localize notification display per interface language (service is language-aware).
- Reuse the notification entity type in custom code that needs time-boxed, path-scoped messaging.
