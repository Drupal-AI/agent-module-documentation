<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — agent index

User-to-user private messaging. Two content entities: `private_message` (one message:
`owner`, `message` text_long, `created`) and `private_message_thread` (a conversation with a
`members` user list + per-user access/delete history). UI is block + AJAX driven; no email
unless the `private_message_notify` submodule is enabled. Global config object:
`private_message.settings`. Configure route: `private_message.admin_config.config`
(`/admin/config/private-message/config`).

- **Send a message / create a thread programmatically, read inbox & unread counts, blocking API** →
  [api/services.md](api/services.md)
- **Global settings keys, admin routes, the three blocks and their settings** →
  [configure/settings.md](configure/settings.md)
- **Plugin types the module defines/uses (`private_message_config_form`, Rules action, not-blocked selection, formatters/widget)** →
  [plugins/plugins.md](plugins/plugins.md)
- **Permissions and what each gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **Hooks you can implement (`hook_private_message_new_message`, `hook_private_message_view_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)
- **Drush command (`private_message:prepare_uninstall`)** →
  [drush/drush.md](drush/drush.md)

Submodule: **Private Message Notify** (email notifications) →
[../../modules/private_message_notify/3.0.x/agent/start.md](../../modules/private_message_notify/3.0.x/agent/start.md)

Key facts:
- Post a message in one call: `\Drupal::service('private_message.thread_manager')->saveThread($message, $recipients)`
  where `$message` is a saved/unsaved `PrivateMessage` and `$recipients` are `User` objects.
- The thread for a set of members is fetched/created by
  `private_message.service`→`getThreadForMembers([$userA, $userB])`.
- Base permission to use the system: `use private messaging system` (plus core `access user profiles`).
