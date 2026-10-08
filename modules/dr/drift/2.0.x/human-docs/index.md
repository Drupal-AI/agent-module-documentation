# Drift - Communication Tool — manual setup guide

**Drift - Communication Tool** (`drift`) integrates the
[Drift.com](https://www.drift.com) live‑chat and conversational‑marketing
platform into your Drupal site. Once configured, it embeds Drift's chat widget so
visitors can start a conversation with your sales or support team, and you manage
the widget's look and behavior from your Drift account.

It's a thin integration: the heavy lifting (the chat interface, routing, and
conversation history) happens on Drift's side. This module's job is to place
Drift's JavaScript snippet on your pages, keyed to your Drift account, and to
give you a small settings form and a permission for controlling it.

Because the widget loads Drift's third‑party JavaScript, it also brings the usual
privacy considerations: Drift can track visitors and set cookies. Pair it with a
cookie‑consent solution and disclose the tracking in your privacy policy, and be
aware that any chat data is handled by Drift under their terms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Drift account
   identifier and control where the widget loads.

## Where it lives in the admin menu

Once enabled, Drift's settings form is available at its configuration route
(`drift.config`). Look for **Drift** under the site **Configuration** menu. Access
to it is governed by the module's own administration permission on **People →
Permissions**.

## How to use it

1. Create a Drift account at [drift.com](https://www.drift.com) and customize your
   chat widget there (its appearance and behavior are configured on Drift's side).
2. Install and enable this module (see [Installation](installation/index.md)).
3. Enter your Drift account identifier / embed code on the module's settings form
   and enable the widget (see [Configuration](configuration/index.md)).
4. Load a front‑end page as a visitor and confirm the Drift chat widget appears.
