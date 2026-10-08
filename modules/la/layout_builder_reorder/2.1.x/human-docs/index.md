# Layout Builder Reorder — manual setup guide

**Layout Builder Reorder** (`layout_builder_reorder`) fills a gap in core's Layout
Builder: it lets you reorder whole **sections**. Core Layout Builder happily
reorders blocks *within* a section, but there's no built‑in way to move an entire
section up or down — short of deleting it and re‑adding it in the right place.
This module adds **Move up** and **Move down** links to each section so editors
can rearrange them in place.

It's a small runtime enhancement with **nothing to configure**. Once enabled, each
section in the Layout Builder UI that has a *Configure* control also gains a
**Move up** link (on every section except the first) and a **Move down** link (on
every section except the last). Clicking one performs the move over AJAX, so the
layout preview updates immediately without a full page reload. The reordering
respects the same access as the rest of Layout Builder — it adds no new
permission.

The change lands in Layout Builder's temporary store, exactly like any other edit,
and becomes permanent when you click **Save layout**. It works wherever Layout
Builder is used — both a content type's default layout and per‑entity overrides on
individual nodes. Uninstalling the module simply removes the links; your existing
section order is untouched.

It depends only on core's **Layout Builder** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration page — enabling the module is all it takes.

1. Edit any layout that uses Layout Builder — for example **Structure → Content
   types → [type] → Manage display → Manage layout**, or the **Layout** tab on an
   individual node that allows overrides.
2. Each section now shows **Move up** / **Move down** links alongside its
   *Configure* control. Click one to move that section; the layout re‑renders
   right away.
3. Click **Save layout** to make the new order permanent (unsaved changes stay in
   the Layout Builder draft, as with any other edit).

You can restyle the links if you like — they carry the CSS classes
`layout-builder__link--rearrange`, `--up`, and `--down`.
