# Configuration

Getting Mime Mail working is two steps: set your options on the **Mime Mail
settings** form, then tell the **Mail System** module to use Mime Mail as the
mailer. This page covers both.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Mime Mail**, or navigate directly to
   `/admin/config/system/mimemail`.

## The Mime Mail settings, field by field

- **Sender name** — the display name used as the "from" name on all Mime Mail
  messages. Defaults to your site name.
- **Sender email address** — the "from" address for Mime Mail messages. Defaults
  to your site email.
- **Use simple address format** — when ticked, recipients are addressed as a bare
  `user@example.com` with the display name dropped. Turn this on if some mail
  clients mishandle addresses that include a display name. *(Off by default.)*
- **Include site style** — when on, Mime Mail gathers the default theme's
  stylesheets to style emails when there's no dedicated `mail.css` in the theme
  directory. *(On by default.)*
- **Send plain text only** — converts **all** outgoing messages to plain text.
  This overrides any per‑user choice, and is a useful lever for deliverability if
  HTML mail is causing problems. *(Off by default.)*
- **Link images instead of embedding** — links referenced images externally
  rather than embedding them in the message. Embedding makes images render
  without hotlinking but grows the message; linking keeps messages small.
  *(Off by default — images are embedded.)*
- **Per‑user plain‑text field** — the machine name of a **boolean field on the
  User entity** that lets individual recipients opt out of HTML and receive plain
  text. The selector only lists boolean fields already attached to the User
  bundle, so if you want this, **add the field via Field UI first** (for example
  `field_plain_text_email`), then choose it here. *(Empty by default.)*
- **Text format** — the text format used to render the HTML body.
  *(Default `full_html`.)*
- **Preserve CSS classes** — keeps `class` attributes when CSS is inlined, which
  helps when debugging email markup. This option only appears if the
  `mimemail_compress` component is present. *(Off by default.)*

There is also an **advanced** section for processing *incoming* messages posted
to the site (an "incoming" toggle and a validation key). Leave these off unless
you specifically need inbound mail handling and understand the implications.

Click **Save configuration** when done.

## Make Mime Mail the active mailer (via Mail System)

Setting the options above doesn't route any mail through Mime Mail on its own —
that's the **Mail System** module's job:

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`).
2. Choose **Mime Mail mailer** as the **formatter** (and, if you want, the
   **sender**) — either for the **site‑wide default**, or for a specific module
   and mail key if you only want certain emails to be HTML.
3. Save.

From then on, the selected emails are sent as MIME‑encoded HTML, with your CSS
inlined, images embedded (or linked), and any attachments included.

## Command-line shortcuts

You can read and set the settings with Drush:

```bash
drush config:get mimemail.settings
drush config:set mimemail.settings textonly true -y
```

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`) as needed:

- The permission to **edit the per‑user plain‑text setting** (for users choosing
  plain text over HTML).
- The permission to **attach files from outside the public files directory** —
  restrict this, since it lets code attach arbitrary local files to mail.

## Theming emails (optional)

Emails render through the `mimemail-message.html.twig` template, which you can
override in your theme to brand every message. Theme suggestions let you target a
specific sending module (`mimemail-message--MODULE.html.twig`) or a specific mail
key (`mimemail-message--MODULE--KEY.html.twig`) — for example, giving the user
password‑reset email its own look. See the [`agent/`](../agent/start.md) docs for
the theming details.
