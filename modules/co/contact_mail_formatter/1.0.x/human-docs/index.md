# Contact Mail Formatter — manual setup guide

**Contact Mail Formatter** (`contact_mail_formatter`) replaces the plain-text email
that a core Contact form normally sends with a **configurable HTML template** that
supports Drupal **tokens**, including the contact message's own field tokens. In
short, it lets you send branded, formatted HTML notifications from contact-form
submissions instead of a bare text email.

The problem it solves is that core contact emails are plain text with a fixed
layout. This module adds a **Mail Formatter** section to each contact form's
add/edit screen where an administrator turns on HTML mail for that form, picks one
of the bundled templates (Template 1, 2, or 3) or chooses **Custom HTML**, and
edits the body in a CKEditor (`full_html`) field with a token browser. At send
time, the module fills in the tokens from the actual submission, sets the email's
`Content-Type` to `text/html`, and wraps the body in document tags when needed. It
even adds handy `site:logo` and `site:logo-url` tokens for putting your logo in the
template.

It depends on core's **Contact** module and the **Token** module. It also works
best with an HTML-capable mail transport — the project recommends the **SMTP**
module with "send emails formatted as HTML" enabled, since your mail system needs
to actually deliver HTML for the formatting to reach recipients.

A note on safety: configuring the templates is limited to users who can administer
contact forms, so there's no anonymous configuration surface, and the HTML template
itself is authored by a trusted admin. Visitor-submitted field values only enter
the email through token replacement, which the module runs with the token system's
default **sanitizing** (HTML-escaping) behavior — so submitter input can't inject
markup or scripts into the outgoing mail.

Setup is per contact form; there's no central settings page. See
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Token, and ideally SMTP for HTML delivery).
2. [Configuration](configuration/index.md) — enable HTML mail per contact form,
   pick a template, and insert tokens.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it per contact form at
**Structure → Contact forms → *(your form)* → Edit**
(`/admin/structure/contact/manage/<form>`), in the **Mail Formatter** section the
module adds to that form.
