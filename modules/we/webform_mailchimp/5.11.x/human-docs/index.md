# Webform MailChimp — manual setup guide

**Webform MailChimp** (`webform_mailchimp`) connects your Drupal webforms to
Mailchimp. It adds a **Webform handler** that subscribes people to a Mailchimp
audience (list) whenever they submit a form — mapping the webform's email field
and other fields to Mailchimp merge fields and interest groups. It's the simple
way to turn any newsletter‑signup, contact, or registration webform into a source
of Mailchimp subscribers, with no custom API code.

You add the **MailChimp** handler to a webform, choose the target audience, tell
it which webform element holds the email address, and optionally map extra fields
(first name, last name, and so on) to Mailchimp merge fields, add subscribers to
specific interest groups, toggle double opt‑in, and set a "control" field so only
opted‑in submissions are actually subscribed. Because the handler can be added
more than once, a single webform can even write to several audiences at once.

This module relies on the separate **Mailchimp** module, which holds your API key
and knows about your audiences, merge fields, and interest groups — so you
configure the API connection there, and Webform MailChimp reuses it. The module
itself has **no settings page of its own**: everything lives inside each webform's
handler configuration. You'll need a working Mailchimp account, an API key, and at
least one audience for it to subscribe anyone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect the Mailchimp module.
2. [Configuration](configuration/index.md) — add the MailChimp handler to a
   webform and map its fields.

## Where it lives in the admin menu

There is no dedicated settings page. You add the handler from within a webform:
**Structure → Webforms → [your webform] → Settings → Handlers → Add handler →
MailChimp**. The Mailchimp API key is configured in the separate **Mailchimp**
module's settings (**Configuration → Web services → Mailchimp**).

## How to use it

First connect the Mailchimp module with your API key and confirm your audience is
visible in Drupal. Then open the webform you want to feed Mailchimp, add the
**MailChimp** handler, pick the audience and the email element, map any extra
fields, and save. From then on, each matching submission subscribes the person to
that audience. See [Configuration](configuration/index.md) for the details.
