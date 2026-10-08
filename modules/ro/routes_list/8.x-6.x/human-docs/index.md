# Routes List — manual setup guide

**Routes List** (`routes_list`) adds a developer/auditor report that shows **every
registered route on your site in one place** — path, name, controller, and access
requirements — at `/admin/reports/routes-list`. Drupal offers no such overview out
of the box, so when you're debugging routing or auditing a site, this single
dashboard is genuinely handy: you can find a route by name, see which controller
handles a path, and review each route's access configuration at a glance.

That last point is also why it's useful as a **security check** — you can scan for
routes that are unexpectedly open to everyone and confirm no hidden URLs are
active with full access to anyone.

Precisely because a full route inventory is a **map of your site's entire
surface**, it is valuable to a developer and equally valuable to an attacker.
Access to the report is gated by a dedicated **access routes list** permission,
and you should keep it that way — grant it only to trusted developers and
administrators, never broadly. Consider enabling the module when you need it and
keeping the permission tightly scoped the rest of the time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set the permission.

There is **no settings form** — the module simply adds the report page described
below.

## Where it lives in the admin menu

The report lives under **Reports → Routes list** (`/admin/reports/routes-list`).

## How to use it

1. Grant the **access routes list** permission (at **People → Permissions**) to
   the trusted roles that should see the report — and only those.
2. Go to **Reports → Routes list** to view every registered route with its path,
   name, controller, and access information.
