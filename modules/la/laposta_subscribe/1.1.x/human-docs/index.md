# Laposta Subscribe — manual setup guide

**Laposta Subscribe** (`laposta_subscribe`) adds a newsletter **subscribe block**
wired to **Laposta**, the Dutch email‑marketing service. Place the block in a
region and visitors can sign up to one of your Laposta mailing lists directly from
the site; their submissions are sent to Laposta through its API. It is a clean way
to grow a list without sending people off to an external form.

The module keeps things simple: a subscription form you configure and place as a
block, form validation and error handling, optional **Honeypot** spam protection,
and a Twig template you can override to match your theme. It depends on core's
**Block** module and supports Drupal 10 and 11.

Two responsibilities come with connecting to an external marketing service. The
**Laposta API credential** is a secret and should be stored via an environment
variable, never committed to the repository. And because the form sends
**subscriber data to Laposta**, you are handling personal data — make sure you have
appropriate consent and a clear purpose, in line with your privacy obligations.
Administration of the module is gated by the **`administer laposta subscribe`**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — store the API key safely, connect
   your list, and place the subscribe block.

## Where it lives in the admin menu

You configure the Laposta connection on the module's settings form (reachable by a
user with **`administer laposta subscribe`**), and you place the subscribe block
under **Structure → Block layout** (`/admin/structure/block`). See
[Configuration](configuration/index.md).
