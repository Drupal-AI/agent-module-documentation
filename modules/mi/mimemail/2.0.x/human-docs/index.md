# Mime Mail — manual setup guide

**Mime Mail** (`mimemail`) is a mail backend that sends **MIME‑encoded HTML
emails** with embedded images and file attachments — themeable with Twig
templates and with your CSS automatically inlined so email clients render it
correctly. Drupal core sends plain‑text email by default; Mime Mail provides a
`mime_mail` mail plugin that other modules can use to send rich, branded
messages instead.

Because Mime Mail is a "component" module, it's wired up through the
[Mail System](https://www.drupal.org/project/mailsystem) module — you select the
**Mime Mail mailer** as the formatter/sender either site‑wide or per module and
mail key. Outgoing HTML is rendered through the `mimemail-message.html.twig`
template, so you can brand every email, with theme suggestions to target a
specific sending module or a specific mail key. Mime Mail gathers your theme's
stylesheets (or a `mail.css` in the default theme) and inlines the CSS into style
attributes, embeds referenced images as message attachments (or optionally links
them), and can attach arbitrary files.

Mime Mail **does have a settings form** — it controls the default sender name and
address, a plain‑text‑only mode, whether images are embedded or linked, and an
optional per‑user opt‑out so recipients can choose plain text. It depends on the
**Mail System** module, adds two permissions (editing per‑user settings and
attaching files from outside the public files directory), and ships a
**`mimemail_example`** submodule that demonstrates the integration pattern for
developers.

This guide is written for a **human** setting Mime Mail up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent — including the
`MimeMailFormatHelper` API, the mail plugin, and theming — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Mail
   System, and enable it.
2. [Configuration](configuration/index.md) — the Mime Mail settings form, field
   by field, and how to make it the active mailer via Mail System.

## Where it lives in the admin menu

Its settings form sits at **Configuration → System → Mime Mail**
(`/admin/config/system/mimemail`). To actually *use* Mime Mail as the mailer, you
also configure the **Mail System** module at **Configuration → System → Mail
System** (`/admin/config/system/mailsystem`) and choose the *Mime Mail mailer*.

## How to use it

At a high level: install Mail System and Mime Mail, set your sender details and
options on the Mime Mail settings page, then use Mail System to select Mime Mail
as the formatter/sender (globally, or just for the modules whose emails you want
as HTML). From then on, those emails go out as themeable HTML with inlined CSS,
embedded images, and any attachments. Developers can build messages
programmatically with `MimeMailFormatHelper` and brand emails with per‑module or
per‑mail‑key Twig templates. See [Configuration](configuration/index.md) for the
details.
