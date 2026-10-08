# Email Attachment Demo — agent index

Example submodule of **email_attachment**. Not for production. Shows how one module adds an
attachment to another module's mail via `hook_mail_alter()` + `params`.

Key facts:
- `EmailAttachmentDemoHooks::mailAlter()` (attribute `#[Hook('mail_alter')]`): for
  `$message['id'] === 'contact_page_mail' `it adds
  `$message['params']['attachment'] = ['filename' => __FILE__]` (its own source file). The parent
  email_attachment module (which runs its `mail_alter` last) then makes the email
  `multipart/mixed` with that file attached.
- `hook_install` seeds a placeholder recipient (`example@the-domain-name-goes-here.com`) on
  `contact.form.feedback`.
- **Depends on `email_attachment` and the hidden core `contact_test` module**, so it normally
  **cannot be enabled** on a standard site — treat it as sample code.
- No config, routes, permissions, services (beyond the hook class), or Drush.

The reusable technique (attachment `params` structure, multipart conversion) is documented on the
parent: [../../../../1.6.x/agent/api/attachments.md](../../../../1.6.x/agent/api/attachments.md).
