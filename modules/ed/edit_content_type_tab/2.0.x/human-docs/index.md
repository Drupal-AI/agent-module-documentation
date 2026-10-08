# Edit Content Type Tab — manual setup guide

**Edit Content Type Tab** (`edit_content_type_tab`), version **2.0.x**, adds a tab
to a node that deals with the node's **content type (bundle)**. In this release
line the module's own documentation frames the tab as a way to **change a node's
content type** — re‑bundling a node from one type to another in place, for cases
where content was created under the wrong type. It's part of the Development
package and aimed at site builders working across many content types.

> **A note on versions:** the later **2.2.x** release describes this tab
> differently — as a pure *navigation shortcut* that jumps to the content type's
> edit form without ever altering the node. If you want the safe, non‑destructive
> "jump to the type settings" behavior with no risk of data loss, prefer 2.2.x and
> read its guide. This 2.0.x guide preserves the caution appropriate to a version
> documented as performing a content‑type change.

Because changing a node's content type is a **powerful, potentially destructive
operation** — it can drop or remap fields, losing data when the target type
lacks a field the source had — this is not a routine editorial action. Restrict
the tab to **trusted administrators**, test on non‑critical content first, and
back up before any bulk conversions. The module adds no access‑control layer of
its own; it relies entirely on the tab route's access, so make sure that access is
limited to roles you trust.

This module works the moment it is enabled — there is **no settings form** to
configure. The tab appears on nodes for users whose role passes the route's access
check.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. Everything
below covers how to use it and how to keep it safe.

## How to use it — carefully

1. Enable the module only on sites where re‑bundling is genuinely needed.
2. Limit which roles can reach the tab to trusted administrators.
3. **Back up your database** before converting content, and try any conversion on
   a throwaway node first to confirm which fields survive.
4. Avoid it as an everyday editorial tool — it is a site‑builder utility, not a
   content‑editing convenience.
