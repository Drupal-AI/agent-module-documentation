# Contact Emails — manual setup guide

**Contact Emails** (`contact_emails`) lets each core contact form send one or
more fully configurable emails — each with its own subject, body, recipients and
reply-to — instead of the single recipient list that core Drupal allows. It is
the module you reach for when "send this form to sales *and* support, plus an
auto-reply to the person who filled it in" is more than core can do on its own.

Under the hood it defines a small `contact_email` content entity: one row per
email, attached to a contact form. Each email carries a subject, a formatted
(token-aware) message body, an Enabled flag, and a pair of "where does it go"
choices — a recipient type and a reply-to type. Those can point at a fixed list
of addresses, the person who submitted the form, the value of a field on the
submission, an email field on a referenced entity, the author of the entity in
the current page context, or the site's default address. As soon as a form has
at least one managed email, Contact Emails quietly takes over: core's own contact
mail is suppressed and the form's built-in Recipients / Auto-reply fields are
hidden, so there is never any doubt about which system is sending.

It builds directly on Drupal's core **Contact** module and requires the contrib
**Contact Storage** module (so submissions are stored as entities that other
emails can reference). It adds one permission (`manage contact form emails`), one
small global setting (a UTF-8 charset toggle), and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Contact Storage dependency, and enable the module.
2. [Configuration](configuration/index.md) — add and manage emails on a form,
   the recipient / reply-to options field by field, and the global charset
   setting.

## Where it lives in the admin menu

Once enabled, manage all emails across every contact form from **Structure →
Contact forms → Emails** (`/admin/structure/contact/emails`). Each individual
contact form also grows its own **Emails** tab and operation for editing just
that form's emails. The one global setting lives at **Structure → Contact forms
→ Emails → Settings** (`/admin/structure/contact/emails/settings`).

## How to use it

The typical flow is: build (or reuse) a contact form under *Structure → Contact
forms*, then open its **Emails** tab and add one email per message you want sent.
For each email you set a subject, write the body (using `[contact_message:*]`
tokens if you like), pick who it goes to and who replies land on, and leave it
Enabled. Add a second email to notify a different team, or a "submitter" email to
auto-reply to the visitor. From the moment the first email exists, core stops
sending its own mail and Contact Emails does the work — no custom code required.
