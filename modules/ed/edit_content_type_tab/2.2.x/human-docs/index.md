# Edit Content Type Tab — manual setup guide

**Edit Content Type Tab** (`edit_content_type_tab`), version **2.2.x**, adds a
local task (tab) to node pages that jumps straight to that node's **content type
edit form**. When you're viewing or editing a node, the tab links to
`/admin/structure/types/manage/{type}` for that node's bundle — so you can reach
the type's *Manage fields*, *Manage form display*, and *Manage display* pages
without hunting through **Structure → Content types**. It's a handy shortcut when
templating or site building across a site with many content types.

The tab title is dynamic: it reads the node's bundle and reads `Edit '<Type
Name>' type`, so you can also tell at a glance which content type a node belongs
to. After you finish editing the type, a `destination` parameter brings you back
to the node you started from.

**This 2.2.x release is a navigation shortcut, not a content operation.** Verified
against the source, clicking the tab loads the node, resolves its bundle, and
*redirects* to the content type management form — it does **not** convert,
re‑bundle, or alter the node in any way, and it causes **no data loss**. (This is
worth calling out because the earlier 2.0.x documentation framed the tab as
performing a content‑type change; 2.2.x is purely a jump link.)

Access is gated by the core **"Administer content types"** permission, so only
site builders and administrators ever see the tab. The module defines no
permissions of its own, has **no settings form**, no config, and no dependencies
beyond Drupal core. It works the moment you enable it — the tab appears
automatically on node canonical pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. How to use
it is described below.

## How to use it

1. Make sure the user has the core **Administer content types** permission (site
   builders and administrators have it by default).
2. Visit any node. Among the node's tabs you'll see **Edit '&lt;Type Name&gt;'
   type**.
3. Click it to land on that content type's edit form, where the *Manage fields*,
   *Manage form display*, and *Manage display* links live.
4. Save or navigate away, and the `destination` parameter returns you to the node.
