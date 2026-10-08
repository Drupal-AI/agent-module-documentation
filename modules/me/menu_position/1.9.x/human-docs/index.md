# Menu Position — manual setup guide

**Menu Position** (`menu_position`) lets you place the page a visitor is looking
at into a menu *dynamically*, using rules, instead of creating a separate menu
link for every node. You define ordered rules such as "every Article belongs
under the News menu item" or "any page under `/support/*` belongs under Support",
and the module highlights (or inserts the page beneath) the right menu item
automatically.

Because the effect works through Drupal's *active trail* — the mechanism that
decides which menu item is "current" — it reaches everywhere the active trail
does: the highlighted item in menu blocks, the expanded section of a sidebar
menu, and the breadcrumb trail. That makes it a clean way to fix breadcrumbs on
pages that are not in any menu, keep a section highlighted across a whole content
type, or give taxonomy-driven landing pages a consistent place in the navigation.

Each rule is stored as configuration (so it deploys with your other config), and
its matching logic is built from Drupal core's standard **condition plugins** —
content type, path, role, theme, language and any conditions other modules add.
You order the rules by drag-and-drop; the first matching rule wins for a given
menu. A single site-wide setting decides what "match" means: highlight the parent
menu item, insert the current page into the tree as a real child link, or do
nothing visual.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and order rules, choose their
   conditions, and set the global display mode.

## Where it lives in the admin menu

Once enabled, the rules list is at **Structure → Menu position rules**
(`/admin/structure/menu-position`), with **Add**, edit and delete forms, and a
**Settings** child page (`/admin/structure/menu-position/settings`) for the
global display mode. Managing rules requires the **Administer menu position
rules** permission; the settings page requires core's **Administer site
configuration**.

## How to use it

Create a rule that points at a parent menu item, give it one or more conditions
that describe which pages it should apply to, and save. Order your rules so the
most specific ones sit above broader ones. From then on, any page that matches a
rule takes on that menu position automatically. See
[Configuration](configuration/index.md) for the details.
