# Webform Email Confirmation Link — manual setup guide

**Webform Email Confirmation Link** (`webform_email_confirmation_link`) adds a
double opt‑in step to any Webform. When someone submits the form, their
submission is held as a *draft* and they are emailed a one‑time confirmation link;
only when they click that link does the submission become complete. It's the
Drupal‑Webform way to prove an email address is real before a signup, registration
or consent counts.

Under the hood it adds a single Webform **handler** called *Email confirmation*.
That handler extends core Webform's ordinary email handler, so it inherits the
full email UI you already know — To/From, subject, HTML and plain‑text body,
conditions and so on. The differences are that new submissions are kept in draft,
and the email body contains a special `[webform_submission:confirmation_link]`
token that builds the confirmation URL.

The link is tamper‑proof: it carries an HMAC signature keyed by your site's hash
salt, so it cannot be guessed or forged, and it only works while the submission is
still a draft — which makes it effectively single‑use. Visiting a stale, altered
or already‑used link shows a friendly error instead. There is no global settings
page; everything is configured per handler on each form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it needs the Webform module).
2. [Configuration](configuration/index.md) — add the *Email confirmation* handler
   to a form and set its options.

## Where it lives in the admin menu

There is no site‑wide configuration screen. You work with the module entirely
from a form's **Emails / Handlers** page — for a given webform, go to *Settings →
Emails / Handlers* and add the **Email confirmation** handler. See
[Configuration](configuration/index.md) for the walkthrough.
