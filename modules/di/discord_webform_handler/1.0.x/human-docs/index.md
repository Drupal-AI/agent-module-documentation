# Discord Webform Handler — manual setup guide

**Discord Webform Handler** (`discord_webform_handler`) adds a new **handler** to
the [Webform](https://www.drupal.org/project/webform) module that posts each form
submission to a Discord channel via an incoming **webhook**. Handlers are the
Webform feature that decides "what happens when this form is submitted" — send an
email, POST to a remote service, and so on — and this module contributes one more
option: forward the submission data to Discord.

The problem it solves is real‑time visibility of form submissions. Instead of
waiting for a submissions digest or checking the results table, the relevant team
sees each "Contact us", "Report a bug", or "Sign up" submission land directly in
their Discord channel the moment it arrives.

Setup happens **per webform**, not on a global settings page: you add the "Discord"
handler to whichever forms you want, and paste that form's Discord webhook URL into
the handler's settings. The webhook URL is admin‑entered (not something a visitor
can control). The module depends on the **Webform** module and supports Drupal 10
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Webform must be present).
2. [Configuration](configuration/index.md) — add the Discord handler to a webform
   and set its webhook URL.

## Where it lives in the admin menu

There is no site‑wide settings page. You configure the handler on each individual
form under **Structure → Webforms → *(your form)* → Settings → Emails / Handlers**
(`/admin/structure/webform/manage/<form>/handlers`), where you add the **Discord**
handler. See [Configuration](configuration/index.md) for the steps.
