# Multi Menu UI — manual setup guide

**Multi Menu UI** (`multi_menu_ui`, project machine name `multimenuui`) lets a
single node appear in **more than one menu**. Out of the box, Drupal's *Menu
settings* sidebar on the node form only lets you attach a page to one menu link.
This module extends that same sidebar so you can add additional menu links — for
example putting one page in both the main navigation and the footer menu, each
under a different parent.

It is careful to stay backwards‑compatible. The **primary** menu link (the first
one) is still handled entirely by core's Menu UI, so nothing changes about how your
existing links work. The **additional** links are stored in a per‑content‑type
field (`field_additional_menu_links`) and shown in the same sidebar, with an AJAX
**Add another menu link** button and a parent selector for each. Behind the
scenes a sync service mirrors those additional entries to real
`menu_link_content` entities, so they behave like ordinary menu links.

Turning it on for a content type is **opt‑in**: you tick a checkbox on the content
type's *Menu settings*, and the module auto‑creates the field for you. It adds no
routes, permissions, or public endpoints of its own — it works purely through
node‑form alterations and entity operations, so access follows your normal node
edit permissions. Disabling the module is safe: the primary link stays intact and
no data is lost.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its core dependencies.

There is **no central settings form** for this module. You enable it per content
type and then use it right on the node edit form, as described in "How to use it"
below.

## Where it lives in the admin menu

There is no dedicated admin page. You enable it on a content type at
**Structure → Content types → *(your type)* → Edit** (under **Menu settings**), and
you use it whenever you add or edit a node of that type.

## How to use it

1. Edit a content type at **Structure → Content types → *(your type)* → Edit**.
2. In the **Menu settings** section, tick **Enable additional menu links** (this
   auto‑creates the `field_additional_menu_links` field for that type). Save the
   content type.
3. Add or edit a node of that type. In the **Menu settings** sidebar you will see
   the usual primary menu link plus an **Add another menu link** button.
4. Click it to add each extra link, choosing the menu and parent for each one, then
   save the node. The page now appears in every menu you linked it to.
