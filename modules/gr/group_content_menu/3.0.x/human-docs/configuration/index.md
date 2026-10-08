# Configuration

Setting up group menus takes three steps — define a menu **type**, enable the
**relation** on a group type, then let each group **manage** its menu — plus placing
a **block** to render it. Access is governed by a global permission and three
per-group permissions, covered at the end.

## 1. Define a menu type

A menu *type* is a reusable bundle for group menus (like "Main navigation" or
"Footer"). Go to **Structure → Group content menu types**
(`/admin/structure/group_content_menu_types`) and click **Add** to create one, giving
it a label and machine name. You can define several types if groups need more than
one menu (for example a main and a footer menu).

This page requires the **Administer group content menu types** permission and is the
module's main configuration screen.

## 2. Enable the relation on a group type

Group menus only appear on the group types you opt in. Go to a group type's content
configuration (**/admin/group/types/manage/{group_type}/content**) and install the
**Group content menu** relation (there is one derived per menu type you defined in
step 1).

The relation has a couple of convenient auto-create options:

- **Auto-create group menu** — automatically create a menu for a group the moment
  the group itself is created, so editors don't have to add one by hand.
- **Auto-create home link** (with a **home link title**) — add a starting "Home"
  link to that auto-created menu.

## 3. Manage a group's menu

Once the relation is enabled, each group exposes its menus at
**/group/{group}/menus**. From there group editors add the menus (if not
auto-created), then add, edit and reorder the menu links, all scoped to that one
group. The group's operations list also gains an **Edit group menus** action.
Editors can also drop a node into a group menu directly from the node edit form.

## 4. Render the menu — the Group Menu block

To show a group's menu on the page, place the **Group Menu** block (found under the
*Group Menus* category; there is one per menu type). It reads the current group from
context and renders that group's menu of the chosen type. The block has these
settings:

- **Starting level** — the menu level to start rendering from.
- **Maximum depth** — how many levels of the menu to show.
- **Expand all items** — render all child items expanded rather than only the active
  trail.
- **Relative visibility** — show the menu relative to the active item.
- **Theme hook suggestion** — an optional theme hook suggestion for custom theming.

## Permissions

Access is split between one site-wide permission and three group-level permissions.

**Global (assigned on the site permissions page):**

- **Administer group content menu types** — lets trusted admins define menu *types*
  at *Structure → Group content menu types*. Marked as a restricted/trusted
  permission.

**Per-group (assigned to group roles via the Group module's permission UI):**

- **Access group content menu overview** — view a group's menus overview at
  `/group/{group}/menus`.
- **Manage group content menu** — create, update and delete the menus within a group
  (restricted).
- **Manage group content menu menu items** — create, update and delete the links
  inside a group's menus.

A typical setup gives site admins the global permission to define types, and grants
group editors the three per-group permissions so each group can run its own
navigation. Route access is additionally guarded so that a menu or link must belong
to the group in the URL.
