# Last Updated — manual setup guide

**Last Updated** (`updated`) gives you controlled display of a node's "changed" (last
updated) date. It provides a placeable **block** that prints a node's last-updated
timestamp, plus a per-node checkbox — with a per-content-type default — so editors decide
which nodes actually show their updated date.

Core stores a "changed" date on every node, but showing it isn't always appropriate: a
"last updated" line builds trust on news or documentation, yet looks odd on an evergreen
landing or policy page. This module lets you decide, node by node. Each node gets a
**"Display updated date"** checkbox (grouped under a "Page display options" section on
the edit form), and each content type gets a default for that checkbox. The **Last
Updated date block** then shows the date only on nodes where the checkbox is ticked — it
is automatically hidden everywhere else.

The block is configurable: you can set a prefix (e.g. "Last updated on", "Revised on"),
pick any site date format or a custom PHP date format, and force a specific timezone. A
permission, **Administer node last updated date**, controls who may toggle the checkbox
(editors without it see the setting but can't change it). The output has its own theme
template so themers can style it. Note the permission and block govern only *this*
module's way of showing the changed date — not other approaches like Layout Builder.

This guide is written for a **human** setting the module up through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no single settings page. Instead you work in three familiar places:

- **Block layout** (**Structure → Block layout**, `/admin/structure/block`) to place and
  configure the "Last Updated date block".
- **Content type edit forms** (**Structure → Content types → *(type)* → Edit**) to set
  the per-type default.
- **Individual node edit forms** to toggle the date on or off for one node.
- **People → Permissions** to grant *Administer node last updated date*.

## How to use it

### 1. Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), pick a region (typically
the main content region, before or after the page content), and add **Last Updated date
block**. In its settings you can configure:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Date prefix** | "Last updated on" | Text shown before the date. |
| **Date format** | Custom | A site date format (e.g. Short, Medium, Long) or "Custom". |
| **Custom date format** | `F j, Y g:ia` | A PHP date format used when Date format is "Custom". |
| **Timezone** | *(empty)* | A specific timezone; empty means the site/user default. |

The block only resolves on node pages (it needs a node in context), and it renders
nothing if a node has no changed date.

### 2. Choose which content shows the date

- **Per content type default:** on a content type's edit form there's a **"Display
  updated date."** checkbox under "Page display defaults". Ticking it makes new nodes of
  that type default to showing the date. (You might, say, default Pages on and Articles
  off.)
- **Per node:** on each node's edit form there's a **"Display updated date"** checkbox
  under "Page display options" (in the sidebar). Tick it to show the date on that node,
  untick it to hide it. This overrides the content-type default for that node.

The block appears only on nodes where this checkbox is ticked — that's the access gating
that keeps the updated date off pages where "last updated" would be misleading.

### 3. Control who can toggle it

Grant the **Administer node last updated date** permission at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to change the checkbox.
Users without it still see the setting, but it's disabled, so they get the configured
default without being able to override it.
