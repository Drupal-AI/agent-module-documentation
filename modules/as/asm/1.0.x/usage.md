<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Avoid sending mail (asm) suppresses outbound email whose recipients appear on a configured blocklist, by stripping blocked addresses from the To/Cc/Bcc of every message in hook_mail_alter().

---

The module defines an `asm_email_blocked` content entity (base table `asm_email_blocked`, fields `email`, `reason`, `created`) that stores blocked addresses. Its `MailAlter` service, wired into `hook_mail_alter()`, parses each message's `to` recipients and the `Cc`/`Bcc` headers, looks up which of those addresses exist as blocked entities, and removes them. If every `to` recipient is blocked the whole message is cancelled (`$message['send'] = FALSE`); otherwise only the blocked addresses are dropped and the headers are rewritten. Each removal is logged (debug level) to the `asm` logger channel. A `hook_asm_send_mail_email_blocked_alter()` alter hook lets other modules override the decision per address/message and force the mail through. The base module provides no UI; the bundled `asm_ui` submodule adds the admin collection page and add/edit/delete forms so site builders can manage the blocklist. Everything is gated by the `administer asm email blocked` permission. Supports Drupal 10 and 11; depends only on core `text` (for the `reason` field).

---

- Prevent a staging or dev environment from emailing real customers by blocklisting their addresses.
- Suppress all mail to a specific problematic or bouncing address without disabling site email entirely.
- Stop transactional email (order confirmations, password resets) reaching a set of test/QA accounts.
- Block a role account (e.g. `noreply@`) that should never receive replies.
- Silence notifications to a departed employee's address until it is removed from every list.
- Keep newsletter/digest sends from hitting a seed list of internal addresses.
- Honour a recipient's do-not-contact request centrally, independent of individual module settings.
- Drop email to placeholder/example addresses accidentally left in fixtures or imported content.
- Cancel an entire message when all of its recipients are blocked (no partial leak).
- Trim only the blocked names out of a multi-recipient To/Cc/Bcc, delivering to the rest.
- Record a human-readable `reason` alongside each blocked address for audit purposes.
- Review a dated list of every blocked address via the asm_ui admin table.
- Add, edit, and delete blocked addresses through admin forms (asm_ui).
- Let a custom module force-send to a normally-blocked address for one message id via the alter hook.
- Whitelist a specific address at runtime (e.g. `admin@example.com`) through `hook_asm_send_mail_email_blocked_alter()`.
- Audit blocked-mail activity through the `asm` logger channel / dblog.
- Gate all blocklist administration behind the restricted `administer asm email blocked` permission.
- Integrate transparently with any mail system, since it acts in `hook_mail_alter()` before delivery.
- Enforce a blocklist across every Drupal mail sender without per-module configuration.
- Run on Drupal 10 or 11 with only the core `text` dependency.
