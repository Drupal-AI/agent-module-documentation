<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blind Carbon Copy adds one configured Bcc recipient to every email the site sends.

---

The mechanism is deliberately small: a `hook_mail_alter()` implementation appends a single admin-configured address to the `Bcc` header of every outgoing message when the feature is enabled. There is one global address and one on/off switch — no per-mail-key rules, no exclusions, no Cc or Reply-To handling, no tokens. The address is entered on the module's own settings form (`/admin/config/system/bcc-settings`, gated by the restricted `administer bcc settings` permission) as an email-typed field, so it is trusted, format-validated admin config rather than anything a visitor can influence. The reasons organisations want this are all variations on wanting a copy: an archive of what was sent, so a support conversation can be reconstructed; a shared inbox that sees registration and order confirmations so someone notices when they stop arriving; a compliance requirement to retain outbound correspondence; or simply debugging, because "did the email go out" is otherwise unanswerable from inside Drupal. Version **4.0.1** on `^9 || ^10 || ^11`. **This is a data-protection decision before it is a configuration one, and it deserves to be treated that way**, because a blanket BCC copies things people did not expect to be copied. Every password reset link the site sends now also arrives in the BCC mailbox — and a reset link is a credential, so that mailbox becomes able to take over any account on the site. Every one-time login link, every account activation, every message containing personal data a user submitted, every order with an address on it, goes to the same place. Three consequences follow. **The BCC mailbox needs the protection of the most sensitive thing in it**, which is account takeover, so it should be a controlled address with restricted access rather than a team alias people forward from. **This module has no exclusion feature** — it cannot exempt password resets or one-time-login mail from the copy, so if that matters you must weigh whether the archive is worth what it unavoidably collects, or scope the address (a dedicated, tightly held mailbox) accordingly. And **recipients are not told**, which is what BCC means — so if the copy is for compliance rather than debugging, the privacy notice has to say the correspondence is retained, and the retention period has to be real rather than "forever in a mailbox". Note the volume caveat from the maintainers: a bulk send to 1,200 users produces 1,200 BCC copies.

---

- Archive all outgoing site email to one mailbox.
- Send a copy of every message to a shared inbox.
- Debug whether email is actually being sent.
- Retain outbound correspondence for compliance.
- Monitor registration and activation confirmations.
- Keep a copy of order and checkout emails.
- Notice when a class of email stops arriving.
- Feed a customer-service inbox with site mail.
- Archive notifications for an audit trail.
- Copy contact-form emails to a team address.
- Reconstruct a support conversation from copies.
- Gauge a site's outbound mail volume.
- Keep a record of every sent notification.
- Support a records-retention policy.
- Copy webform submission emails to reviewers.
- Diagnose a "missing email" report from a user.
- Monitor transactional mail from commerce flows.
- Archive membership and renewal correspondence.
- Verify a new SMTP/mail provider is delivering.
- Capture a copy of one-time-login and reset mail (accepting the takeover risk that implies).
