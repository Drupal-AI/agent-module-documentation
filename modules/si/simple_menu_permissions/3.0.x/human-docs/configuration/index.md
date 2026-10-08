# Configuration

Simple Menu Permissions has **no settings form**. You "configure" it entirely by
assigning the permissions it generates. This page explains what those permissions
are and how to grant them.

## Where to assign permissions

Go to **People → Permissions** (`/admin/people/permissions`) and look for the
Simple Menu Permissions section. Tick the boxes for the roles you want, then
**Save permissions**. After granting or revoking permissions, rebuild the cache
(`drush cr`) so route and list changes take effect reliably.

## The global permission

- **Create new menu** — lets a role create brand‑new menus (it gates the "Add
  menu" form). Without it, a role can only work with menus that already exist.

## The six per‑menu permissions

For **every** menu on the site, the module generates six permissions. In the list
they read with the menu's human label (for a menu with machine name `main`, the
permission names are as below):

| Permission | What it controls |
|-----------|------------------|
| **View *(menu)* menu in menu list** (`view <id> menu in menu list`) | Whether the menu appears in the menus overview at **Structure → Menus** (`/admin/structure/menu`). |
| **Edit *(menu)* menu** (`edit <id> menu`) | Access to the menu's own edit form. |
| **Delete *(menu)* menu** (`delete <id> menu`) | Access to the menu's delete form. |
| **Add new links to *(menu)* menu** (`add new links to <id> menu`) | Access to the "Add link" form for that menu. |
| **Edit links in *(menu)* menu** (`edit links in <id> menu`) | Editing (and reordering) existing links in that menu. |
| **Delete links in *(menu)* menu** (`delete links in <id> menu`) | Deleting links in that menu. |

A fresh set of six appears automatically whenever a new menu is created, and each
one is tied to its menu — delete the menu and its permissions go away with it.

## Common delegation recipes

- **Let a role manage one menu's links, but not the menu itself:** grant *View*,
  *Add new links to*, and *Edit links in* — but not *Delete … menu* or *Delete
  links in*.
- **Read‑only delegation:** grant only *View … in menu list*.
- **Full delegation of a single menu:** grant all six per‑menu permissions for
  that one menu, and leave core's *Administer menus and menu links* off.
- **Reorder‑only editors:** grant *Edit links in* without *Add new links to* or
  *Delete links in*.

## Good to know

- Core's **Administer menus and menu links** (`administer menu`) permission still
  grants full control over every menu and bypasses all per‑menu checks — reserve
  it for true site administrators.
- On node and menu‑link forms, the parent‑menu dropdown is automatically filtered
  to only the menus a user may manage; if they select a menu they don't control,
  the menu fields are disabled and a message explains why.
