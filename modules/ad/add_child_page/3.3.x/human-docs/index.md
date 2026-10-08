# Add Child Page — manual setup guide

**Add Child Page** (`add_child_page`) gives editors a quick way to build a
book‑like page hierarchy using Drupal's menus. On the content types you choose, it
adds an **Add Child Page** link (as an action, a tab, a button, or on the node view
page — you decide) to any node that appears in a menu. Following that link takes the
editor straight to the node add form with the new page's **menu parent already set**
to the current page, so sub‑pages nest correctly without anyone having to pick a menu
parent by hand each time.

It also adds a **Child Pages** listing that shows a node's existing menu children,
grouped per menu when a node sits in more than one, and lets you reorder them. When
an editor starts a child page, you can either default the child to the same content
type as its parent, force a single fixed type, or show a small chooser (optionally in
a modal) so the editor picks the type first.

Under the hood it is menu‑driven rather than a separate hierarchy: the parent/child
relationship is the menu link relationship, and actual page creation still goes
through Drupal's normal node add form, so your usual content‑create permissions and
workflow apply. The module requires the **Token** module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Token) and
   enable the module.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Add Child Page**
(`/admin/config/content/add-child-page`), gated by the core **Administer content
types** permission. The Add Child Page and Child Pages entry points themselves appear
on nodes of the content types you enable, for users who have the **Access add child
page** permission.

## How to use it

### 1. Configure the settings form

Open **Configuration → Content authoring → Add Child Page** and set:

- **Content types** — which content types show the feature (and pass its access
  check). Nothing happens until you tick at least one.
- **Show a content‑type selector** — when on, editors are asked which content type
  the child should be before it is created; when off, the child goes straight to a
  chosen type.
- **Use a default content type** / **Default content type** — when the selector is
  off, choose whether the child defaults to the **parent's** type (leave the default
  off) or to a **fixed** type you name here.
- **Show on node view / Show on node edit / Show as a tab / Show on the node form** —
  where the **Add Child Page** entry point appears: as an action link on the view
  page, on the edit page, as a primary tab, and/or as a button next to Save/Preview
  on the node form. (Show on node edit is on by default.)
- **Show the Child Pages tab** — whether nodes get the **Child Pages** listing of
  their menu children (on by default).

### 2. Make sure the parent is in a menu

The feature works on nodes that have a menu link. In the parent node's **Menu
settings**, add it to a menu. (If a node happens to be in several menus, the module
uses the first one and warns you.)

### 3. Create child pages

From the parent node, click **Add Child Page**. You land on the node add form with
the **Menu settings** already filled in — the new page is enabled in the menu, its
parent is the current page, and its weight is set to sort after existing siblings.
Fill in the rest of the page and save. Use the **Child Pages** tab to review and
reorder a node's children.

### Permissions

Grant **Access add child page** to the roles that should see the Add Child Page and
Child Pages entry points. This permission only exposes those entry points — it does
not bypass node create/edit or menu access, so normal content and menu permissions
still apply. The Child Pages listing additionally requires the core **Administer
menus** permission to reorder links.
