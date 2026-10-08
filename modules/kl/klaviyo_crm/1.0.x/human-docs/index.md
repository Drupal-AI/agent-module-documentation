# Klaviyo CRM — manual setup guide

**Klaviyo CRM** (`klaviyo_crm`) is a native integration between Drupal and
[Klaviyo](https://www.klaviyo.com/), the email/SMS marketing and CRM automation
platform. It syncs contacts and events from your site — for example from
**Webform** submissions — into Klaviyo, and it provides **blocks** for rendering
Klaviyo forms on your pages. The result is that visitor data captured on your
Drupal site feeds directly into your Klaviyo marketing workflows without manual
export/import.

It's a marketing/integration feature rather than an access‑control one: it adds
its own permission for administering the integration, but it doesn't govern who
can see your content. It sits in the **Email Marketing** package and depends on
core **Block** and the **Webform** module.

Because it sends data to a third party, two things are worth being deliberate
about. First, it transmits **contact information (PII) and events to the Klaviyo
API** — that is data egress you should disclose in your privacy policy. Second, it
authenticates with a **Klaviyo API key**, which is a secret: store it in an
environment variable (never in committed configuration) and let the site reach
Klaviyo only over HTTPS. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Block and Webform.
2. [Configuration](configuration/index.md) — enter your Klaviyo API key securely
   and connect your forms/events.

## Where it lives in the admin menu

Once enabled, the module exposes a settings form (in the **Web services** area of
**Configuration**) where you enter your Klaviyo API key, and it adds **Klaviyo
form blocks** you place at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

The typical flow is: enter your Klaviyo API key on the settings form, then decide
what feeds Klaviyo — a Webform whose submissions become Klaviyo contacts/events,
and/or a Klaviyo form block placed in a region. From there, contacts and events
flow to Klaviyo automatically as visitors interact with your site.
