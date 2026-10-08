<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Messages (email_messages) — agent index

Developer utility that stores reusable, translatable **email templates** as config entities and
sends them through a **manager service** that replaces `@variable` placeholders and optionally
**logs** each send. Package `Custom`. Depends only on core **`text`**. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0. No configure link; no Drush.

## What it provides

- **Config entity `email_message`** (`src/Entity/EmailMessage.php`): id, `subject`, `message`
  (`text_format`), `log_message` (bool). Admin at `/admin/structure/email-message`
  (perm `administer email messages`).
- **Content entity `email_message_log`** (`src/Entity/EmailMessageLog.php`): base fields
  description, rendered_message, message (ref → email_message), email, language, uid, created.
  Admin at `/admin/structure/email-message-logs` (perm `administer message log`), plus a bundled
  view gated by perm `access message log overview`.
- **Services**: `email_messages.manager` (`EmailMessageManager`) — load + token-replace + mail;
  `email_messages.renderer` (`EmailMessageRenderer`) — render a build in the front-end theme.
- **Hooks**: `hook_mail()` (key `notification`, HTML) and `hook_views_data_alter()`.
- **Views filter plugin** `email_message` (`src/Plugin/views/filter/Message.php`).
- **Permissions** (`email_messages.permissions.yml`): `administer email messages`,
  `administer message log` (restricted), `access message log overview`.

## Solution docs

- **Sending API — the manager, renderer, hook_mail, tokens, logging** →
  [api/manager.md](api/manager.md)
- **The `email_message` config entity, form, schema, routes/permissions** →
  [entities/email_message.md](entities/email_message.md)
- **The `email_message_log` content entity, fields, view, list builder, Views filter** →
  [entities/message_log.md](entities/message_log.md)
