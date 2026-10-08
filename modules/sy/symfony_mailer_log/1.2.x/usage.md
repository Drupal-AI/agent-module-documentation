<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailer Plus log records every email sent through the Symfony Mailer / Mailer Plus module as a Drupal content entity, so you can browse, inspect, and audit sent mail from the admin reports section.

---

The module hooks into Symfony Mailer's pipeline with an **EmailAdjuster plugin** called "Log email" (`symfony_mailer_log`). To start logging you add that adjuster element to a Mailer policy (a specific mail type or the catch-all `*All*` policy) at `/admin/config/system/mailer`. When an email is rendered, the adjuster copies its type, subject, from/to/cc/bcc/reply-to, HTML and text bodies, headers, theme, transport DSN, associated user account, and (after send) any error message into a `symfony_mailer_log` content entity. The entries are listed at Admin » Reports » Mail log (`/admin/reports/symfony_mailer_log`). A single settings form controls a master **Enable logging** switch plus optional automatic expiry: a `log_expiry.max_age` ISO 8601 duration (e.g. `P1W`, `P1M`) after which entries are deleted on cron, and a `log_expiry.batch_size` limiting how many are purged per cron run. Three permissions govern viewing, deleting, and administering entries. The module ships an optional Views-based listing and a custom formatter for the HTML body field. It supports both Symfony Mailer 1.x (`LogMail`) and Mailer Plus 2.x (`LogMailV2`) via a shared trait.

---

- Keep an auditable record of every transactional email your site sends.
- Debug "did the password-reset email actually go out?" by checking the mail log.
- Inspect the exact HTML and plain-text body that a recipient received.
- Verify the From, To, CC, BCC and Reply-To addresses used on a sent message.
- Confirm which mail transport (DSN) delivered a given message.
- See the error message recorded when an email failed to send.
- Log only a specific mail type by adding the "Log email" adjuster to just that Mailer policy.
- Log all outgoing mail by adding the adjuster to the `*All*` Mailer policy.
- Turn logging on or off site-wide with the single "Enable logging" checkbox.
- Automatically purge log entries older than one week using `max_age: P1W` on cron.
- Retain a month of mail history with `max_age: P1M` and cap cron deletions with a batch size.
- Prevent the log table growing unbounded on a high-volume site via expiry + batch size.
- Grant support staff a "view symfony mailer log entries" permission without giving them admin.
- Let a cleanup role delete individual log entries with "delete symfony mailer log entries".
- Correlate a logged email with the Drupal user account it was sent to.
- Review the subject lines of recent notifications from one reports page.
- Check the theme used to render a given HTML email.
- Provide QA with proof that a workflow email fired during acceptance testing.
- Programmatically query sent mail (entity type `symfony_mailer_log`) from custom code.
- Build a custom View over logged emails using the shipped optional view as a starting point.
- Trace which headers (e.g. custom `X-` headers) were attached to an outgoing message.
- Diagnose bounce/error patterns by scanning the recorded `error_message` field.
- Keep a lightweight compliance trail of outbound communications.
- Delete all logged mail on module uninstall (the adjuster config is also cleaned from policies).
