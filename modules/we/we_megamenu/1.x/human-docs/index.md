# We Mega Menu — manual setup guide

**We Mega Menu** (`we_megamenu`) turns any ordinary Drupal menu into a rich,
multi-column "mega menu" — the kind of big, full-width dropdown panel you see on
large marketing and e-commerce sites, where a top-level item opens into several
columns of grouped links, and you can even drop images, videos, forms, or Views
into the panel. It comes with a visual, drag-and-drop backend builder so you lay
the dropdowns out by eye rather than in code.

Importantly, it works *on top of* your existing menus rather than replacing them.
You keep creating and organising menu links the normal way under **Structure →
Menus**; We Mega Menu then layers a visual builder over the top where you split
each dropdown into rows and columns, set column widths, assign Drupal **blocks**
into columns, add icons and captions to items, and control per-menu behaviour like
whether dropdowns open on hover or click, their open/close animation, and whether
the whole thing collapses to a hamburger menu on mobile.

Each menu you style produces a matching **"Mega Menu" block**, which you place in a
region (usually the header) to render it on the front end. A single permission,
**Administer Mega Menu**, controls who can use the builder. The module bundles its
own styling and JavaScript (Bootstrap, jQuery UI, Chosen), so there's nothing extra
to download, and it works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — building a mega menu, placing the
   block, and the per-menu behaviour options.

## Where it lives in the admin menu

- The builder lives at **Structure → Mega Menu**
  (`/admin/structure/we-mega-menu`), which lists every menu with a **Config**
  action.
- You still edit the underlying menu links at **Structure → Menus**
  (`/admin/structure/menu`).
- You place the rendered menu at **Structure → Block layout**
  (`/admin/structure/block`).

## How to use it

1. Build or pick a menu under **Structure → Menus** and add the links you want.
2. Go to **Structure → Mega Menu**, click **Config** for that menu, and use the
   drag-and-drop builder to arrange dropdown columns, drop in blocks, and set the
   menu's behaviour.
3. Place the matching **Mega Menu** block into a region (e.g. the header) under
   **Structure → Block layout**.

See [Configuration](configuration/index.md) for the details of each step.
