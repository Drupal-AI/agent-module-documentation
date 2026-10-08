# Configuration

Menu Level Permission does nothing until you configure it. Setup has two parts:
choose which menus and levels are protected on the settings form, then grant the
bypass permission to the users you trust with those top‑level links.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Menu level permissions**, or navigate
   directly to `/admin/config/user-interface/menu-level-permissions`.

## Choose the restricted menus

The form lists your site's menus (Main navigation, Footer, and any custom menus).
Tick each menu you want to protect. Only the menus you tick are affected; every
other menu keeps core's normal behavior. Leaving all menus unticked means the
module has no effect.

## Set the restricted levels (depth threshold)

Set how many levels, counting from the top, should be protected:

- **1** protects only the top‑level links (the items with no parent).
- **2** protects the top level *and* the level directly beneath it.
- Higher numbers protect progressively deeper into the tree.

A link's level is worked out by walking its parent chain — a top‑level link is
level 1, its child is level 2, and so on. Any link whose level is at or above the
threshold (that is, at the same depth or shallower) in a restricted menu becomes
protected. Links deeper than the threshold stay freely editable by anyone with the
usual menu permissions.

Click **Save configuration** when you're done.

## Grant the bypass permission

Protecting the links is only half the job — someone still needs to manage them.
Go to **People → Permissions** (`/admin/people/permissions`) and grant
**Administer restricted menu levels** to the roles you trust with top‑level
navigation. A user needs this permission *in addition to* the core **Administer
menus** permission (or a menu‑specific permission from Menu Admin per Menu) to edit
protected links.

## What editors experience

Once configured:

- Users **with** the bypass permission edit, move, and delete every link as usual.
- Users **without** it can still add and manage links below the threshold, but for
  protected links the menu widgets on the node form and menu‑edit form are disabled
  (with a read‑only notice), the "add child" action is removed under protected
  parents, and validation stops them creating or reparenting a link up into a
  restricted level.
- The protection is enforced at the route and entity level too: requesting a
  protected link's edit or delete URL directly returns *403 Forbidden* rather than
  quietly letting the change through.

> **Note:** This module governs **Menu Link Content** links — the custom links
> editors create. Menu links defined in code by modules or install profiles are not
> restricted in the same way.
