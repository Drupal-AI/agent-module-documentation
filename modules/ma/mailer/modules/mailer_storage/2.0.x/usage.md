Mailer Storage is a submodule of Mailer. When enabled, every email sent through a Mailer plugin's `send()` is automatically saved as a `mailer_storage` content entity, giving you a browsable, revisionable archive of sent mail plus a one-click "resend" action.

---

Mailer Storage depends on `mailer`. It defines a revisionable content entity type `mailer_storage` (with fields To, Subject, Message, Author, Created) and a config bundle entity `mailer_storage_type` (a "default" bundle ships in config/install). Enabling the module changes Mailer's behaviour: `MailerMailPluginBase::send()` detects the module and persists each outgoing mail as a `mailer_storage` record (bundle `default`). Records are listed at `/admin/content/mailer-storage` and can be viewed, edited, deleted, and resent; the resend form re-sends the stored To/Subject/Message through a bundled `resend_email` MailerMail plugin and saves a fresh record. Access is governed by dedicated permissions (view / edit / delete / create mailer_storage, and administer mailer_storage types). Note: the module's declared `configure` route (`mailer_storage.send_mail_form`) does not exist in this release — configuration is effectively the entity/type collections and Field UI on the bundle.

---

- Keep an audit archive of every transactional email your site sends through Mailer.
- Browse sent mail at `/admin/content/mailer-storage` and open a record to read its rendered body.
- Resend a previously sent email from its record (re-sends To/Subject/Message and logs a new record).
- Add fields to stored mail (Field UI on the `mailer_storage` bundle) to capture extra metadata.
- Group stored mail into bundles by creating additional `mailer_storage_type` types.
- Query or export sent-mail history programmatically via the `mailer_storage` entity storage or Views.
- Restrict who can see or manage the mail archive using the module's per-operation permissions.
- Inspect revisions of a stored mail (the entity is revisionable with revision UI enabled).
