Email Attachment Helper lets module developers attach files to outgoing Drupal emails: when a mail's `params` carry an `attachment` (or `attachments`) entry, it rewrites the message into a `multipart/mixed` MIME body with the file(s) base64-encoded.

---

The module is a small developer helper with no UI, config, routes, or permissions. It implements
`hook_mail_alter()`: when a message being sent through the core `plugin.manager.mail`
(MailManager) has `$message['params']['attachment']` or `$message['params']['attachments']` set,
it calls `_email_attachment_convert_to_multipart()`, which turns the plain message into a
`multipart/mixed` body — the original body becomes the first MIME part and each attachment is
appended with `Content-Transfer-Encoding: base64` and a `Content-Disposition: attachment`
header. Each attachment is described by an array with a required `filename` and optional
`filecontent` (raw bytes; if omitted, the file at `filename` is read from disk) and `filemime`
(guessed from the filename when omitted). Filenames are transliterated and RFC 2184-encoded in
the headers. The module also uses `hook_module_implements_alter()` to run its `mail_alter` last,
so other modules can add attachments to `params` before it converts the message (the bundled
`email_attachment_demo` submodule shows exactly that). You do not call the module directly — you
just populate `params` when invoking `MailManager::mail()`.

---

- Attach a generated PDF report to a notification email sent from custom code.
- Send a CSV export as an email attachment from a batch or cron job.
- Attach an existing file on disk by passing only its `filename` path.
- Attach raw in-memory content by passing `filecontent` (no file on disk needed).
- Attach multiple files to one email via the `attachments` array.
- Explicitly set an attachment's MIME type with `filemime`, or let the module guess it.
- Turn any core-MailManager email into a `multipart/mixed` message with one `params` key.
- Email an invoice or receipt with the document attached.
- Send a QR code or image file alongside a transactional email.
- Attach a `.ics` calendar file to an event confirmation email.
- Let another module add attachments to a mail before this module converts it (runs last).
- Attach a log or diagnostic file to an admin alert email.
- Deliver a one-time export to a user by email without a download page.
- Base64-encode and MIME-wrap attachments without hand-writing MIME boundaries.
- Keep the original message body intact as the first part of the multipart email.
- Attach a file whose name contains non-ASCII characters (transliterated + RFC 2184 encoded).
- Send the same attachment structure through any mail plugin the site uses.
- Add attachments conditionally by only setting `params['attachment']` when needed.
- Provide attachment support to a webform/contact handler by populating its mail params.
- Fail fast with a clear exception when an attachment lacks a `filename`.
- Read attachment bytes from a stream-wrapped URI (`public://…`) via `filename`.
- Standardize attachment handling across several custom mailings in a codebase.
