# Views Menu Children Filter — manual setup guide

**Views Menu Children Filter** (`views_menu_children_filter`) adds a handful of new
handlers to Views so a View can list the **child pages of a node based on the site's
menu hierarchy** — not on an entity-reference "parent" field. If your site organises
content through the menu tree (a landing page with its sub-pages hung underneath it in
the Main navigation, say), this module lets you build a "child pages" or
"sub-navigation" listing that follows that structure automatically.

It contributes three things to Views: a **contextual filter (argument)** that
restricts a View to the nodes whose menu link sits directly under a given node's menu
link; a **sort** that orders results by the menu link's weight (the drag-and-drop
order editors set in the menu admin), then title; and a **filter** that keeps only
enabled (or only disabled) menu links. Behind the scenes all three share an internal
join between the node table and the menu-link table — you never configure that join
yourself; it just works when you add one of the handlers.

There are two things worth knowing up front. First, this only works for **node**
entities. Second, it only understands menu links created with the "entity" URI scheme
— the kind you get when you tick **Provide a menu link** on a node's own edit form —
not links typed in as an internal path. Beyond that, the module works the moment it is
enabled: there is **no settings form, no configuration page, no permissions, and no
Drush commands**. Everything lives inside the individual View you build. It depends
only on core's Views module.

This guide is written for a **human** building a View in the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact plugin ids, the
Views-data table/field keys, and how the internal join is wired — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no admin pages of its own. Its handlers appear inside the Views UI at
**Structure → Views** (`/admin/structure/views`) when you edit a View — as an
available contextual filter, sort, and filter on node-based Views. There is nothing to
configure globally.

## How to use it

Build a "children of this node" listing on a node-based View:

1. **Create or edit a node View.** At **Structure → Views**, make (or open) a View
   that shows Content (nodes). A block display placed on node pages is a common
   choice for a sidebar "sub-pages" list.
2. **Add the Menu children contextual filter.** In the View's **Advanced → Contextual
   filters**, add **Menu children**. Configure it to take the current node's ID — for
   a page-context block, "Content ID from URL" feeds it the node being viewed. The
   View is then limited to nodes whose menu link is a direct child of that node's menu
   link. Leave the argument empty (or pass `0`) to list top-level items — menu links
   with no parent.
   - Optionally set the argument's **Target menus** option to scope the results to one
     or more specific menus (for example only the Main navigation), so links in other
     menus are ignored.
   - Use **Hide view when the filter is not available** if you want the whole "child
     pages" block to disappear on nodes that have no menu-linked children.
3. **Order by menu weight.** In **Sort criteria**, add the **Menu children** sort so
   the results appear in the same order editors set by dragging items around in the
   menu admin, rather than by title or date.
4. **Show only enabled links (optional).** In **Filter criteria**, add the **Menu item
   enabled** filter and set it to enabled to hide administratively disabled menu
   items from end users — or set it to disabled to build an admin audit View of hidden
   links.

Because everything is stored in the View's own configuration, you can export and
deploy these Views like any other. For the precise handler ids and how they join to
the menu tables, see the [`agent/`](../agent/start.md) docs.
