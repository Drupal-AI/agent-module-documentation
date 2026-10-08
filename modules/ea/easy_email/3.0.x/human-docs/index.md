# Easy Email — manual setup guide

**Easy Email** (`easy_email`) is a system for sending HTML-formatted emails from
Drupal — welcome messages, receipts, order confirmations, and other
transactional mail — built around reusable **templates**. Each template defines
the subject, HTML and plain-text body, sender identity, recipients (To/CC/BCC),
attachments, and logging behavior, and every field supports **token
replacement**, so you can pull dynamic content straight into the message.

The clever part is that Easy Email models email using Drupal's own entity
system. A template is a config entity (`easy_email_type`); each email you send is
a content entity (`easy_email`) of that template's "type." Because templates are
**fieldable**, you can add fields (say, a reference to an order or a user) to a
template and then use tokens derived from them in the subject, body, recipients —
anywhere. You can preview an email (both HTML and plain text) before it goes out,
attach files dynamically by token or path with security filtering, and every
email that is sent is **logged** as an entity, linked to the recipient's user
account, and browsable under *Reports*.

Easy Email hands the finished message to Drupal's mail system, so you need a real
HTML mailer enabled — **Symfony Mailer** or **Symfony Mailer Lite** — for
delivery to work properly. Two optional submodules extend it: **Easy Email
Commerce** (order emails and Commerce tokens) and **Easy Email Override** (swap
core and contrib emails, like password reset, for your own templates). You can
send emails from the UI, as a Views/bulk action, or programmatically through the
`easy_email.handler` service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the handler API
and event list — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, add an HTML mailer, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create and manage email templates,
   the global settings, permissions, and the email log.

## Where it lives in the admin menu

- **Email templates** live at **Structure → Email templates**
  (`/admin/structure/email-templates/templates`) — this is the module's main
  configure link.
- **Global settings** are at **Structure → Email templates → Settings**
  (`/admin/structure/email-templates/settings`).
- The **email log** of everything sent is at **Reports → Email log**
  (`/admin/reports/email`).

## How to use it

1. Enable an HTML mailer (Symfony Mailer or Symfony Mailer Lite) — see
   [Installation](installation/index.md).
2. Go to **Structure → Email templates** and create a template: set the subject,
   write the HTML body, add tokens for dynamic values, and set the recipients and
   sender.
3. Preview the template to check how it renders.
4. Send it — from the UI, as a Views/bulk **"Send Easy Email"** action, or from
   code via the `easy_email.handler` service.
5. Review what was sent under **Reports → Email log**.

See [Configuration](configuration/index.md) for the full field-by-field
walkthrough of templates and settings.
