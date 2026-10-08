# Current Route Block — manual setup guide

**Current Route Block** (`current_route_block`) provides a block that displays
information about the **current route** — its name, parameters, and path — on
whatever page it's placed. It's a small development and inspection helper aimed at
backend developers and site builders who need to see which route is active while
building or debugging a page.

Knowing the exact route makes it much easier to target the right thing when you're
writing route subscribers, altering pages, adjusting access, or just working out
which controller renders a page. Rather than digging through code or logs, you put
the block on the page and read the details straight off it.

The module adds a single layout block and nothing else — there's **no
configuration page**. It provides its own permission for who may view the block,
and works on Drupal 10 and 11. Because it exposes routing internals, it's meant
for development and staging rather than a production audience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you just place the block, as
described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Place the **Current Route Block** into a region — for local/dev work a visible
   region like Content or a sidebar is convenient.
4. Visit any page and read the route details (name, parameters, path) from the
   block.

Since it surfaces routing internals, keep it to development or staging
environments, and restrict its permission to trusted roles if you place it
anywhere users can reach.
