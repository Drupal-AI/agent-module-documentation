<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification System is a framework rather than a feature: it defines what a notification is, a plugin type for producing them, groups for organising them, and a block that renders the current user's unread items.

---

The abstraction is the value. The core module ships no storage and no delivery of its own; it defines a `NotificationProvider` plugin type and a `NotificationSystem` service that fans out across every registered provider to collect a user's notifications, sort them by priority then recency, and optionally bundle them by group. A provider knows how to list notifications for an account and — if it implements `ReadableNotificationInterface` — how to mark one as read. A `Notification` model object carries provider, id, type, an audience of user ids, timestamp, title, body, link, a sticky flag, a priority and a forced flag. `notification_group` config entities let notification types be mapped into named, described groups through a mapping form, and a block renders the current user's notifications in a `simple` dropdown or a `bundled`-by-group layout, delivered over AJAX or rendered inline. When a stored notification is created, a `NewNotificationEvent` is dispatched so other modules (the dispatch submodule in particular) can react.

Around this core, the project ships four optional submodules. `notification_system_database` adds a stored `Notification` content entity with a full admin UI, a per-user read-tracking table, cron-based expiry/purge, and a `DatabaseNotificationProvider` that exposes those entities through the provider system. `notification_system_dispatch` adds outbound delivery: an event subscriber queues notifications, a `NotificationSystemDispatcher` plugin type defines delivery channels, per-user settings decide which channels and groups a user receives, and a send-mode (immediate / daily / weekly) supports bundling. `notification_system_dispatch_mail` and `notification_system_dispatch_webpush` are two dispatcher plugins — Twig-templated email, and browser/Safari web push (the latter via the `web_push_api` contrib module).

---

- Build a notification provider for a custom event source.
- Show a user their unread notifications in a header dropdown.
- Group notifications by category in a bundled display block.
- Mark a notification read from the front end over AJAX.
- Keep a sticky notification that cannot be dismissed.
- Prioritise notifications so urgent items sort first.
- Attach a "read more" link to a notification.
- Aggregate notifications from several providers into one UI.
- Map notification types into named notification groups.
- Describe a group with formatted text shown in the dropdown.
- Store notifications as content entities with an admin list and add form.
- Address a single notification to many users at once.
- Auto-expire notifications on a date and purge read ones after N days.
- Send notifications out by email using a Twig subject/body template.
- Send browser and Safari web-push notifications to subscribed users.
- Let each user choose which channels and groups they receive.
- Offer immediate, daily-summary or weekly-summary delivery (bundling).
- Force a critical notification to a chosen channel regardless of user settings.
- React to new notifications through the dispatched NewNotificationEvent.
- Add a new delivery channel (e.g. Slack) as a dispatcher plugin.
- Reference notifications from another entity via the notification_reference field.
- Render notifications inline instead of over AJAX for no-JS contexts.
