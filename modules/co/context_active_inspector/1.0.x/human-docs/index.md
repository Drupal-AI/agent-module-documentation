# Context Active Inspector — manual setup guide

**Context Active Inspector** (`context_active_inspector`) is a small developer
tool for anyone working with the **Context** module. It adds a **toolbar item**
that shows, for the page you are currently looking at, **which contexts are
active** — and lets you navigate into them to see the conditions and reactions
that are firing. When a context is not behaving the way you expect, this is the
fastest way to answer "is this context even matching here, and if so, what is it
doing?" without digging through configuration by hand.

It is purely a **debugging / developer** aid. It depends on core's **Toolbar**
module and the contrib **Context** module, provides its own permission, and has
no access‑control role beyond gating who can see the inspector. It runs on Drupal
9, 10, and 11, and is actively maintained by a team of Ukrainian developers.

Setup is minimal: enable the module and grant the inspector permission to the
admin or developer users who need it. It works immediately — there is no settings
form to fill in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the inspector permission.

There is **no settings form** — the only configuration is granting the
permission, described below.

## How to use it

1. Grant the **access context active inspector** permission to your admin or
   developer roles at **People → Permissions** (`/admin/people/permissions`).
2. Browse the site as a user who has that permission. The **toolbar** gains an
   inspector item.
3. On any page, open the inspector to see the list of **active contexts** for that
   page, and drill in to review each context's **conditions and reactions** — so
   you can tell at a glance why a context is (or is not) firing there.

> **Tip:** The maintainers suggest pairing it with **Gin**, **Gin Toolbar**, and
> **Admin Toolbar Language Switcher** for a nicer administration experience, but
> none of those are required.
