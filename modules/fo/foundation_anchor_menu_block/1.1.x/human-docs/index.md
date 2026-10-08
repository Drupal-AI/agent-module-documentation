# Foundation Anchor Menu Block — manual setup guide

**Foundation Anchor Menu Block** (`foundation_anchor_menu_block`) generates
in‑page "jump" navigation — the kind of anchor menu that scrolls you to a specific
section when you click it — built dynamically from whatever is on the current page.
It's styled with [ZURB Foundation's Magellan](https://get.foundation/sites/docs/magellan.html)
component, which makes it a natural fit for one‑page sites and long‑form content
where readers need a shortcut to the section they care about.

Rather than you hand‑curating the menu, the module scans the rendered page with
JavaScript for elements carrying the right classes and data attributes, collects
those anchor targets, and feeds them into a Foundation Magellan anchor menu. As the
reader scrolls, Magellan highlights the section they're currently in.

To supply anchor targets, the module provides a custom block type, **Anchor Custom
Block**, with two fields: an **ID** (the anchor target's id, used as the scroll
destination) and a **Title** (the human‑readable label shown in the menu — if you
leave the title empty, that anchor is simply left out of the menu). You can also
place anchor targets with plain HTML markup, or embed Anchor Custom Blocks straight
into the CKEditor WYSIWYG, since the module registers an entity‑embed button and a
matching entity browser for them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the
   asset‑packagist requirement for the Foundation library) and enable the module.

This module has **no dedicated settings page**. You use it entirely by placing its
block and adding anchor targets, described in "How to use it" below.

## Where it lives in the admin menu

There is no settings form to visit. You work with the module from the **Block
layout** page (**Structure → Block layout**) where you place the dynamic anchor
menu block, and from the **Text formats and editors** page
(`/admin/config/content/formats`) if you want to add the anchor entity‑embed button
to CKEditor.

## How to use it

1. Make sure your theme is a **ZURB Foundation** theme (or otherwise loads the
   Foundation Sites library), since the anchor menu relies on Foundation's Magellan
   component for its styling and scroll behaviour.
2. Go to **Structure → Block layout** and place the **Dynamic Anchor Menu Block**
   in a region — a sidebar works well so the menu stays visible while reading.
3. Give the page some anchor targets. You have three options, and you can mix them:
   - **Add an Anchor Custom Block** — place one or more *Anchor Custom Block*
     instances (in Block layout, in Layout Builder, or embedded via the WYSIWYG).
     Fill in the **ID** (the scroll target) and the **Title** (the menu label).
     Blocks with no title are skipped in the menu.
   - **Embed in the WYSIWYG** — add the module's entity‑embed button to your text
     format at `/admin/config/content/formats`, then editors can drop Anchor Custom
     Blocks directly into body content through the provided entity browser.
   - **Write plain HTML** — add elements with the expected id/data attributes so the
     JavaScript picks them up as targets.
4. Load a page that has anchor targets — the anchor menu builds itself from what it
   finds and scrolls to each section on click.

> **Tip:** The module exposes a `famb:init` JavaScript event you can hook into — for
> example to remove the anchor menu block entirely when a page has no anchors.

> **Not using Foundation?** The module deliberately emits Foundation classes. On a
> Bootstrap or other framework you'd need to adapt the classes; the maintainers
> welcome issues or patches to generalise it.
