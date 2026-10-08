<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Message Notify is a submodule of Private Message that emails users when they receive a new private message, built on top of the Message and Message Notify modules.

---

The submodule implements `hook_private_message_new_message()` so that whenever a message is added to a thread (via `PrivateMessageThreadManager::saveThread()`), its `private_message_notify.notifier` service runs. For each thread member the notifier decides whether to send using `private_message.settings` (`enable_notifications`, `notify_by_default`, `notify_when_using`, `number_of_seconds_considered_away`) combined with per-user preferences stored in user data (`receive_notification`, `notify_when_using`, `number_of_seconds_considered_away`) — skipping the message author and anyone away/opted-out. When a notification should be sent, it creates a `message` entity of the shipped `private_message_notification` template (with `field_message_private_message` and `field_message_pm_thread` referencing the message and thread), sets it to the recipient's preferred language, saves it, and sends it through `message_notify.sender`. The template's token-based text renders the sender name, message body, and a link back to the thread. Other modules can suppress recipients through `hook_private_message_notify_exclude()`. The submodule adds no routes, permissions, config schema, or Drush commands of its own.

---

- Email a user automatically when they receive a new private message.
- Reuse the Message/Message Notify pipeline so notification content is a configurable Message template.
- Customise the notification email by editing the `private_message_notification` message template text/tokens.
- Respect each user's per-profile notification preferences (receive, notify-while-using, away threshold).
- Fall back to site defaults (`notify_by_default`, `notify_when_using`) when a user has made no choice.
- Only notify recipients who have been "away" from the thread longer than the configured threshold.
- Globally turn notifications on or off with `private_message.settings:enable_notifications`.
- Exclude specific recipients from a notification (e.g. muted conversations) via `hook_private_message_notify_exclude()`.
- Send notifications in each recipient's preferred language.
- Skip the message author so senders are not emailed their own messages.
- Integrate private messaging with any Message Notify delivery channel/plugin.
- Log a warning when a would-be recipient has no email address instead of failing.
- Trigger notifications from any code path that posts a message through the thread manager.
- Localise notification subject/body through the message template's mail_subject / mail_body view displays.
- Provide a link straight back to the conversation from the notification email.
