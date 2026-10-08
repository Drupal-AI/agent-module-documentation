# Brevo Webform Handler — manual setup guide

**Brevo Webform Handler** (`brevo_webform_handler`) is a Webform handler that
sends form submissions to Brevo (the email-marketing platform formerly known as
Sendinblue) as contacts. When a Webform is a signup or lead form, the submission
usually needs to become a contact in your marketing platform — this handler does
exactly that, mapping the form's fields onto a Brevo contact and forwarding it
through the Brevo Contacts API.

Because it forwards submissions to an external marketing service, it carries the
same two responsibilities as any such integration. It needs a **Brevo API key** —
a credential to keep out of plain config and out of version control — and it sends
**personal data** (the submission) to Brevo, so the form's privacy posture must
extend to Brevo: disclose the marketing use and capture consent before a
submission becomes a marketing contact.

It builds on the **Webform** module and supports Drupal 10 and 11. There is no
global settings page — you configure it per Webform, as one of that form's
handlers.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (the Webform module),
   installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — adding the handler to a Webform,
   mapping fields, entering the API key, and capturing consent.

## Where it lives in the admin menu

There is no separate module settings page. You add and configure the handler
inside a specific Webform, under its **Settings → Emails / Handlers** tab
(**Structure → Webforms → your form → Settings → Emails / Handlers**).

## How to use it

Enable the module, then open the Webform you want to feed into Brevo, add the
Brevo handler to it, and configure the handler: supply the Brevo API key, map the
form's fields to the Brevo contact fields, and choose the target list. Combine
this with a consent checkbox on the form so that only submissions where the user
agreed become marketing contacts. From then on, each qualifying submission creates
or updates a contact in Brevo.
