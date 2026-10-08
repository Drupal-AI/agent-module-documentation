<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Avoid sending mail (asm) — agent index

Suppresses outbound email addressed to a configured blocklist. It defines a content entity of
blocked addresses and implements **`hook_mail_alter()`** to strip those addresses from a message's
To/Cc/Bcc before delivery — cancelling the send entirely when every To recipient is blocked.
Version **1.0.0-beta2**. Core `^10 || ^11`. License GPL-2.0-or-later. Package *Other*.
Depends only on core **`text`** (used by the `reason` field). Not covered by a security advisory
policy (beta).

## What it actually provides

- **Content entity** `asm_email_blocked` (`src/Entity/EmailBlocked.php`) — base table
  `asm_email_blocked`, `admin_permission = "administer asm email blocked"`, `label` key = `email`.
  Base fields: `email` (email, required, `UniqueField` constraint), `reason` (text_long),
  `created`. Custom storage schema `EmailBlockedStorageSchema` adds an index on `email`.
- **Service** `asm.mail_alter` → `Drupal\asm\MailAlter` (implements `MailAlterInterface`), args
  `@entity_type.manager`, `@module_handler`, `@logger.channel.asm`.
- **Logger channel** `logger.channel.asm` (`asm`).
- **Hooks** (`asm.module`): `hook_mail_alter()` delegates to the service;
  `hook_module_implements_alter()` moves `asm`'s `mail_alter` to run **last**.
- **Alter hook it invokes** (`asm.api.php`): `hook_asm_send_mail_email_blocked_alter(bool &$send,
  array $context)` — lets other modules force-send to a blocked address.
- **Permission** (`asm.permissions.yml`): `administer asm email blocked` (restrict access).
- **No routes, no forms, no config objects, no Drush** in the base module. The UI lives in the
  `asm_ui` submodule.

## Solution docs

- **How blocking works — the `MailAlter` service, header handling, the alter hook, logging** →
  [api/mail-alter.md](api/mail-alter.md)
- **The `asm_email_blocked` entity, fields, storage, permission** →
  [entity/email-blocked.md](entity/email-blocked.md)

## Submodule

- **asm_ui** — admin listing + add/edit/delete forms for the blocklist. Documented in its own tree:
  [../modules/asm_ui/1.0.x/agent/start.md](../modules/asm_ui/1.0.x/agent/start.md).
