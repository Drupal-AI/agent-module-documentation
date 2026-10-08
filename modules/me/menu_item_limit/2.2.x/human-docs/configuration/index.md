# Configuration

Menu Item Limit has no settings page of its own. The limit is a single field on
each menu's edit form, so you configure it menu by menu.

## Set a menu's item limit

1. Log in as an administrator and go to **Structure → Menus**
   (`/admin/structure/menu`).
2. Click **Edit menu** on the menu you want to cap
   (`/admin/structure/menu/manage/<menu>`).
3. In the **Item Limitation** field, enter the maximum number of links the menu may
   hold:
   - **`0`** (the default, or leaving it empty) means **unlimited**.
   - Any **positive integer** caps the menu at that many links. The field only
     accepts values of 0 or higher.
4. Click **Save**.

## What happens when a menu is full

The cap is enforced when someone adds a **new** link to the menu. If the menu
already holds as many links as the limit allows, the save is rejected with the
error *"New link cannot be added because the menu item limit has been reached."*
Existing links are unaffected — the check only fires on newly created links, so
editing or reordering the links already in the menu always works.

## Changing or removing a limit

Raise or lower the cap any time by editing the same **Item Limitation** field and
saving. Set it back to `0` to make the menu unlimited again.

## Deploying limits

The limit for each menu is stored in configuration keyed by the menu's machine
name, so it exports and imports with the rest of your site configuration. That
lets you define menu‑size rules in one environment and deploy them to others like
any other config, which is handy for keeping menu sizes consistent across a
multisite.

## Scope note

The cap applies to menu links added through the UI (the content menu links Drupal
calls `menu_link_content`). Links that modules provide in code are not counted or
blocked by this limit.
