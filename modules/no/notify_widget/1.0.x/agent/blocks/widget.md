<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Notify Widget block & popup

## Block plugin

`NotifyWidgetBlock` (`src/Plugin/Block/NotifyWidgetBlock.php`), annotation `@Block(id =
"notify_widget_block", admin_label = "Notify Widget")`. Its `build()` returns nothing but a
`#lazy_builder` callback `notify_widget.lazy_builders:renderNotifyWidgetBlock` with
`#create_placeholder = TRUE`, so the widget is rendered per-user out of the page cache.

Place it via *Structure → Block layout*; the project advises restricting visibility to
authenticated users (an anonymous viewer resolves to uid 0 and simply sees no notifications).

## Lazy builder

`NotifyWidgetLazyBuilders::renderNotifyWidgetBlock()` (`src/NotifyWidgetLazyBuilders.php`, a
`TrustedCallbackInterface`; args `@database`, `@notify_widget.api`, `@current_user`,
`@config.factory`, `@datetime.time`, `@user.data`, `@request_stack`):

- Reads `include_read` and `read_cutoff` from config; converts a non-zero cutoff to an absolute
  timestamp (`request_time − cutoff`).
- Calls `notifyWidgetApi->getNotificationsForUser(0, 0, $includeRead, $readCutoff)` and
  `getUnreadNotificationsCount()`; an unread count over 20 is displayed as `20+`.
- Rewrites each notification's `timestamp` to a relative "time ago" string via the private
  `relativeTime()` helper (minutes/hours/days/weeks/months, and future variants).
- Tracks a per-user "first visit" flag in **user.data** (`notify_widget` / uid /
  `new_to_notifications`); once the empty widget has been shown with no notifications it is set to
  `'no'` so the welcome message stops appearing.
- Attaches library `notify_widget/notifications_popup_css` (bundled CSS) or
  `notify_widget/notifications_popup` (no CSS) per the `use_module_css` setting, and sets cache
  tag `notify_widget:{uid}`.

Render vars passed to the theme: `notifications`, `unread_count`, `uid`, `new_to_notifications`,
`base_url` (the request base path). `hook_theme()` (`notify_widget.module`) declares the
`notify_widget_block` theme.

## Template & libraries

`templates/notify-widget-block.html.twig` renders `#notify_widget` with a `#notify_toggle` link,
an unread `<span class="unread">` badge, and `#notify_widget_popup` listing each notification.
For notifications with a link it wraps the row in
`<a href="{base_url}/notification/{id}/view?destination={link}">` (the
`notify_widget.goto_notification` route — marks read then redirects); the type drives an icon
class `{{ notification.notification_type }}-type`. **All notification fields are printed through
Twig's default auto-escaping** — title/text/type/link are HTML-escaped, so stored content cannot
break out of the markup. Footer links call routes `notify_widget.notifications.mark_all_read` and
`notify_widget.notifications` (both carry the current uid). `js/notify_widget_popup.js`
(`Drupal.behaviors.notify_widget`, using `core/once`) only toggles the popup open/closed on click;
it performs no AJAX and reads no notification data.

Libraries (`notify_widget.libraries.yml`): `notifications_popup` (JS + `core/once`),
`notifications_popup_css` (adds `css/style.css`), and `notifications/dropbutton` (depends on
`core/drupal.dropbutton`, attached by the full-page list).
