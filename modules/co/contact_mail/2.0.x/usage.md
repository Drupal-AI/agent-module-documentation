Contact Mail post-processes core Contact-form notification emails: it adds site-wide extra recipients, re-renders the submission as a formatted HTML block, and can send the mail as text/html.

---

Contact Mail is a small utility built on top of Drupal core's Contact module. It implements `hook_mail_alter()` and only touches the two core contact mails (`contact_page_mail` and `contact_page_copy`). From a single admin settings form (`/admin/config/system/contact-mail`) you can: append a fixed list of extra recipient addresses to every contact form so the same team always gets a copy; replace the plain submission body with a rendered HTML block that lists each configured field (label plus value, resolving list/allowed-value labels, entity-reference labels, and file links); prepend a configurable header/"extra information" block above the submission; and add a `Content-Type: text/html` header so recipients receive a formatted HTML email instead of plain text. It requires no third-party libraries — only the core `contact` module — and exposes two alter hooks (`contact_mail_alter_message`, `contact_mail_alter_emails`) so other modules can adjust the message and recipient list.

---

- Add a shared inbox (e.g. sales@ or support@) as an automatic extra recipient on every site contact form.
- CC a whole team on contact submissions without editing each contact form's recipient list individually.
- Send contact notifications as HTML email instead of plain text for nicer formatting in mail clients.
- Replace the terse core submission body with a readable, per-field HTML layout.
- Show human-readable labels for list/select fields instead of raw stored keys in the email.
- Render entity-reference field values as their referenced entity labels in the notification.
- Turn uploaded-file fields into clickable absolute download links inside the email.
- Prepend a standard "Do not reply / find the customer's contact details below" notice to every contact email.
- Add branding or instructions (as an HTML header block) above the submission in outgoing contact mail.
- Keep a consistent notification template across many contact forms from one central config page.
- Ensure a compliance/archive mailbox always receives a copy of contact-form submissions.
- Route contact-form copies to a monitored group address while still emailing the form's own recipients.
- Give staff a formatted table of submitted fields rather than scanning a flat text body.
- Standardize contact email presentation without building a custom mail plugin.
- Let another module programmatically adjust the altered message body via the `contact_mail_alter_message` hook.
- Let another module programmatically adjust or filter the recipient list via the `contact_mail_alter_emails` hook.
- Provide a plain HTML notice header that is reused across all site contact forms.
- Migrate legacy plain-text contact notifications to HTML with minimal configuration.
- Present multi-value list fields as a bulleted-style breakdown in the email body.
