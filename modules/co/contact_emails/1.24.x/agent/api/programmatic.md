# Contact Emails — programmatic API

## Entity

`contact_email` is a `ContentEntityType` (`Drupal\contact_emails\Entity\ContactEmail`). Create,
load, query and delete it through the standard entity API (see field list in
[../configure/manage-emails.md](../configure/manage-emails.md)). Useful entity methods:

- `getSubject(MessageInterface $message)` — tokenized, HTML-to-text subject.
- `getBody(MessageInterface $message)` — rendered body (optionally with the appended message).
- `getFormat(MessageInterface $message)` — the MIME/format string (respects `allow_charset_utf_8`
  and the body text format; falls back to plain text when the format forbids HTML).
- `getRecipients(MessageInterface $message)` — resolves `recipient_type` into an address array.
- `getReplyTo(MessageInterface $message)` — resolves `reply_to_type` into a single address.

## Storage helper — detect / gate emails

`Drupal\contact_emails\ContactEmailStorage` (service via the entity type manager,
`\Drupal::entityTypeManager()->getStorage('contact_email')`) implements
`ContactEmailStorageInterface` with:

- `hasContactEmails(string $contact_form_id): bool` — true if the form has ≥1 email. This is the
  switch the module uses to decide whether to take over sending for a form.

## Services

- `contact_emails.emailer` (`ContactEmailer`) — builds and sends the managed emails for a
  submission (used internally when the contact form is submitted).
- `contact_emails.helper` (`ContactEmails`) — cache-backed helpers over entity fields/bundles.

## How core contact mail is suppressed

`contact_emails_mail_alter(&$message)` runs on core's contact mail ids
(`contact_page_mail`, `contact_page_autoreply`). It loads the `contact_message`, and if
`hasContactEmails($contact_form_id)` is true it sets `$message['send'] = FALSE` so core does not
send its own mail — Contact Emails then sends the configured emails instead. If the
`contact_message` object is missing it also sets `send = FALSE` (fail-safe) and logs a notice to
the `contact_emails` channel.

Also, `contact_emails_form_contact_form_edit_form_alter()` hides the core `recipients`/`reply`
fields on a form that already has managed emails and adds a "managed here" link; and
`contact_emails_entity_operation_alter()` adds an **Emails** operation to each `contact_form` row.

## Tokens

Subject and body are passed through `\Drupal::token()->replace()` with a `contact_message`
data object and `clear => TRUE`, so any `[contact_message:*]` token (and global tokens) work.
