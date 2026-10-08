Easy Email is an HTML email system for Drupal that models each email as a fieldable content entity built from an `easy_email_type` template, with token replacement, dynamic attachments, CC/BCC, and a searchable log of everything sent.

---

Easy Email splits email into two entities: `easy_email_type` (a config entity "template" defining subject, HTML/plain body, from/reply-to, recipients/CC/BCC, attachments, and logging behaviour) and `easy_email` (a revisionable content entity — one actual email — that is a bundle of its template). Because templates are fieldable, you add entity-reference and other fields to a template and then use token replacement in every field to pull dynamic content into the message. The `easy_email.handler` service (`EmailHandler`) creates, previews, and sends emails; sending runs the message through token, recipient, and attachment evaluator services before handing it to Drupal's mail manager, so it needs a real HTML mailer such as Symfony Mailer or Symfony Mailer Lite. Templates support an optional "inbox preview" line, a plain-text body that can be auto-generated from the HTML, and dynamic attachments specified by token or relative path with configurable scheme/directory and security filtering (allowed/blocked extensions and MIME types, max size). Sent emails are logged as saved `easy_email` entities, automatically linked to the recipient user accounts, viewable at Admin → Reports → Email log, and prunable by a cron purger (also exposed as a Drush command). Global behaviour lives on the `easy_email.settings` config object; templates are managed at Admin → Structure → Email templates. A "Send Easy Email" action plugin, entity lifecycle hooks, and a full set of `EasyEmailEvents` let you extend or trigger sends from Views, rules, or custom code. Two submodules extend it: `easy_email_commerce` (Commerce order emails and tokens) and `easy_email_override` (replace core/contrib emails with Easy Email templates).

---

- Create an `easy_email_type` template with a subject, HTML body, and tokens, then send it.
- Send an HTML transactional email (order confirmation, welcome, receipt) with sensible defaults.
- Add an entity-reference field to a template and address the email from token-derived data.
- Use tokens in every field (subject, body, recipients, from, attachments) for dynamic content.
- Set To, CC, and BCC recipients by user account or by raw email address.
- Configure sender name, from address, and reply-to address per template.
- Provide an "inbox preview" snippet that shows in the client inbox but is hidden in the body.
- Auto-generate a plain-text body from the HTML body, or write one manually.
- Attach files dynamically via tokens or relative paths, with per-template scheme/directory.
- Restrict attachments by allowed/blocked file extension, MIME type, and maximum size.
- Preview an email (HTML and plain text) before sending from the template preview route.
- Generate and send an email programmatically with the `easy_email.handler` service.
- Prevent duplicate sends using the template's unique key and `duplicateExists()`.
- Log every sent email and browse the log at Admin → Reports → Email log.
- Automatically link sent emails to the recipient user accounts to audit what a user received.
- Keep revisions of sent emails and revert/delete them via the revision UI.
- Purge old logged emails automatically on cron, or on demand with a Drush command.
- Send an email as a bulk/Views action with the "Send Easy Email" action plugin.
- React to email lifecycle with `EasyEmailEvents` (presend, sent, token eval, attachment eval, etc.).
- Alter or extend emails with standard entity hooks (`hook_entity_presave`, `hook_entity_update`).
- Deploy email templates and settings as configuration across environments.
- Gate who can create, edit, delete, preview templates and who can view the email log via permissions.
- Configure global attachment security and cron purge behaviour on `easy_email.settings`.
- Send Commerce order receipts with order tokens and rendered order tables (easy_email_commerce).
- Override core user emails (password reset, activation, welcome) with templates (easy_email_override).
- Handle multiple recipients safely when unsafe/per-user tokens require separate rendered messages.
