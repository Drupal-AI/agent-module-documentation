# Entity Browser Multi Widget — manual setup guide

**Entity Browser Multi Widget** (`entity_browser_multi`) lets you put **more than one
Entity Browser button on a single entity-reference field**. Normally an entity
reference field with an Entity Browser widget offers one launcher — one "Browse"
button pointing at one browser. This module provides a field widget, *Entity browser
(multi)*, where several native Entity Browser launchers sit side by side and all feed
into the **same** selection list. An editor can pick from the media library, a
document browser, or an existing-pages browser, and everything they choose lands in
one place.

It is aimed at site builders who need several browse or upload flows on one field
without writing a custom widget. Typical cases: "add an image or a document",
"browse media or existing nodes", or offering two separate curated libraries next to
each other. Each launcher's button label comes from that browser's own modal link
text, and you arrange the launchers with a drag-and-drop table in the widget settings
(the first enabled one is treated as primary). The widget inherits the stock Entity
Browser options — field widget display, edit/remove/replace, selection mode — and its
add-bar layout is theme-agnostic, with optional Gin spacing tokens when the Gin admin
theme is active.

Because it builds on Entity Browser, selection follows Entity Browser's normal access
and selection handling; the module adds no access-control behaviour of its own. It
depends on core **Field** and the **Entity Browser** module (v2), and requires
**Drupal 11.4** and **PHP 8.3+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Entity Browser) and enable it.

There is **no separate configuration page** and no new content type — all setup
happens on a field's form-display widget settings, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You configure it entirely from **Structure → Content
types → (type) → Manage form display**, on the entity-reference field where you
choose the *Entity browser (multi)* widget.

## How to use it

1. Make sure at least one **Entity Browser** already exists on your site (see
   **Structure → Entity browsers**, or however your site provides them).
2. Go to **Structure → Content types → (type) → Manage form display**.
3. On the entity-reference field you want, set the widget to **Entity browser
   (multi)**.
4. Open that widget's settings with the gear/cog icon. Under **Entity browser
   launchers**, enable the browsers you want to offer and drag them into the order
   they should appear — the first enabled browser is the primary one.
5. Save the widget settings and the form display.

Now that field's edit form shows an add-bar with a button per enabled browser, all
adding into a single shared selection list.
