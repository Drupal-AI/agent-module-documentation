# Mail Message Templates — manual setup guide

**Mail Message Templates** (`mail_message_templates`) lets you define your site's
outgoing emails — their subjects and bodies — as **configuration entities** you
manage in the admin UI, rather than having that text scattered through code. That
means editors and site builders can adjust email wording without a developer, the
templates can be translated like any other configuration, and they travel with
your configuration export so the same emails move cleanly between environments.

Templates typically support **tokens**, so you can drop in dynamic values (a
user's name, a site name, and so on) that get filled in when the email is sent.
Because templates live as configuration, they're straightforward to review,
version, and deploy alongside the rest of your site.

Mail Message Templates has no dependencies beyond Drupal core and supports Drupal
8 through 11. Note that at the time of writing it is **minimally maintained** and
**not** covered by Drupal's security advisory policy — worth weighing before you
rely on it for a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no single settings form — you work with it by creating and
editing individual template entities, described in "How to use it" below.

## How to use it

Once enabled, you create and manage email templates as configuration entities from
the admin UI. For each template you'll typically set:

- A **label** and machine name so you can identify and reference the template.
- A **subject** line for the email.
- A **body** — the message text, which can include tokens for dynamic values.

Edit a template's wording whenever the message needs to change; because it's
configuration, your changes can be exported and deployed like any other config.

> **A note on tokens.** Since tokens resolve into the sent email, make sure the
> ones you use only surface information you actually intend to send. Avoid tokens
> that could expose sensitive data in a message, and give each template a quick
> test send to confirm the final output reads the way you expect.
