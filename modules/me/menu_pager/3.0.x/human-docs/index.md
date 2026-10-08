# Menu Pager — manual setup guide

**Menu Pager** (`menu_pager`) provides *previous* and *next* navigation based on the
order of links in a menu. It supplies a block, per menu, that shows a link to the
page before and the page after the current one — using the sequence you've already
laid out in the menu, not creation dates or any separate ordering.

The problem it solves is sequential reading. A handbook's chapters, a course's
lessons, a policy document's sections — each has an order somebody deliberately
chose, and that order is already expressed in the menu because that's how visitors
move through the section. Deriving previous/next from the menu means the pager and
the navigation always agree: reorder the menu and the pager follows automatically,
with nothing extra to maintain.

Under the hood it flattens the menu tree to work out which link comes before and
after the current page. By default it traverses the entire tree, but you can
optionally restrict it to links that share the same parent as the current page, so
the pager stays within a single section. It has no dependencies and provides a
developer API plus hooks to ignore certain paths (with built‑in support for Special
Menu Items and Menu Firstchild). On Drupal it can also use custom previous/next
labels and overridable templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module — you configure each pager as
a block, described in "How to use it" below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Menu Pager** block for the menu you want (there's one per menu) into
   a region of your theme.
3. In the block's configuration you can:
   - restrict previous/next to links that share the **same parent** as the current
     page (otherwise it traverses the whole menu tree);
   - set **custom labels** for the previous and next links.
4. Save the block. On any page that corresponds to a link in that menu, the block
   now shows previous/next navigation following the menu's order.

> **Note:** The pager only appears on pages that match a link in the chosen menu,
> since that's how it knows where you are in the sequence.
