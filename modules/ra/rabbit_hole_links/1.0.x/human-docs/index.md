# Rabbit Hole Links — manual setup guide

**Rabbit Hole Links** (`rabbit_hole_links`) alters the links Drupal generates to
entities so they respect that entity's
[Rabbit Hole](https://www.drupal.org/project/rabbit_hole) page‑behaviour settings.
Rabbit Hole lets you decide what happens when someone visits an entity's own page —
redirect elsewhere, show *Access denied* (403), show *Page not found* (404), or
display the page normally. But ordinary links (in menus, Views, fields) still point
at the entity's canonical page. This module brings those links in line with the
configured behaviour, so users are not sent to a page that would just bounce or block
them.

It reads each entity's Rabbit Hole configuration and adjusts links accordingly:

- If the behaviour is **Redirect**, the configured redirect URL is used directly, so
  the user avoids the intermediate canonical page and its redirect.
- If the behaviour is **Page not found** or **Access denied**, the link is
  **disabled** — since following it would only lead to a 404 or 403.

Importantly, it honours Rabbit Hole's **bypass permissions**: it only changes a
link's behaviour for users who do *not* have the relevant `rabbit hole bypass
[entity_type_id]` permission. Users who are allowed to bypass Rabbit Hole still get
normal links.

The actual page behaviour and access control are governed by **Rabbit Hole** itself —
this module only aligns the *links* with it and has no access‑control role of its own.

> **A similar module:** [Rabbit Hole href](https://www.drupal.org/project/rabbit_hole_href)
> provides comparable link rewriting but via a Rabbit Hole behaviour plugin, and does
> not disable links for the 404/403 cases. Rabbit Hole Links does the redirect
> rewriting automatically and adds the link‑disabling behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Rabbit
   Hole and enable it.

This module has **no settings form of its own** — it is enable‑and‑go, and all the
behaviour comes from your Rabbit Hole configuration.

## How to use it

1. Install and configure **Rabbit Hole**, setting the desired page behaviour
   (redirect / 404 / 403 / display) on your entities.
2. Enable Rabbit Hole Links.
3. Links to those entities are now adjusted automatically for users who cannot bypass
   Rabbit Hole — redirect links go straight to the target, and links to 404/403
   entities are disabled.
