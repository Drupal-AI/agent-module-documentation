# Configuration

HTML Mail has two forms under Configuration → System: a settings form and a "Send
test" form. This page covers both.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → HTML Mail**, or navigate directly to
   `/admin/config/system/htmlmail`.

## Settings, field by field

- **Email theme** — choose an enabled theme whose `templates/` directory holds your
  email template overrides. Leave it unset (the default) to use the module's own
  templates only. This is how you brand your mail: copy `htmlmail.html.twig` into
  the chosen theme and customize it, or add suggestions like
  `htmlmail--user--password_reset.html.twig` for specific messages.
- **Post‑filter** — a text format to run over the message body *after* it has been
  themed. The default is *Unfiltered*. Common choices suggested in the UI:
  - **Emogrifier** — inlines CSS into `style` attributes for reliable display in
    webmail and on mobile.
  - **Pathologic** — rewrites relative URLs to absolute so images and links work in
    the recipient's inbox.
  - **Transliteration** — converts non‑ASCII characters to ASCII equivalents,
    avoiding smart‑quote artifacts.
- **Use Mail MIME** — assemble the message with the PEAR `Mail_mime` class (it must
  be installed; the form validates this on save). Enables multipart MIME with
  attachments.
- **Provide plain‑text alternative** — attach a plain‑text version alongside the
  HTML, which can improve spam‑filter scores. This option appears when *Use Mail
  MIME* is enabled, and also acts as a "force plain" gate at send time.
- **Debug** — append debugging information (which template and theme resolved, the
  parameters) to the message. Handy while building templates; turn it off for
  production.

Click **Save configuration** when done.

## Send a test email

Open the test form at **Configuration → System → HTML Mail → (Send test)**
(`/admin/config/system/htmlmail/test`). Fill in a recipient, subject, and body and
send it to verify your templates, theme, and post‑filter render correctly before
relying on HTML Mail for live traffic. If you enabled **Debug**, the test message
shows which template and theme were used.

## Per‑user plaintext preference

Users who hold the **Choose plaintext email** permission
(`choose htmlmail_plaintext`) get a checkbox on their account form to receive
plaintext‑only mail. When set, HTML Mail respects that preference and does not send
them HTML.
