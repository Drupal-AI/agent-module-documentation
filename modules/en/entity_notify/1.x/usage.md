<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Entity Notify sends email or Telegram notifications to admins, roles, or custom addresses whenever entities of configured types are created, updated, or deleted.

---

Advanced Entity Notify (machine name `entity_notify`) hooks into `hook_entity_insert`, `hook_entity_update`, and `hook_entity_delete` and, for every enabled entity type, sends a short notification carrying the event name (insert/update/delete) and a canonical absolute link to the affected entity. Recipients are configurable per channel: the uid=1 admin, all active users holding selected roles, a comma-separated custom mail list, and — for comments — the author of the commented node. Delivery goes through Drupal core mail (`hook_mail`) and/or Telegram bots via the required `telegram_api` module, which supports a custom API endpoint, an optional queue for deferred sending, and an optional SOCKS5 proxy. Node and comment types are configured through per-bundle third-party settings on their type edit forms; all other content entity types are enabled globally on the settings page at `/admin/config/system/entity_notify`. A global on/off switch and an ignore-paths list let operators suppress notifications (for example on local environments or specific edit paths). The notification body deliberately contains only the event and the entity URL, not entity field values, so the sensitivity of what is disclosed equals the sensitivity of the link destination — direct notifications to an appropriately private inbox or Telegram chat.

---

- Email the uid=1 administrator whenever any node is created.
- Notify a "Moderator" role by email when a new comment is posted.
- Send a Telegram alert to a private chat when an editor updates content.
- Watch a custom content entity type (for example a webform submission or product) for changes.
- Email a comma-separated list of external stakeholders on entity deletion.
- Notify the author of a node when someone comments on it.
- Route notifications to multiple Telegram chat IDs at once.
- Use a Telegram bot instead of email where inboxes are not monitored.
- Configure different recipients per node bundle (Article vs. Page).
- Configure different recipients per comment type.
- Suppress notifications on specific paths such as `/node/1/edit` via the ignore-paths list.
- Disable all notifications on local/dev with the global enable switch (works with Config Split).
- Defer Telegram delivery to cron/drush using the queue option under heavy write load.
- Send Telegram messages through a SOCKS5 proxy where the API is network-restricted.
- Point Telegram delivery at a self-hosted/custom Bot API endpoint.
- Track create/edit/delete activity for audit-trail style awareness.
- Alert admins the moment a new user-generated entity appears for moderation.
- Restrict who can change notification settings with the `administer entity_notify configuration` permission.
- Combine role recipients and a custom mail list for the same event.
- Get an absolute canonical link in every message to jump straight to the entity.
- Notify on newly created taxonomy terms or other custom entities enabled globally.
- Keep moderators informed without granting them Drupal admin access.
- Escalate content events to a team Telegram channel for fast response.
- Pair per-bundle settings with roles so each content type notifies the right team.
