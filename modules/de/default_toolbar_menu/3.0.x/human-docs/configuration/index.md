# Configuration

Setting up Default Toolbar Menu is a short sequence: create the toolbar menus you
want to offer, make sure each role can reach them, then map roles to menus on the
settings form.

## 1. Create one or more Toolbar Menus

Using the contributed **Toolbar Menu** module, create the toolbar menu(s) you
want to assign — for example a curated "Editorial" menu for content authors. Each
Toolbar Menu wraps an existing Drupal menu and exposes it in the admin toolbar.

## 2. Grant the necessary permissions

On **People → Permissions** (`/admin/people/permissions`):

- Give each role that should *receive* a custom menu the **access toolbar**
  permission, plus access to the specific toolbar menu it will be assigned. If a
  role cannot access the toolbar or its target menu, the menu will not attach.
- Give the trusted role(s) that will *manage the mapping* the **set default
  toolbar menu for roles** permission.

## 3. Map roles to menus

1. Go to **Configuration → User interface → Default Toolbar Menu**
   (`/admin/config/user-interface/toolbar_menu/setting`).
2. For each role, choose the toolbar menu it should default to from the select
   list.
3. Leave a role's selection blank to keep the default behavior for that role.
4. Click **Save**.

Note that the **administrator** role cannot be assigned a default menu — it keeps
core's standard Manage menu by design.

## When changes take effect

The chosen menu is applied when a user **logs in** — the module records the
selection for the user at login and the toolbar activates it on the pages they
view. If you change a role's mapping, affected users pick up the new menu on
their **next login** rather than immediately. If a menu does not appear, first
confirm the role has both **access toolbar** and access to that specific toolbar
menu; clearing caches after a mapping change can also help.

## Deploying the mapping

The mapping is stored in the `default_toolbar_menu.setting` configuration object,
so you can export it with your site configuration and deploy it across
environments like any other config.
