# Commerce License Access Control — manual setup guide

**Commerce License Access Control** (`commerce_license_access_control`) lets you
sell **access to specific content** with Drupal Commerce. It ties content access
to a **Commerce License**: a customer who holds an active license for a product
gains view, update, and/or delete access to a chosen node — the natural building
block for a members‑only area, paid articles, or a course. When the license
expires or is cancelled, the access goes with it.

It works by adding an **"Access Control" license plugin**. You select this plugin
on a license product the same way you'd pick any other license type, point it at
the node you want to grant access to, and choose which operations (view / update /
delete) the license grants. Under the hood it uses the **ACL** module to apply
per‑node grants, with priorities handled by ACL — useful when several ACL‑based
modules touch the same node. It depends on **ACL** (`acl`) and **Commerce
License** (`commerce_license`).

Because this is **genuine access control** — not just hiding content in the theme
— it's worth being deliberate about verification. Confirm that the mapping between
licenses and content is what you intend, that access is actually **revoked when a
license expires or is cancelled**, and — importantly — that the protected content
isn't reachable by a path that bypasses the license check. Direct file URLs,
JSON:API, REST, and alternate view modes can all sidestep a page‑level gate, so
make sure the license check governs the real entity and file access, not merely the
rendered page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its ACL / Commerce License dependencies.

There is **no dedicated settings page** for this module. You configure it per
license product, on the product variation's license field, as described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin configuration page of its own. You use it where you set up
your **license products** — on a Commerce product variation that has a license
field — under **Commerce → Products**. The ACL grants it creates are managed by the
ACL module behind the scenes.

## How to use it

1. **Enable the module** and its dependencies (see
   [Installation](installation/index.md)). This assumes you already have Commerce
   License working with license‑enabled product variations.
2. On a license product variation, **select the "Access Control" license plugin**
   (the same place you'd choose any other license type).
3. In the **entity field**, pick the **node** you want the license to grant access
   to.
4. **Choose which types of access** the license grants — view, update, and/or
   delete.
5. *(Optional)* If you run **multiple modules that use ACL**, set an **ACL
   priority** for this grant so its precedence relative to other ACL grants is
   predictable.
6. **Test both directions.** Buy the product and confirm the customer can reach the
   content; then let the license expire or cancel it and confirm the access is
   removed. Also try to reach the content while unlicensed via any non‑page route
   (direct file link, JSON:API, REST) to be sure there's no bypass.
