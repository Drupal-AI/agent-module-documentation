# Drip webform handler — manual setup guide

**Drip webform handler** (`drip_webform_handler`) adds a Webform *handler* that
posts form submissions to [Drip](https://www.drip.com), the email‑marketing and
CRM platform. When someone submits a webform you've wired up, their details are
sent to Drip so they become a subscriber or record there — a lightweight way to
feed sign‑ups, contact requests, and lead forms straight into your marketing
automation without any custom code.

In Drupal terms, this is a Webform handler plugin: you don't configure it on a
global admin page, you add it to a specific webform (the same way you'd add an
email or "remote post" handler) and set its options there. It depends on the
**Webform** module.

Talking to Drip requires a Drip API key. Because that key is a credential that
lets anyone act on your Drip account, store it as a secret rather than pasting it
into configuration that gets committed or exported — see the note in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the handler to a webform, supply
   your Drip API credentials, and map fields.

## Where it lives in the admin menu

There is no site‑wide settings page. You configure the handler per webform, under
**Structure → Webforms → *(your form)* → Settings → Emails / Handlers**
(`/admin/structure/webform/manage/{webform}/handlers`), where you add **Drip** as
a handler.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Store your Drip API key as a secret (see [Configuration](configuration/index.md)).
3. Edit the webform you want to connect, open its **Handlers** (Emails / Handlers)
   settings, and **add the Drip handler**.
4. Configure the handler with your Drip credentials and map the form fields to the
   Drip subscriber data, then save.
5. Submit a test entry and confirm the record arrives in Drip.
