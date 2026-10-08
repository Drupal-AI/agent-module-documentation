Contact Emails lets each core contact form send one or more fully configurable emails — with their own subject, body, recipients and reply-to — instead of the single recipient list core allows.

---

The module defines a `contact_email` content entity (one row per email, attached to a `contact_form`) and manages it from *Structure › Contact forms › Emails*. Each email carries a subject, a formatted message body (both token-aware via `contact_message` tokens), an enabled flag, and a `recipient_type` and `reply_to_type` that decide where the mail goes: a manual address list, the form submitter, the value of a field on the contact message, the email on a referenced entity's field, the author of the entity in the current route context, or the site default. When at least one `contact_email` exists for a form, `hook_mail_alter()` suppresses core's own contact mail (`message['send'] = FALSE`) and the form's core recipient/auto-reply fields are hidden, so Contact Emails takes over sending entirely. A single global setting (`contact_emails.settings.allow_charset_utf_8`) controls the UTF-8 charset header. It requires the core `contact` module plus `contact_storage` (so submissions are stored as entities that can be referenced), exposes one permission (`manage contact form emails`), and provides no Drush commands or plugin types.

---

- Send a contact-form submission to several fixed recipient addresses at once.
- Add a second notification email to a form (e.g. one to sales, one to support) with different bodies.
- Send an auto-reply to the person who submitted the form using the "submitter" recipient type.
- Route a submission to an address entered in a form field (recipient type "field"), e.g. a department picker.
- Route a submission to the email of a referenced entity's owner (recipient type "reference").
- Send to the author of the node/entity in the current page context (recipient type "context").
- Fall back to the site default email address for a catch-all email.
- Give each email its own subject line with tokens like the submitter's name or subject.
- Compose an HTML email body using a rich-text format while keeping a plain-text fallback.
- Append the full original message beneath a custom email body.
- Set a per-email Reply-To so replies go back to the submitter instead of the site address.
- Disable an email temporarily by unchecking its "Enabled" flag without deleting it.
- Manage all emails for every contact form from one central list at /admin/structure/contact/emails.
- Add/edit emails scoped to a single form from that form's own Emails tab.
- Replace core's single-recipient contact form with multi-recipient behaviour without custom code.
- Enable the UTF-8 charset header for correct rendering of non-ASCII recipients/subjects.
- Build a "contact a specific team member" form that emails the referenced staff member.
- Send different emails depending on a select-list value stored via contact_storage options.
- Notify an internal address while separately auto-replying to the customer.
- Carbon-copy a manager on every submission by adding a second manual-recipient email.
- Localise subject/body per language (the entity is translatable).
- Programmatically create contact emails during a site install/migration via the entity API.
- Suppress the default core contact email simply by adding one managed email to the form.
- Set the Reply-To to a value pulled from a message field (reply_to_type "field").
