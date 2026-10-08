# Email Octopus — manual setup guide

**Email Octopus** (`email_octopus`) connects your Drupal site to the
**EmailOctopus** email‑marketing service. Its headline feature is a placeable
**subscribe block**: you can drop the block into your layout as many times as you
like, each instance bound to a different EmailOctopus list, with its own title,
body text, and thank‑you message. Visitors enter their email, the module validates
it and sends it to EmailOctopus with a "subscribed" status, handling the
"you're already a subscriber" case gracefully. It also gives admins a dashboard
inside Drupal to browse a list's subscribers and unsubscribers.

The module talks to the EmailOctopus REST API over HTTPS, authenticated with an
**API key** you configure once. There is no separate module dependency to install.

A few things are worth knowing before you rely on it in production. The subscribe
block is meant for **anonymous visitors** and ships with **no CAPTCHA or rate
limiting**, so on a public site a bot could submit arbitrary emails and burn
through your EmailOctopus API quota — pair the block with a spam‑protection/CAPTCHA
module. The **API key is stored in plain configuration** (there is no Key module
integration), so treat that config as a secret. And the admin routes are gated by
a permission string (`administer`) that is not a defined Drupal permission, so in
practice they are reachable only by user 1 — if the forms seem inaccessible to
other admins, that is why.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your API key, place a subscribe
   block, and browse subscribers.

## Where it lives in the admin menu

- **API key / settings:** `/admin/config/credentials`
- **Subscriber / Unsubscriber list browser:** `/admin/config/users-list`
- **Subscribe settings:** `/admin/config/susbcribe`
- The subscribe **block** is placed from **Structure → Block layout**
  (`/admin/structure/block`).

The admin forms are effectively restricted to user 1 (see the note above).
