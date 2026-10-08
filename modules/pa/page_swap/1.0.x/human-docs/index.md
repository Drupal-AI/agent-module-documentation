# Page Swap — manual setup guide

**Page Swap** (`page_swap`) gives editors a safe, structured way to promote a new
version of a page onto a live URL — no DNS changes, no cache surgery, no touching
infrastructure. You pick an **original** page and a **replacement**, review a full
execution plan, and apply the swap in one click. The replacement instantly inherits
the original's public URL alias, all the menu items that pointed at the original,
and (optionally) its published status. If the original was set as the site's
homepage, 403, or 404 page, those system settings can be updated in the same step.

This is built for content teams that prepare a new landing page or campaign page
alongside the live site and need a precise, zero‑downtime handoff. Before you
commit, Page Swap renders both pages side by side in iframes and shows an
**execution plan** listing every action it will take — nothing happens until you
click **Apply Page Swap**.

It integrates thoughtfully with related modules: when **Redirect** is present,
automatic redirect creation is temporarily suppressed during the swap to avoid
redirect chains; when **Pathauto** is present, it is prevented from overwriting the
freshly swapped alias. Both affected nodes get a new revision so there is a clear
administrative record, and a `page_swap.executed` event is dispatched for other
modules to hook into. An optional **Swap History** submodule keeps a timestamped,
per‑user log of every swap.

Because a swap has irreversible effects on public URLs and site structure, the
module ships a **restricted** permission — grant it only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the Swap History submodule.
2. [Configuration](configuration/index.md) — grant the permission and walk through
   performing a swap.

## Where it lives in the admin menu

The swap tool is at **Configuration → Content authoring → Page Swap**
(`/admin/config/content/page-swap`). The **Use Page Swap** permission is set under
**People → Permissions** (`/admin/people/permissions`). If you enable the Swap
History submodule, its log appears in a dedicated administration tab.
