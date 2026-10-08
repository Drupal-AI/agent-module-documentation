# Inky Integration — manual setup guide

**Inky Integration** (`inky_integration`) wires the Twig **Inky** and
**CSS-inliner** extensions into Drupal so you can author responsive HTML emails
the way front-end teams build them — using
[Foundation for Emails](https://get.foundation/emails.html)' semantic *Inky*
syntax, with CSS automatically inlined for email-client compatibility.

Writing HTML email by hand is painful: email clients require deeply nested tables
and inline `style` attributes rather than modern CSS. This module removes that
pain. It registers two Twig extensions as services:

- the **Inky** extension converts Inky's friendly semantic tags — `<row>`,
  `<columns>`, `<button>`, and so on — into the email-safe table markup email
  clients expect; and
- the **CSS-inliner** extension moves your stylesheet rules into inline `style`
  attributes at render time, no build step required.

It also ships the Foundation for Emails stylesheet
(`css/foundation-for-emails.css`) and an `email-wrap.html.twig` wrapper template,
and makes that template available in the admin theme so you can preview your work.
Despite some wording in the project's README, the module makes **no external
network calls** — it is purely a Twig/templating helper you pair with a mail
module that renders themed emails.

There is nothing to configure: install it, make sure the required PHP extension
and Composer packages are present, and use the Inky syntax in your email
templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable the PHP `xsl` extension, install
   the module with Composer, and enable it.

There is **no configuration page** for this module — it has no settings form. It
provides Twig extensions and templates for developers/themers; how you use them is
covered in "How to use it" below.

## Where it lives in the admin menu

Inky Integration adds no admin page. It works entirely through Twig: once enabled,
the Inky and CSS-inliner extensions are available in your email templates, and the
`email_wrap` template is available (including in the admin theme, for previewing).

## How to use it

In an email body Twig template, use the Inky tags/filter and the CSS-inliner
filter the extensions provide — for example composing layout with `<row>`,
`<columns>`, and `<button>` in Inky syntax and inlining your CSS at render time —
and optionally wrap your content with the provided `email_wrap` template. Pair the
module with a mail module that renders themed emails, and keep the bundled
`css/foundation-for-emails.css` up to date from upstream over time (see the
maintenance note on the [installation page](installation/index.md)).
