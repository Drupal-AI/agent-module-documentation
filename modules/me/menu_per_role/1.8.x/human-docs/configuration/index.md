# Configuration

There are two layers here: the actual **per‑link role restrictions** you set when
editing a menu link, and a **global settings form** that shapes how those
restrictions appear and who can bypass them. There are also three permissions.

## Set restrictions on a menu link

This is the core of the module. Edit any content menu link — under **Structure →
Menus** (`/admin/structure/menu`) → pick a menu → edit a link, or on a node's menu
settings — and you'll see one or two fieldsets of role checkboxes:

- **Roles able to see the menu link** — if you tick any roles here, the link is
  hidden from everyone *except* users who have at least one of them.
- **Roles not able to see the menu link** — if you tick any roles here, the link
  is hidden from anyone who has one of them.

The rules:

- **Leave both empty** → the link keeps its normal visibility (no restriction
  added).
- **A "show" role set** → the link is forbidden unless the user has one of those
  roles.
- **A "hide" role set** → the link is forbidden if the user has one of those
  roles.

You can combine both on one link for fine‑grained control. Remember this only
*restricts* — it never reveals a link a user couldn't otherwise reach.

> **Heads‑up:** if you later use the global settings to hide one of the checkbox
> sets, any selections already made in the hidden set still apply — they just
> become invisible in the form. Clear them before hiding the set if you don't want
> them enforced.

## Global settings form

Open **Configuration → System → Menu Per Role**
(`/admin/config/system/menu_per_role`). Reaching it requires the **Administer
menu_per_role** permission.

- **Which checkbox sets to display** (`hide_show`) — show *both* the "able to see"
  and "not able to see" sets (default), or simplify the editor UI by showing only
  the "hide from" set or only the "show to" set.
- **Show the role fields on links pointing to content** (`hide_on_content`) —
  controls whether the selectors appear on menu links that point at nodes. Options
  are **Always**, **Only if no Node Access modules are enabled**, or **Never**
  (the installed default is Never). This is useful when a Node Access module
  already governs who can reach the node itself.
- **Administrators bypass on the front end** (`admin_bypass_access_front`, off by
  default) — when on, admin users (UID 1 or a role flagged as admin) skip Menu Per
  Role checks in the *front‑end* context. Turn it **off** if you want admins to
  see the site exactly as restricted roles do, for accurate previews.
- **Administrators bypass in the admin area** (`admin_bypass_access_admin`, on by
  default) — the same, for the *admin* context.

Click **Save configuration** to apply. Settings live in the exportable
`menu_per_role.settings` config object; you can also set them with `drush
config:set`.

## Permissions

At **People → Permissions** the module defines three:

- **Administer menu_per_role** — access to the settings form above.
- **Bypass menu_per_role access (front)** — lets a *non‑admin* role see all menu
  links regardless of restrictions, in the front‑end context.
- **Bypass menu_per_role access (admin)** — the same, in the admin context.

Note the split: **admin** users are governed by the two "administrators bypass…"
settings on the form, while **non‑admin** users are governed by these two bypass
permissions. So the bypass permissions only affect users who aren't already
administrators — handy for a support or QA role that needs to preview every link.
