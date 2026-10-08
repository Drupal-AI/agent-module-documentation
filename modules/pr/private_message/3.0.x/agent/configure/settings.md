<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — configuration

## Global settings — `private_message.settings`

Single config object (schema `private_message.schema.yml`). Shipped defaults
(`config/install/private_message.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_notifications` | bool | `true` | Whether the module offers/sends new-message notifications (read by `private_message_notify`). |
| `notify_by_default` | bool | `true` | Send notifications by default; users can override in their profile. |
| `notify_when_using` | string | `'no'` | Notify even while the user is on the PM page (`'yes'`/`'no'`). |
| `number_of_seconds_considered_away` | int | `120` | Idle seconds after which a user counts as "away" from a thread. |
| `hide_recipient_field_when_prefilled` | bool | `false` | Hide the recipient field when a recipient is passed via URL. |
| `create_message_label` | label | `'Create Private Message'` | Label of the create action. |
| `save_message_label` | label | `'Send'` | Label of the send button. |
| `ban_mode` | string | `'passive'` | Blocking mode: `passive` or `active`. |
| `ban_message` | string | `'User is unable to receive your message'` | Shown when a user is blocked. |
| `ban_label` | label | `'Block'` | Block-button label. |
| `unban_label` | label | `'Unblock'` | Unblock-button label. |
| `ban_page_label` | label | `'Block / Unblock users'` | Label of the link to the block page. |
| `autofocus_enable` | bool | `true` | Autofocus the message input. |
| `keys_send` | string | `'Enter, 13'` | Key(s) that send the message. |
| `remove_css` | bool | `false` | Remove the module's bundled CSS (theme it yourself). |

Read/write with Drush:
```bash
drush config:get private_message.settings
drush config:set private_message.settings ban_mode active -y
drush config:set private_message.settings number_of_seconds_considered_away 300 -y
```

## Admin routes / UI

- `private_message.admin_config.config` → `/admin/config/private-message/config` — the main
  settings form (**this is the module's `configure` route**). The form is assembled from
  `private_message_config_form` plugins (see plugins doc).
- `private_message.admin_config.uninstall` → `/admin/config/private-message/uninstall` —
  prepare-uninstall page (deletes all PM content); also available as a Drush command.
- `private_message.private_message_settings` → `/admin/structure/private-message/private-message`
  and `private_message.private_message_thread_settings` →
  `/admin/structure/private-message/private-message-thread` — Field UI base routes for adding
  fields/display to the message and thread entities.

All admin routes require the `administer private message module` permission.

## Blocks (place at /admin/structure/block)

| Block plugin id | Purpose | Settings (schema) |
|---|---|---|
| `private_message_inbox_block` | List of the user's recent threads (AJAX). | `thread_count`, `ajax_load_count`, `ajax_refresh_rate` |
| `private_message_notification_block` | Unread badge. | `ajax_refresh_rate`, `count_method` (messages vs threads) |
| `private_message_actions_block` | Actions (e.g. new message). | — |

Optional block config is provided in `config/optional/block.block.privatemessage*.yml` and is
installed automatically when a compatible theme/block context exists.

## Field formatters & widget (thread entity)

Configured on the thread entity's Manage display / form display:
- `private_message_thread_message_formatter` — renders the conversation (message_count,
  ajax_previous_load_count, message_order, ajax_refresh_rate, view_mode, insert speed/style).
- `private_message_thread_member_formatter` / `private_message_thread_members_number_formatter`
  — render the member list.
- `private_message_thread_member_widget` — recipient autocomplete (match_operator, match_limit,
  max_members, size, placeholder); uses the not-blocked-user selection.
