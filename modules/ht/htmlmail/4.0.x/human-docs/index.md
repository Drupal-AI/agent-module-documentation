# HTML Mail — manual setup guide

**HTML Mail** (`htmlmail`) replaces Drupal's default plain‑text mail system with an
HTML mailer, so your system emails — user registration, password reset, contact
form replies, commerce notifications — can be themed with Twig templates just like
the rest of your site. Instead of unstyled text, recipients get branded, formatted
HTML messages, and you control their layout with template files rather than code.

The module provides a Drupal mail plugin (`htmlmail`) that formats and sends
outgoing messages as HTML. It works together with the **Mail System** module, which
decides which modules' mail flows through the HTML Mail formatter and sender. Each
message body is rendered through a Twig template using the `htmlmail` theme hook,
with template suggestions so you can style all mail, one module's mail, or a single
specific message — for example `htmlmail--user--password_reset.html.twig`, one of
which ships with the module. You can point these overrides at a dedicated "Email
theme."

Beyond theming, HTML Mail can run an optional post‑filter over the rendered body
(any text format — Emogrifier to inline CSS for webmail, Pathologic to make URLs
absolute, Transliteration to normalize characters), assemble multipart MIME with
attachments via the optional PEAR `Mail_mime` class, attach a plain‑text
alternative, and let individual users opt to receive plaintext‑only mail. There is
a settings form and a "Send test" form under Configuration → System.

> **Release note.** The documented version is **4.0.0‑beta2**, a pre‑stable beta.
> The configuration and API are usable, but the 4.0.x branch has not yet reached a
> stable release — keep that in mind for production sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and route mail through it.
2. [Configuration](configuration/index.md) — the settings form and the test form,
   field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → System → HTML Mail**
(`/admin/config/system/htmlmail`) and the test form at
`/admin/config/system/htmlmail/test`; both require the core **Administer site
configuration** permission. Which modules actually use HTML Mail is chosen on the
Mail System page at **Configuration → System → Mail System**
(`/admin/config/system/mailsystem`).

## How to use it

Enable the module — on install it registers itself as the default mail
formatter/sender through Mail System. Optionally pick an Email theme and add
template overrides to brand your messages, choose a post‑filter such as Emogrifier,
then send yourself a test email from the test form to confirm everything renders as
expected before going live.
