# Menu Item Visibility — manual setup guide

**Menu Item Visibility** (`menu_items_visibility`) lets you show or hide individual
menu links based on the visitor's user role — without cloning a whole menu per
audience. It adds a **Visibility settings** section to the edit form of every custom
menu link, where you tick the roles that should see the link. Leave every role
unticked and the link stays visible to everyone; tick one or more and only those
roles see it.

Typical uses are an "Admin dashboard" link shown only to administrators, a
"Members area" link hidden from anonymous visitors, or a "Register" link that
disappears once someone logs in. Because the preprocessor walks the whole menu
tree, it also hides child (submenu) links per role, so you can curate nested
navigation from a single menu.

The section also has an optional **Path Access** checkbox, meaningful only for links
that point at a **node**. Role-based hiding on its own is a *display* filter — it
removes the link from rendered menus but does not stop someone who knows the URL
from reaching the page. Turning on Path Access for a node link additionally
**denies access to that node** for the roles that fail the visibility check, so you
can both hide the link and block the destination.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Visibility settings fieldset on
   each menu link, field by field, and how the two options behave.

## Where it lives in the admin menu

There is **no central settings page**. You configure visibility on each menu link
at **Structure → Menus → [your menu] → Edit link**
(`/admin/structure/menu/manage/<menu>/link/<id>/edit`), or when adding a new custom
link. The settings you save are keyed to that specific link.
