# Extra Block Types (EBT): Views — manual setup guide

**Extra Block Types (EBT): Views** (`ebt_views`) adds an **EBT Views** block type
that embeds an existing **View** inside an EBT‑styled block. Instead of building a
custom block plugin or a block display in every view, you create an EBT Views block,
point its Views Reference field at a view and display, and place the result — with all
the EBT background, spacing, and container styling applied around it.

It is part of the **Extra Block Types (EBT)** family, built on the shared **EBT
Core** base (`ebt_core`) for the common design options, and it depends on the
**Views Reference** module (`viewsreference`) for the field that picks the view. The
module is configuration‑ and template‑only: it defines the block type, its fields,
and Twig templates, with no routes, controllers, services, or permissions of its own.
The embedded view keeps its own access controls, so wrapping it in an EBT block does
not change who can see its results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Views adds no configuration page of its own. You use it by creating and placing
an **EBT Views** block: **Content → Blocks → Add content block → EBT Views**, then
place it in **Layout Builder** or at **Structure → Block layout**.

## How to use it

1. Make sure the view you want to embed already exists.
2. Go to **Content → Blocks → Add content block → EBT Views**.
3. In the **Views Reference** field, pick the view and display (you can also pass
   arguments / contextual filters and control the pager where the view supports it).
4. Optionally add body text above or around the embed.
5. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block. Updating the referenced view later updates
   the embed automatically — no need to re‑place the block.
