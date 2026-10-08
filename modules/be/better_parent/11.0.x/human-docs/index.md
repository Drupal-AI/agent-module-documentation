# Better Parent — manual setup guide

**Better Parent** (`better_parent`) improves one small but annoying part of the node
edit form: the **"Parent item"** dropdown in the menu settings. On sites with big,
deep menus, that dropdown becomes a long flat list of indented options that's
tedious to scroll through. Better Parent turns it into a collapsible, browsable
**tree** so editors can expand and collapse branches and pick the right parent
quickly.

It is a tiny, front-end-only enhancement. There is **no configuration, no
permissions, no settings page, and no PHP API** — enabling the module is the entire
setup. It has no dependencies beyond core's jQuery. It works by progressively
enhancing the existing form control on the client side: it adds a "(browse)" toggle
next to the native menu-parent select, and clicking it swaps the flat dropdown for a
nested, expandable list. A "(select)" toggle flips you back to the standard control,
so the native `<select>` (and its accessibility/fallback behaviour) is always
available. Under the hood the underlying select still holds the value, so no menu
data or core behaviour changes.

Because it only enhances a form element that is already on the page, it does nothing
on forms that don't have a menu-parent select — it simply stays out of the way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

## Where it lives in the admin menu

Nowhere — there is no settings page. The enhancement appears directly on the node
add/edit form, in the **Menu settings** section, next to the *Parent item* select.

## How to use it

There is nothing to configure. Once the module is enabled:

1. Edit or create a node and open its **Menu settings**.
2. Next to the **Parent item** dropdown you'll see a **(browse)** link. Click it to
   replace the flat list with an expandable menu tree.
3. Expand and collapse branches to find the parent you want, then click it to select
   it. The toggle flips to **(select)**, and the standard dropdown reappears holding
   your choice.

If you want to restyle the tree, the module ships `better_parent.css` you can
override in your theme.
