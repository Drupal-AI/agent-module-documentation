Mime Mail is a mail backend (used with the Mail System module) that sends MIME-encoded HTML emails with embedded images and file attachments, themeable with Twig templates and automatic CSS inlining.

---

Drupal core sends plain-text email by default. Mime Mail provides a `mime_mail` mail plugin that other modules can use to send rich HTML messages: it accepts an HTML body, MIME-encodes it, embeds referenced images as message attachments (or optionally links them), and can attach arbitrary files. Because it is a "component" module it is wired up through the Mail System module — you select "Mime Mail mailer" as the formatter/sender for all mail or per module/key. Outgoing HTML is rendered through the `mimemail-message.html.twig` template, so you can brand every email; theme suggestions let you target a specific sending module (`mimemail-message--MODULE.html.twig`) or a specific mail key (`--MODULE--KEY.html.twig`). It gathers your theme's stylesheets (or a `mail.css` in the default theme) and inlines the CSS into style attributes so email clients render it correctly. A settings form controls the default sender name/address, plain-text-only mode, image-linking vs embedding, and an optional per-user boolean field that lets recipients opt out of HTML in favour of plain text. The `MimeMailFormatHelper` utility exposes the low-level formatting routines (address formatting, HTML body assembly, file embedding, header handling). Permissions gate editing per-user settings and attaching files from outside the public files directory.

---

- Send branded HTML transactional email (order receipts, notifications) instead of plain text.
- Embed images inline in emails so they render without external hotlinking.
- Attach files (PDF invoices, tickets, reports) to outgoing messages.
- Convert your theme's CSS into inline styles so email clients render styling.
- Theme a specific module's emails with a dedicated Twig template.
- Theme a single mail key (e.g. user password reset) with its own template.
- Configure a global sender name and address for all site email.
- Force all outgoing mail to plain text site-wide for deliverability.
- Let individual users opt out of HTML email via a boolean field on their profile.
- Link images externally instead of embedding to shrink message size.
- Use the `mime_mail` plugin as the formatter/sender through Mail System.
- Provide HTML email with an automatic plain-text alternative part.
- Send newsletters or digests with rich formatting and images.
- Attach dynamically generated files (CSV exports, entity_print PDFs) to notifications.
- Build custom emails programmatically via `MimeMailFormatHelper`.
- Send arbitrary local files as attachments (permission-gated) from custom code.
- Restrict who may attach files outside the public files directory.
- Preserve CSS class attributes for debugging email markup (with mimemail_compress).
- Send Rules-triggered HTML emails (with the Rules module) on content events.
- Standardize the look of all system emails across a multi-site or multi-theme install.
- Use simple `user@example.com` recipient formatting when clients mishandle display names.
- Send appointment or event confirmations with embedded logos.
- Provide accessible HTML + plaintext multipart messages to all recipients.
- Learn the integration pattern from the bundled Mime Mail Example submodule.
