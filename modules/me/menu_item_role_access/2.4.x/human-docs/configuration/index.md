# Configuration

There are two sides to configuring this module: the per-link roles field you use
every day, and a small behavior settings form you'll rarely need to touch.

## Restricting a single menu link

1. Go to **Structure → Menus** and edit a menu link (for example
   `/admin/structure/menu/item/{id}/edit`).
2. On the form you'll see a **roles** field rendered as checkboxes — one box per
   role on your site.
3. Tick the roles that should see this link and **Save**.

Behavior:

- **One or more roles ticked** — the link shows only to users who hold at least
  one of those roles.
- **No roles ticked** — the link is unrestricted and shows to everyone (this is the
  default for every link).

If the behavior setting for inheritance (below) is on, you'll also see an
**Override children** checkbox on the form. Tick it to make this link's role
restriction apply to all of its child links as well.

Users with the core **Link to any page** permission always see every menu link,
regardless of the roles you set here.

## Visibility, not security

This module only controls whether a menu **link is displayed**. It does not
protect the destination page — route and page access are still governed by
Drupal's normal permission system. Two consequences worth remembering:

- A role you allow here will still not see the link if it lacks permission to view
  the target page — the core access check wins, unless you turn on the overwrite
  option below.
- Making a link visible here does not grant access to a page the role otherwise
  cannot reach.

## Behavior settings

For the two global behavior options:

1. Log in as a user with the **Administer Menu Item Role Access** permission.
2. Go to **Configuration → System → Menu Item Role Access Behaviour**, or navigate
   directly to `/admin/config/menu-item-role-access`.

Both options are **off** by default:

- **Overwrite internal link target access check** — when on, the role setting alone
  decides whether the link shows, ignoring the target page's own access check. Turn
  this on if you want a role to see a link even when it does not have permission to
  view the destination.
- **Inherit parent access** — when on, a parent link with its "Override children"
  checkbox ticked imposes its roles on all descendant links. A child link can still
  re-override its parent. Turning this on is also what makes the "Override children"
  checkbox appear on the menu link form.

Click **Save configuration** to apply. These two flags are stored as
configuration, so you can deploy them between environments.

## Permissions

At **People → Permissions** the module defines two permissions:

- **Edit Menu Item Role Access** (`edit menu_item_role_access`) — required to edit
  the roles field on a menu link. Grant it to trusted editors so they can restrict
  links without giving them full configuration access. Without it, the roles field
  is hidden on the form.
- **Administer Menu Item Role Access** (`administer menu_item_role_access`) —
  required to reach the behavior settings form.
