<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Item Group Role Access manages menu item access by group and role.

---

Menu Item Group Role Access **manages menu-item visibility by group and role** — letting admins decide which
roles/groups see which menu links, and optionally **overwrite the menu target's access check** (an option:
"ignore the access check of the menu target … the user will see the menu item, but only if the user's role is
allowed"). It depends on core Menu Link Content, Menu UI and the Group module, and provides its own permissions.

Use it to tailor menus per role/group. Understand precisely what it governs: **whether a menu LINK is shown**, not
access to the linked content. Two points matter. (1) Menu visibility is **not a security boundary** — the target
route/entity enforces its own access regardless, so hiding a menu item doesn't protect the target and showing one
doesn't grant access. (2) The **"overwrite internal link target access check"** option makes items visible even
when the user **cannot access the target** — normally core hides such links; with this on, the user sees the link
but clicking still yields the target's access result (e.g. 403). That can **disclose the existence/title** of
restricted content via the menu, so use it deliberately. It does not change target access. Configure the role/group
rules.

---

- Control menu-item visibility by role/group.
- Optionally overwrite the target access check.
- Tailor menus per role/group.
- Depend on Menu Link Content, Menu UI, Group.
- Provide its own permissions.
- Serve menu access config.
- Govern whether the LINK shows, not target access.
- NOT be a security boundary (target enforces its own access).
- DISCLOSE link/title of inaccessible content when 'overwrite target access' is on (click still 403s).
- Not change target access.
- Use the overwrite option deliberately.
- Configure the role/group rules.
- Handle menu access.
- Gate menu items.
- Configure the rules.
- Show/hide links.
- Handle the menu.
- Restrict menus.
- Not grant access.
- Provide menu-item role/group visibility.
