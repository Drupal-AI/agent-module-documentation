Mailchimp Transactional routes Drupal's outgoing email through the Mailchimp Transactional (formerly Mandrill) API, via a Mail System mail plugin, with configurable sender, tracking, attachments, subaccounts, and optional queued sending.

---

The module provides two `@Mail` plugins — `mailchimp_transactional_mail` (the real mailer) and `mailchimp_transactional_test_mail` (a test mailer that does not hit the live API) — that you assign through the Mail System module as the site's (or a specific module/key's) sender/formatter. When Drupal sends mail, `TransactionMail::mail()` builds a Mailchimp Transactional message from the Drupal message array: it sets from name/email, resolves To/Cc/Bcc recipients, applies an optional input filter format to the body, attaches files (both `$message['attachments']` paths and Mime Mail-style `$message['params']['attachments']`), and sets tracking, analytics, subaccount, and denylist options from config. Sending is either immediate (through the `Api`/`Service` service, which calls the `mailchimp/transactional` PHP library) or, if `process_async` is on, queued into the `mailchimp_transactional_queue` QueueWorker for delivery on cron. Configuration lives in a single config object `mailchimp_transactional.settings` (API key, from name/email, tracking, timeouts, denylist, async, etc.) edited at `admin/config/services/mailchimp_transactional`; a second tab sends a test email (gated by access checks requiring an API key and that Mail System points at this mailer). It requires the external `mailchimp/transactional` Composer library and the Mail System module, defines the `administer mailchimp transactional` permission, and offers alter hooks for the outgoing message, valid attachment types, and the send result. Three optional submodules add per-entity activity views, reporting dashboards, and template mapping.

---

- Send all of a Drupal site's transactional email through Mailchimp Transactional instead of PHP mail/SMTP.
- Route only specific modules' emails (e.g. webform, commerce) through Mailchimp Transactional via Mail System.
- Configure a verified sender name and address for outgoing mail.
- Track opens and clicks on delivered emails.
- Strip query strings from tracked links (`url_strip_qs`).
- Tag Google Analytics campaigns/domains on outgoing mail.
- Queue outgoing email and send it on cron (async) to avoid slow page requests.
- Set a per-message queue worker timeout for cron sending.
- Send through a Mailchimp Transactional subaccount for segmented sending reputation.
- Apply a text-format filter to email bodies before sending.
- Exclude certain mail keys from having their content stored/viewable (denylist, e.g. password resets).
- Send file attachments, including Mime Mail-style attachments from other modules.
- Restrict the allowed attachment MIME types (or extend them via a hook).
- Migrate an existing Mandrill (drupal/mandrill) configuration automatically on install.
- Send a test email from the admin UI to verify the integration.
- Alter the outgoing Mailchimp Transactional message with a custom module (`hook_mailchimp_transactional_mail_alter` via drupal_alter).
- React to send results (e.g. handle rejected/bounced addresses) with `hook_mailchimp_transactional_mailsend_result`.
- Use a test mailer plugin in non-production environments to avoid real sends.
- Set Reply-To automatically from the From address when a module doesn't provide one.
- Override per-message from address/name and headers via `$message['params']`.
- Provide a single API-key-based email backend for a multisite or containerized deployment (key from env).
- Log queued sends for auditing when async delivery is enabled.
- Combine with the Activity submodule to see per-user delivery history.
- Combine with the Reports submodule for an account-wide sending dashboard.
- Combine with the Templates submodule to wrap Drupal mail in a Mailchimp template.
