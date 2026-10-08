# Smart Content Lytics — manual setup guide

**Smart Content Lytics** (`smart_content_lytics`) connects the **Lytics**
customer-data platform to [Smart
Content](../../smart_content/3.1.x/human-docs/index.md), so your on-site
personalization can react to a visitor's real-time Lytics profile. It brings the
enterprise-level CDP personalization Lytics offers into Drupal's Smart Content
condition system.

It works by reading your Lytics **user schema** — the profile fields Lytics
exposes — and turning each allowed field into a Smart Content condition. Only the
fields Lytics whitelists through its API are surfaced, and they're mapped to the
appropriate condition types and sorted by label. Site builders can then add
"Lytics" conditions to their segments and target content by a visitor's Lytics
attributes and audiences; at runtime the front-end supplies the visitor's Lytics
attribute values for evaluation.

This submodule adds **no admin pages or permissions of its own** — configuration
happens inside Smart Content's segment authoring, and the Lytics access token
comes from the core Lytics module's own settings. It depends on both **Smart
Content** and the **Lytics** Drupal module, and supports Drupal 10.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **How it talks to Lytics:** to enumerate the available profile fields, the module
> calls the Lytics schema API server-side over HTTPS with normal TLS verification,
> authenticating with the token stored in your Lytics configuration. Your Lytics
> API token must have permission to read the schema and account settings.

## Contents

1. [Installation](installation/index.md) — install and configure the base Lytics
   module first, then install and enable this submodule.

## How to use it

With the core Lytics module installed and configured (including a valid API
token), enable Smart Content Lytics and open a Smart Content Decision Block. When
you author a segment you'll be able to add **Lytics** conditions built from your
allowlisted Lytics profile fields — verify you can see those attributes in the
segment definition as a sign the integration is working. Combine them like any
other Smart Content condition to vary content per Lytics audience.

If you need to troubleshoot, you can turn on verbose console logging in the browser
by setting `localStorage.lytics_smart_content_debug = true`.
