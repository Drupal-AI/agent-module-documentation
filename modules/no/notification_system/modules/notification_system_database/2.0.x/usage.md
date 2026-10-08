<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification System Database Storage adds a stored notification content entity so notifications live in the Drupal database instead of being generated on the fly.

---

This submodule turns the abstract notification_system framework into something you can create and manage in the admin UI. It defines a translatable `notification` content entity with a title, body, an optional link, a priority, sticky and forced flags, an optional expiry date, and — crucially — a multi-value user audience, so a single notification entity can be addressed to many users at once. A `DatabaseNotificationProvider` plugs those entities into the parent module's provider system, scoping each user's list to notifications whose audience includes them. Read state is not stored on the entity but in a dedicated `notification_system_database_read` table keyed by user and notification, so "read" is per recipient. A cron job keeps the store tidy: it deletes expired notifications, removes a user from a notification's audience a configurable number of days after they read it (and deletes the notification once its audience is empty), and cleans up read records. Creating a notification entity dispatches the framework's NewNotificationEvent, which is what the dispatch submodule listens for.

---

- Create a notification for one or many users from the admin UI.
- Store notifications persistently in the Drupal database.
- Address a single notification entity to a whole list of users.
- Track read state per recipient rather than per notification.
- Auto-expire a notification on a chosen date via cron.
- Purge read notifications a set number of days after everyone has read them.
- Give a notification a priority so it sorts above others.
- Mark a notification sticky so it cannot be dismissed.
- Flag a notification forced so dispatch bypasses user channel settings.
- Attach a link that opens more detail about the notification.
- Categorise a notification with a type string for group mapping.
- Trigger outbound dispatch simply by saving a notification entity.
- Let other modules advertise notification types via db_notification_provider plugins.
- List and bulk-manage stored notifications at /admin/content/notification.
- Configure a read-purge window at /admin/structure/notification.
- Translate notification titles and bodies per language.
- Optionally expose notifications over REST (optional config, off by default).
- Clean up a user's notifications automatically when the account is deleted.
