# Menu Formatter — manual setup guide

**Menu Formatter** (`menu_formatter`) provides a **"Rendered Menu"** field
formatter that turns an entity-reference field pointing at a menu into an actual,
rendered menu tree on the front end. It's the piece that lets editors attach a
real menu to a piece of content and have it display as navigation.

The problem it solves: you can already reference a menu (a configuration entity)
from a node or other entity, but by default Drupal only shows the menu's *label*.
Menu Formatter loads the referenced menu, builds its link tree, applies the
standard access manipulators, and renders it — so you get a genuine menu block's
worth of navigation, driven by a content field. This is ideal for per-landing-page
or per-section navigation chosen by editors, without writing custom blocks or PHP.

It renders through core's menu link tree with the usual **access checks**
(node access and menu-link access), so the output respects who is allowed to see
each link, exactly like a normal menu block. It is a **pure display plugin** — it
adds no routes, permissions, services, or writable state — so its security posture
is simply inherited from core's menu and node access. Its only requirement is
core's **Menu UI** (`menu_ui`) module.

Menu Formatter has **no configuration UI of its own**: everything is set up on a
field's *Manage display*, described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Menu UI dependency.

There is **no configuration page** for this module — it has no settings form. The
setup happens on your entity-reference field's display, described in "How to use
it" below.

## Where it lives in the admin menu

Menu Formatter adds no admin page. You use it entirely from **Structure → Content
types → *(bundle)* → Manage display** (or the Manage display of any fieldable
entity that references a menu).

## How to use it

1. Add an **Entity reference** field to your content type (or other entity) whose
   **target type is Menu** — so it references menu configuration entities.
2. On your content, reference one or more menus in that field (via autocomplete or
   a select list).
3. Go to that bundle's **Manage display** and set the field's format to
   **Rendered Menu**.
4. Tune the two formatter settings:
   - **Menu Min Depth** *(default 1)* — the first menu level to render. Set it to
     **1** to include the root level, or **2** to skip the root and start at the
     children.
   - **Menu Max Depth** *(default 2)* — the deepest level to render. Set it to
     **1** for a top-level-only menu.
5. Save the display and view your content — the referenced menu renders as a real,
   access-checked menu tree using your theme's menu templates.

> **Tip:** A multi-value reference field renders one menu per value, so you can
> compose several menus on a single page if needed.
