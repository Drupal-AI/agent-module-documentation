# Configuration

Menu Hide Parent is configured per menu: you tick the menus where you want empty
placeholder parents pruned. It does nothing until you enable it for at least one
menu.

## Choose which menus to clean up

1. Log in as a user with the **Administer Menu Hide Parent settings** permission
   (an administrator by default).
2. Go to **Configuration → User interface → Menu Hide Parent**
   (`/admin/config/user-interface/menu-hide-parent`).
3. **Check the menus** where you want the module to hide placeholder parent items
   that have no accessible children.
4. Click **Save configuration**.

From then on, in each enabled menu, a parent item that only groups children will
disappear for any user whose access checks leave it with no visible children — for
example, a *Create* or *Manager* header vanishes for a role that cannot create or
manage anything under it.

## Permission

The module provides a dedicated permission:

- **Administer Menu Hide Parent settings** — controls who can reach the settings
  form above. Grant it (under **People → Permissions**,
  `/admin/people/permissions`) only to trusted site builders.

## How it behaves

- It runs its pruning at **menu tree rebuild** time, not on every page load, so it
  is cache-safe and does not add per-request overhead.
- It adds **`user.roles`** as a cache context, so the pruned result is correct
  per role and cached separately for each.
- It respects role- and permission-based access, and is compatible with cached
  menu rendering and configuration-managed menus.

> **Note:** hiding an empty parent is a navigation-tidiness feature, not an access
> control. It only removes a parent that already has no children the user could
> reach — the children's own access rules are what determine visibility.
