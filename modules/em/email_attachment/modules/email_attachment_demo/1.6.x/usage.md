Email Attachment Demo is a non-production example submodule of email_attachment: it implements `hook_mail_alter()` to attach its own hook source file to the core contact form's email, demonstrating how another module adds an attachment via message `params`.

---

The submodule exists purely to show the email_attachment pattern in action. Its
`EmailAttachmentDemoHooks::mailAlter()` checks the message id and, for `contact_page_mail`
(the core Contact module's site-wide contact form mail), adds an `attachment` to
`$message['params']` pointing at its own file (`__FILE__`). Because email_attachment runs its own
`mail_alter` last, it then converts that message into a `multipart/mixed` email with the file
attached — so submitting `/contact` sends a mail with the demo's source file attached. It also
sets a placeholder recipient (`example@the-domain-name-goes-here.com`) on the contact feedback
form at install. It depends on `email_attachment` and on the hidden core test module
`contact_test`; the latter is why it generally **cannot be enabled on a normal site** (Drupal
hides `*_test` modules), so it is best read as sample code rather than installed. Its docs here
describe the pattern; the eval cases are grounded in State fixtures and in re-creating the demo's
attachment through the parent module rather than by enabling the submodule.

---

- Learn how to attach a file to another module's email via `hook_mail_alter()` and `params`.
- See the exact place to add `params['attachment']` before email_attachment converts the message.
- Copy the pattern for attaching a file only to a specific mail id (`contact_page_mail`).
- Demonstrate attaching a file by path (`filename` = `__FILE__`, no `filecontent`).
- Show that email_attachment runs last so a `mail_alter` like this one takes effect.
- Use as a reference when adding attachments to contact-form emails.
- Illustrate gating attachment logic on `$message['id']`.
- Provide a working example for tests of the email_attachment module.
- Show how an install hook can seed a contact form recipient for the demo.
- Serve as a template for attaching generated files to transactional mails.
- Explain why `*_test` dependencies keep a demo module out of production.
- Verify the parent module's multipart conversion end-to-end during development.
- Model conditional attachment (only for one message id) in custom code.
- Reference for wiring a hook-implementation service class (`EmailAttachmentDemoHooks`).
- Demonstrate the `#[Hook('mail_alter')]` attribute style used in current Drupal.
- Show a minimal, no-config submodule structure alongside a parent module.
