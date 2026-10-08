<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail suppression — the `MailAlter` service

## Wiring

`asm.module`:
- `asm_mail_alter(&$message)` (implements `hook_mail_alter()`) calls
  `\Drupal::service('asm.mail_alter')->alterMessage($message)`.
- `asm_module_implements_alter()` re-appends `asm` in the `mail_alter` implementation list so this
  module's alter runs **last** (after any other module has finished editing recipients).

Service (`asm.services.yml`): `asm.mail_alter` → `Drupal\asm\MailAlter`, constructed with
`@entity_type.manager` (used to grab the `asm_email_blocked` storage), `@module_handler`, and the
`@logger.channel.asm` channel.

## `MailAlter::alterMessage(array &$message): void`

1. Parses `$message['to']` into a map of `normalized-email => original-string` via
   `parserEmails()`.
2. `cleanEmails($emails, $message, 'to')` drops blocked addresses from that map.
   - If addresses remain, `$message['to']` is rewritten as `implode(', ', $emails)`.
   - If **none** remain, `$message['send'] = FALSE` — the whole message is cancelled.
3. Only if `$message['send']` is still truthy, it repeats the same clean/rewrite for the `Cc` and
   `Bcc` **headers** (`$message['headers']['Cc']` / `['Bcc']`), setting the header to `''` when all
   of its recipients were blocked. (Note: an all-blocked Cc/Bcc empties that header but does **not**
   cancel the message; only an all-blocked `to` cancels.)

## `cleanEmails(array &$emails, array $message, string $type): void`

- Entity query on `asm_email_blocked` storage: `->getQuery()->accessCheck(FALSE)
  ->condition('email', array_keys($emails), 'IN')->execute()` — matches the message's normalized
  addresses against stored blocked entities. `accessCheck(FALSE)` is correct here: this is an
  internal filter run during mail delivery, not a user-facing listing.
- For each loaded blocked entity, it builds `$context = ['email_blocked' => <address>, 'message' =>
  $message, 'type' => <to|Cc|Bcc>]`, defaults `$send = FALSE`, then invokes
  `moduleHandler->alter('asm_send_mail_email_blocked', $send, $context)`.
- If `$send` is still FALSE, the address is removed from `$emails` (and collected for logging).
  If a module set `$send = TRUE`, the address is kept (force-sent).
- Any removals are logged at **debug** level to the `asm` channel, naming the header type, the
  removed addresses, and the message `id`.

## Address parsing

- `parserEmails(string $emails)` splits on `,`, trims, and calls `getEmailDetail()` per token,
  keying results by the extracted full address.
- `getEmailDetail(string $email)` uses two `preg_match` patterns to accept both a bare
  `user@domain` (RFC 822) and a `Display Name <user@domain>` (RFC 2822) form, supporting domain
  literals (`[ipv4]` / `[ipv6]`). It returns `full_email`, `email_name`, `domain`, `from_name`.
  Malformed tokens yield no match and are ignored. Comparison to the blocklist is on the extracted
  address, so display names do not affect matching.

## The alter hook (override to force-send)

`asm.api.php` documents `hook_asm_send_mail_email_blocked_alter(bool &$send, array $context)`.
Set `$send = TRUE` to deliver to an otherwise-blocked address. `$context` carries `email_blocked`
(the blocked address), `message` (the `hook_mail` array, so you can branch on `message['id']`), and
`type`. Example: force-send whenever `$context['email_blocked'] == 'admin@example.com'` or when
`$context['message']['id'] == 'mymodule_somekey'`.

## Operating notes

- Blocking is transport-agnostic: it happens in `hook_mail_alter()`, before any mail plugin sends,
  so it works regardless of SMTP/Symfony Mailer/etc.
- Matching is exact on the stored address string; there is no wildcard/domain-level blocking.
- Populate the blocklist with the `asm_ui` submodule (or programmatically create
  `asm_email_blocked` entities).
