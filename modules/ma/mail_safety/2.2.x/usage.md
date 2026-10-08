<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Safety intercepts every outgoing email on a Drupal site and, when enabled, stops it from actually being delivered — instead capturing it to an in-site "dashboard" and/or rerouting it to a single safe address so you can test and debug mail without spamming real recipients.

---

Mail Safety is a lightweight development/staging tool built around core's `hook_mail_alter()`. When its `enabled` flag is on, the module sets `$message['send'] = FALSE` on every mail so nothing leaves the server. Two independent switches then decide what happens to the caught mail: `send_mail_to_dashboard` stores a serialized copy of the message in the `mail_safety_dashboard` database table (viewable, resendable, and deletable from an admin dashboard at `/admin/config/development/mail_safety`), and `send_mail_to_default_mail` rewrites the recipient to a single configured `default_mail_address` (stripping Cc/Bcc) and lets that copy send. From the dashboard you can render each caught mail (using the configured mail theme), inspect its full details/`params`, resend it to its **original** recipients, resend it to the **default** address, or delete it; a "Clear" action empties the table. A `log_retention_period` setting drives `hook_cron()` to purge dashboard rows older than the chosen interval. The module invites other modules to participate through four hooks (`hook_mail_safety_pre_insert`, `hook_mail_safety_load`, `hook_mail_safety_pre_send`, `hook_mail_safety_table_structure_alter`) — the documented use being attachment handling. There is no field, entity, or plugin type: all persistent behavior is five keys in `mail_safety.settings` plus rows in one table, gated by two permissions (`administer mail safety`, `use mail safety dashboard`).

---

- Stop a staging or development site from sending any real email while still exercising mail-sending code paths.
- Catch every outgoing mail into an in-site dashboard so you can read exactly what Drupal would have sent.
- Reroute all outgoing mail to a single QA inbox instead of real user addresses.
- Debug a password-reset or registration email by triggering it and reading the caught copy in the dashboard.
- Verify the rendered HTML body of a themed email using the dashboard's body preview (rendered with the configured mail theme).
- Inspect the full `$message` array (headers, params, module, key) of a caught mail via the details view.
- Resend a caught email to its original recipients once you have finished testing.
- Resend a caught email to the safe default address for a second look.
- Delete individual caught mails, or clear the whole dashboard in one action.
- Automatically expire old caught mails by setting a log retention period (purged on cron).
- Prevent accidental bulk emails when running migrations or content imports on a copy of production.
- Give QA a safe environment to test transactional emails (orders, notifications) without touching customers.
- Confirm that a contact form or webform actually generates the expected mail, by reading it in the dashboard.
- Check the exact recipient, subject, and headers a module sets before going live.
- Temporarily silence outgoing mail during a maintenance window without changing SMTP configuration.
- Route caught mail to a shared team address so several testers can review the same messages.
- Combine dashboard capture and default-address rerouting so mail is both stored and delivered to a safe inbox.
- Diagnose why an email "isn't sending" by confirming whether it was generated at all.
- Provide a reroute mechanism similar to reroute_email but with a browsable dashboard of captured messages.
- Extend the caught-mail table with extra columns (e.g. attachments) via `hook_mail_safety_table_structure_alter()`.
- Persist and restore email attachments through `hook_mail_safety_pre_insert` / `hook_mail_safety_pre_send`.
- Keep a short-lived audit of what the site emailed during a test cycle, auto-cleaned by retention.
- Ensure a newly built content type's notification emails render correctly before enabling delivery.
- Lock down email on a client demo site so demo activity never reaches real inboxes.
- Grant testers dashboard access (`use mail safety dashboard`) without giving them the ability to change mail settings.
