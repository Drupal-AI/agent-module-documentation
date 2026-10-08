# Menu Admin per Menu — manual setup guide

**Menu Admin per Menu** (`menu_admin_per_menu`) lets you grant a role administration rights over *specific* menus, instead of the all‑or‑nothing core permission. Out of the box Drupal offers only a single **Administer menus and menu links** permission, and it hands whoever has it full control over *every* menu on the site. That is far too much power to give a content editor who only needs to manage, say, the Main navigation.

This module breaks that global permission down. For each menu that exists, it dynamically generates a matching **Administer *(menu label)* menu items** permission. So you can let an editor manage links in the Main navigation while leaving the Footer, the admin menu, and everything else untouched. Behind the scenes it filters the parent‑menu dropdowns on menu‑link and node forms down to the menus a user is allowed to touch, hides menu metadata fields (id, label, description, langcode) from users who lack full menu admin, controls access to menu link content entities, and re‑adds the "List links" and "Add link" operations on the menus overview for delegated users.

The module works as soon as you enable it — there is **no configuration page**. You use it purely by assigning the generated per‑menu permissions on the People → Permissions page. It requires core's **Menu UI** and **Menu Link Content** modules, both of which Drupal enables automatically as dependencies. For developers, a `menu_admin_per_menu.allowed_menus` service and a `hook_menu_admin_per_menu_get_permissions_alter()` hook let you compute or adjust a user's allowed menus in code, and an EntityReferenceSelection handler makes menu reference fields respect the same per‑menu rules.

This guide is written for a **human** clicking through the admin UI. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Menu Admin per Menu has no settings form of its own. Its whole job is to add extra **permissions**, so you configure it entirely on the permissions page.

1. **Create your menus first.** The per‑menu permissions are generated from the menus that actually exist. Whenever you add a new menu at **Structure → Menus → Add menu**, a new **Administer *(that menu)* menu items** permission appears automatically.

2. **Assign the per‑menu permissions.** Go to **People → Permissions** (`/admin/people/permissions`). Alongside core's **Administer menus and menu links**, you will find one **Administer *(menu label)* menu items** permission for every menu on the site. Tick the box for each role/menu combination you want to delegate — for example, give a "Footer editor" role the *Administer Footer menu items* permission only.

3. **Keep the core permission for real admins.** Leave **Administer menus and menu links** assigned only to trusted site administrators. That global permission still grants full control over all menus and bypasses the per‑menu checks.

What a per‑menu editor **can** do: add, edit, and delete links in their assigned menu, reach that menu's link overview, and use it as a parent when placing a link (including from the node form). What they **cannot** do: create, rename, or delete menus, edit menu metadata (those fields are hidden on the menu edit form), or manage any menu they have no matching permission for — those menus are filtered out of the parent‑menu dropdowns entirely.
