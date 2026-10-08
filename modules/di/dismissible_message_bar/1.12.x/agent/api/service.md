<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — DmbNotificationService

Service id `dismissible_message_bar.notification_service`
(`Drupal\dismissible_message_bar\Service\DmbNotificationService`). Injected deps: `path.current`,
`entity_type.manager`, `request_stack`, `renderer`, `language_manager`, `path.matcher`,
`path_alias.manager`.

## Public methods
- `returnAllNotifications(): array` — loads all `dmb_notifications_entity` (query `accessCheck(TRUE)`,
  sorted by `created` DESC), filters out ones that start >24h in the future or ended >24h ago, renders
  each notification's Paragraph content + close link via `renderer->renderPlain()`, and returns a keyed
  array (by notification id) of `['content' => <html>, 'startTime', 'endTime', 'contentTypes',
  'sitewide', 'pathLimit', 'excluded', 'id']`. This is what the block attaches to
  `drupalSettings.dmbNotificationEntities`. Fine-grained path/date filtering is left to the JS.
- `currentPageHasNotifications(): bool` — server-side check whether any notification would show on the
  current request (applies sitewide/content-type/path/excluded/date rules and the dismissal cookie).
  Used by `hook_preprocess_html` to add the `dmb-notification` body class.
- `returnNextChangeSecondsFromNow(): int` — seconds until the next notification start/end boundary
  (or `-1` / PERMANENT if none upcoming). Used as the block's cache max-age.
- `getCurrentContentType(Request $request): string|false` — content type of the current route's node,
  or `false`.

## Notes for callers
- Dismissed notifications are read from `$_COOKIE['dismissible_message_bar']` (dot-separated ids) inside
  `currentPageHasNotifications()`.
- Content is rendered server-side to markup and passed to the client; the block itself is a placeholder
  populated by JS (comment in code: LazyBuilder would not bypass Varnish, hence the JS approach).
