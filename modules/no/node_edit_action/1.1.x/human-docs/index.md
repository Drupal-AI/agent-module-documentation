# Node Edit Action — manual setup guide

**Node Edit Action** (`node_edit_action`) adds a bulk **"Edit content"** action to
the Content administration page, so power users can **edit several nodes at once**
instead of opening each one in turn. Select the nodes you want on the content list,
choose the Edit content action, and apply your changes to them together — a real time
saver when you're updating many pieces of content in the same way.

It's a small, focused content‑editing helper. It depends only on core's **Node**
module, and it is **access‑correct**: before editing each selected node it checks that
the operator actually has update access to that node, so it never lets anyone edit
content they wouldn't otherwise be allowed to edit. It has no access‑control role of
its own and requires no configuration — install it, and the action is available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — see "How to use it" below.

## Where it lives in the admin menu

Node Edit Action adds no settings page. The **Edit content** action appears in the
bulk‑actions dropdown on the **Content** admin page (`/admin/content`).

## How to use it

1. Go to **Content** (`/admin/content`).
2. Tick the checkboxes for the nodes you want to edit.
3. Choose **Edit content** from the **Action** dropdown and apply it.
4. Make your changes; they are applied to the selected nodes (each one only if you
   have update access to it).
