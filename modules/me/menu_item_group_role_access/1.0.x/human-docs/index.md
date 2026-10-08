# Menu Item Group Role Access — manual setup guide

**Menu Item Group Role Access** (`menu_item_group_role_access`) lets you control
the **visibility of individual menu items by Group role**. It adds an optional
role field to menu items: a user who can edit a menu item picks which
[Group](https://www.drupal.org/project/group) roles are allowed to *see* that
link. It is useful when your navigation should differ by which group a user
belongs to and what role they hold there.

The problem it solves is menu tailoring: showing (or not showing) a menu link
depending on a user's group roles. It depends on core's **Menu Link Content**
(`menu_link_content`) and **Menu UI** (`menu_ui`) modules and on the contributed
**Group** (`group`) module, and it provides its own permissions.

Be precise about what this module governs: **whether a menu LINK is shown — not
access to the linked content.** Two points matter, and they are important enough
to get right before you rely on this module:

1. **Menu visibility is not a security boundary.** The target route or entity
   always enforces its own access, regardless of whether the menu link is shown.
   Hiding a menu item does not protect the target, and showing one does not grant
   access to it.
2. **The "overwrite target access" option can disclose restricted links.** The
   module offers an option to *ignore the access check of the menu target* — with
   it on, a user sees the menu item if their role is allowed by this module, even
   when they **cannot access the target**. Normally core hides links a user cannot
   reach; with this option on, the link appears but clicking it still yields the
   target's own access result (for example a 403). That can **reveal the existence
   and title** of content the user cannot open, so enable it deliberately and only
   where that disclosure is acceptable. It does **not** change target access.

Setting up the role rules and understanding that option is covered in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Group dependency.
2. [Configuration](configuration/index.md) — set which group roles see a menu
   item, and understand the "overwrite target access" option and its permissions.

## Where it lives in the admin menu

There is no standalone settings page. The controls live on the **menu-link edit
form** under **Structure → Menus** (`/admin/structure/menu`): edit a menu item and
you will find the role field (and the overwrite option) this module adds.
