<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Notify — agent index

Submodule of Private Message. Emails thread members when a new message arrives, using the
Message + Message Notify stack. No routes, permissions, config schema, or Drush of its own; it
reads the parent's `private_message.settings` and per-user data. Parent module docs:
[../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md).

- **The notifier service, send-decision logic, the shipped message template & fields** →
  [api/notifier.md](api/notifier.md)
- **Excluding recipients from a notification (`hook_private_message_notify_exclude`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Entry point: implements `hook_private_message_new_message()` →
  `private_message_notify.notifier`→`notify($message, $thread)`.
- Sends only when `private_message.settings:enable_notifications` is true **and** the recipient
  is eligible (user pref or `notify_by_default`) **and** considered away (unless `notify_when_using`).
- Notification is a `message` entity of template `private_message_notification` sent via
  `message_notify.sender`.
