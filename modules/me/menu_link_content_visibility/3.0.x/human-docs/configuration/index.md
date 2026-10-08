# Configuration

There is no central settings page. You configure visibility **per custom menu
link**, right on its edit form.

## Set visibility on a menu link

1. Go to **Structure → Menus** (`/admin/structure/menu`) and edit the menu that
   contains your link (for example *Main navigation*).
2. Edit a **custom** link (one you added yourself — a `menu_link_content` link).
3. Scroll to the **Visibility** section. It is a set of vertical tabs, one per
   available condition — the same condition plugins that block visibility uses:
   **Request Path**, **Content types** (node type), **Roles** (user role),
   **Languages**, and so on.
4. Fill in one or more conditions. For example, open the **Roles** tab and tick
   *Administrator* to show the link only to administrators, or use **Request Path**
   to restrict it to `/` (the front page).
5. **Save** the link.

The link now appears in the rendered menu only when **all** the conditions you set
evaluate to true (AND logic). Conditions you leave at their defaults are ignored, so
you only need to fill in the ones you care about.

## How the evaluation works

At render time the module checks each condition against the current request. If any
condition denies — or a condition needs context that the current page can't provide
(for example a node-type condition on a non-node page) — the link is dropped from
the menu tree. On the menu administration screens themselves every link is always
shown, so you can still see and edit hidden links. Results are cached correctly: the
conditions' cache tags and contexts are merged in, and editing the link forces a
re-evaluation.

## Important: this hides links, it does not secure pages

This module decides only whether a **menu link appears** in the rendered menu. It
does **not** protect the destination page. Anyone who knows or guesses the URL can
still load the target unless that route or entity enforces its own access. Do not
use a hidden menu link as a security measure — always back it with real access
control (permissions, entity access, and so on). Think of this as tidying up
navigation for each audience, not as locking anything down.
